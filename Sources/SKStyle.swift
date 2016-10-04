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

open class SKStyle: NSObject {
    
    // MARK: - Stored Properties
    public private(set) var source: [String: Any] = [:]
    public private(set) var name: String = ""
    public private(set) var aliases: [String]?
    private(set) var wasPopulated: Bool = false
    
    // MARK: - Calculated Properties

    // MARK: - Init
    public init(source: [String: Any], name: String) {
        super.init()
        
        self.name = name
        self.source = source
        self.aliases = source[aliasesKey] as? [String]
    }
    
    // MARK: - Properties get
    open func cgFloatValue(forKey key: String) -> CGFloat? {
        return (styleValue(forKey: key) as? NSNumber).map({ CGFloat($0) })
    }
    
    open func floatValue(forKey key: String) -> Float? {
        return (styleValue(forKey: key) as? NSNumber)?.floatValue
    }

    open func stringValue(forKey key: String) -> String? {
        return styleValue(forKey: key) as? String
    }
    
    open func styleValue(forKey key: String) -> Any? {

        if let result = source[key] {
            return result
        }
        
        for alias in parametersAliases[key] ?? [] {
            
            if let result = source[alias] {
                return result
            }
        }
        
        return nil
    }
    
    // MARK: - Style apply
    func styleString(text: NSAttributedString?, range: NSRange? = nil, defaultParagraphStyle: NSParagraphStyle? = nil) -> NSAttributedString? {
        guard let text = text else { return nil }

        let result = NSMutableAttributedString(attributedString: text)
        
        var activeRange = range ?? NSRange(location: 0, length: result.length)
        
        if activeRange.location < 0 {
            activeRange.location = 0
        }
        
        if activeRange.location + activeRange.length > result.length {
            activeRange.length = result.length - activeRange.location
        }
        
        if let textAttributes = textAttributes(defaultParagraphStyle: defaultParagraphStyle) {
            result.addAttributes(textAttributes, range: activeRange)
        }
        
        return result
    }
    
    // MARK: - Hierarchy
    var parentLinks: [String] {
        
        if let parent = styleValue(forKey: parentKey) as? String {
            return [parent]
        }
        
        if let parents = styleValue(forKey: parentsKey) as? [String] {
            return parents
        }
        
        return []
    }
    
    func removeParentsLinks() {
        
        source.removeValue(forKey: parentsKey)
        source.removeValue(forKey: parentKey)
    }

    func parentsStyles(fromProvider provider: SKStylesProvider, except: [String]) throws -> [SKStyle] {
        
        let parentLinks = self.parentLinks
        
        for parentLink in parentLinks {
            
            if except.contains(parentLink) {
                throw SKError.styleHaveCircularReference(name)
            }
        }

        return try parentLinks.map({
        
            guard let style = provider.style(withName: $0) else {
                throw SKError.styleParentNotFound($0)
            }
        
            return style
        })
    }
    
    func populateParents(fromProvider provider: SKStylesProvider) throws {
        try populateParents(fromProvider: provider, except: [name] + (aliases ?? []))
    }
    
    func populateParents(fromProvider provider: SKStylesProvider, except: [String]) throws {
        guard !wasPopulated else { return }
        
        let parentsStyles = try self.parentsStyles(fromProvider: provider, except: except)
        
        for parentsStyle in parentsStyles {
            guard !parentsStyle.wasPopulated else { continue }
            
            let parentExcept: [String] = except + [parentsStyle.name] + (parentsStyle.aliases ?? [])
            try parentsStyle.populateParents(fromProvider: provider, except: parentExcept)
        }
        
        let parentSources = parentsStyles.map({ $0.source })
        source = SKStyle.concat(styleSources: parentSources + [source])
        
        removeParentsLinks()
        wasPopulated = true
    }
    
    class func concat(styleSources: [[String: Any]]) -> [String: Any] {
        
        var result = styleSources.first ?? [:]
        
        guard styleSources.count > 1 else { return result }
        
        for i in 1 ..< styleSources.count {
            
            for (key, value) in styleSources[i] {
                result[key] = value
            }
        }
        
        return result
    }
    
    func sourceStyle(key: String, fromProvider provider: SKStylesProvider) throws -> SKStyle? {
        
        guard let value = stringValue(forKey: key) else { return nil }
        guard let style = provider.style(withName: value) else { return nil }
        
        guard value != name else {
            throw SKError.styleHaveCircularReference(name)
        }
        
        return style
    }
    
    func populatedParam(key: String, fromProvider provider: SKStylesProvider) throws -> Any? {
        
        guard let style = try sourceStyle(key: key, fromProvider: provider) else { return nil }
        
        if let value = style.styleValue(forKey: key) {
            return value
        }
        
        return nil
    }
    
    func populateParams(fromProvider provider: SKStylesProvider) throws {
        
        for key in Array(source.keys) {
            
            guard key != parentKey && key != parentsKey else { continue }

            if let newValue = try populatedParam(key: key, fromProvider: provider) {
                source[key] = newValue
            }
        }
    }
}
