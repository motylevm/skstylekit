//
//    Copyright (c) 2016 Mikhail Motylev https://twitter.com/mikhail_motylev
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of
//    this software and associated documentation files (the "Software"), to deal in
//    the Software without restriction, including without limitation the rights to
//    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//    the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

public class StyleKit: NSObject {
    
    internal static var sharedInstance: StyleKit?
    
    private(set) var styles: [String: SKStyle]
    private(set) var configuration: StyleKitConfiguration
    private var onceLoggedMessages: Set<String> = []

    // MARK: - Init
    init(withConfiguration configuration: StyleKitConfiguration) {
        
        self.configuration = configuration
        self.styles = [:]
        
        super.init()
        
        loadStyles()
    }
    
    private func loadStyles() {
        
        for provider in styleSourceProviders() {
            
            for (name, source) in provider.source {
                
                guard let source = source as? [String: Any] else { continue }
                guard let newStyle = configuration.factory.style(withSource: source, name: name) else { continue }
                
                styles[name] = newStyle
                newStyle.aliases?.forEach({
                    styles[$0] = newStyle
                })
            }
        }
        
        for (_, style) in styles {
            populateParents(inStyle: style)
        }
        
        for (_, style) in styles {
            populateParams(inStyle: style)
        }
        
        for (_, style) in styles {
            style.updateSourceFlags()
        }
        
        NotificationCenter.default.post(name: .SKStyleKitDidLoadStyles, object: nil)
    }
    
    private func populateParents(inStyle style: SKStyle) {
        guard !style.isParentsPopulated else { return }
        
        do {
            try style.populateParents(fromProvider: self)
        } catch SKError.styleHaveCircularReference(let name) {
            StyleKit.log("Style kit error: style  \(name) referencing to itself")
        } catch SKError.styleParentNotFound(let parentStyle) {
            StyleKit.log("Style kit error: style \(style.name) parent \(parentStyle) not found")
        } catch {
            StyleKit.log("Style kit error: error resolving hierarchy for style \(style.name)")
        }
    }
    
    private func populateParams(inStyle style: SKStyle) {
        guard !style.isParamsPopulated else { return }
        
        do {
            try style.populateParams(fromProvider: self)
        } catch SKError.styleHaveCircularReference(let name) {
            StyleKit.log("Style kit error: style  \(name) referencing to itself")
        } catch SKError.styleParentNotFound(let parentStyle) {
            StyleKit.log("Style kit error: style \(style.name) parent \(parentStyle) not found")
        } catch {
            StyleKit.log("Style kit error: error resolving hierarchy for param in style \(style.name)")
        }
    }
    
    // MARK: - Init helpers
    func styleSourceProviders() -> [SKStylesSourceProvider] {
        
        var result = (Bundle.allBundles + Bundle.allFrameworks).flatMap({ styleSourceProviders(forBundle: $0) })
        
        if let userFiles = configuration.styleFiles {
            result += userFiles.flatMap({ SKStylesSource(filePath: $0, sourceType: .main) })
        }
        
        result.sort { (s1, s2) -> Bool in
            return s1.isOrderedBefore(otherSource: s2)
        }
        
        return result.map({ $0 as SKStylesSourceProvider })
    }
    
    func styleSourceProviders(forBundle bundle: Bundle) -> [SKStylesSource] {
        
        let type = SKStylesSource.sourceType(forBundle: bundle)
        
        let allowLoad: Bool
        
        switch type {
            
            case .main: allowLoad = configuration.loadApplicationStyles
            case .other: allowLoad = configuration.loadFrameworkStyles
            case .styleKit: allowLoad = configuration.loadDefaultStyles
        }
        
        guard allowLoad else { return [] }
        
        return styleFiles(forBundle: bundle).flatMap({ SKStylesSource(filePath: $0, sourceType: type) })
    }
    
    func styleFiles(forBundle bundle: Bundle) -> [String] {
        guard let files = try? FileManager.default.contentsOfDirectory(atPath: bundle.bundlePath) else { return [] }
        
        return files.filter({ $0.hasPrefix("style") && $0.hasSuffix(".json") }).flatMap({ bundle.path(forResource: $0, ofType: nil) })
    }
    
    // MARK: - Logging
    class func log(_ message: String, onlyOnce: Bool = false) {
        
        if sharedInstance == nil || sharedInstance?.configuration.suppressLogMessages == false {
            
            if !onlyOnce || sharedInstance?.onceLoggedMessages.contains(message) == false {
                
                if onlyOnce {
                    sharedInstance?.onceLoggedMessages.insert(message)
                }
                NSLog(message)
            }
        }
    }
}

// Internal extension
extension StyleKit: SKStylesProvider {
    
    // MARK: - SKStylesProvider
    internal func style(withName name: String?) -> SKStyle? {
        guard let name = name else { return nil }
       
        if let result = styles[name] {
            return result
        }
        
        return complexStyle(withName: name)
    }
    
    // MARK: - Complex style resolving
    func complexStyle(withName name: String) -> SKStyle? {
        
        let names = name.components(separatedBy: CharacterSet(charactersIn: ",+*;"))
        guard names.count > 1 else { return nil }
        
        let styleComponents = names.flatMap({ styles[$0] })
        guard styleComponents.count == names.count else { return nil }
        
        return complexStyle(withStyles: styleComponents, name: name)
    }
    
    func complexStyle(withStyles styles: [SKStyle], name: String) -> SKStyle? {
        return configuration.factory.style(withSource: SKStyle.concat(styleSources: styles.map({ $0.source })), name: name)
    }
}
