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
    private(set) var isParentsPopulated: Bool = false
    private(set) var isParamsPopulated: Bool = false
    var flags: Int = 0

    // MARK: - Init
    public init(source: [String: Any], name: String) {
        super.init()
        
        self.name = name
        self.source = source
        self.aliases = source[aliasesKey] as? [String]
    }
    
    // MARK: - Properties get
    open func cgFloatValue(forKey key: String) -> CGFloat? {
        return (source[key] as? NSNumber).map({ CGFloat(truncating: $0) })
    }
    
    open func boolValue(forKey key: String) -> Bool? {
        return (source[key] as? NSNumber)?.boolValue
    }
    
    open func stringValue(forKey key: String) -> String? {
        return source[key] as? String
    }
    
    open func colorValue(forKey key: String) -> UIColor? {
        return SKColorCache.color(with: stringValue(forKey: key))
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
        
        if let parent = source[parentKey] as? String {
            return [parent]
        }
        
        if let parents = source[parentsKey] as? [String] {
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
        guard !isParentsPopulated else { return }
        
        let parentsStyles = try self.parentsStyles(fromProvider: provider, except: except)
        
        for parentsStyle in parentsStyles {
            guard !parentsStyle.isParentsPopulated else { continue }
            
            let parentExcept: [String] = except + [parentsStyle.name] + (parentsStyle.aliases ?? [])
            try parentsStyle.populateParents(fromProvider: provider, except: parentExcept)
        }
        
        let parentSources = parentsStyles.map({ $0.source })
        source = SKStyle.concat(styleSources: parentSources + [source])
        
        removeParentsLinks()
        isParentsPopulated = true
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
    
    func sourceStyle(key: String, fromProvider provider: SKStylesProvider, except: [String]) throws -> SKStyle? {
        guard let value = stringValue(forKey: key) else { return nil }
        
        guard !except.contains(value) else {
            throw SKError.styleHaveCircularReference(name)
        }
        
        return provider.style(withName: value)
    }
    
    func populatedParam(key: String, fromProvider provider: SKStylesProvider, except: [String]) throws -> Any? {
        guard let style = try sourceStyle(key: key, fromProvider: provider, except: except) else { return nil }
        
        if !style.isParamsPopulated {
            try style.populateParams(fromProvider: provider, except: except + [style.name] + (style.aliases ?? []))
        }
        
        if let value = style.source[key] {
            return value
        }
        
        return nil
    }
    
    func populateParams(fromProvider provider: SKStylesProvider, except: [String]) throws {
        guard !isParamsPopulated else { return }
        
        var newSource = source
        
        for (key, value) in source {
            
            guard key != parentKey && key != parentsKey else { continue }
            guard let value = value as? String else { continue }
            
            let forceValue = value.hasPrefix(forceParamValue)
        
            if forceValue {
                
                newSource[key] = String(value[value.index(after: value.startIndex)...])
                continue
            }
            
            if let newValue = try populatedParam(key: key, fromProvider: provider, except: except) {
                newSource[key] = newValue
            }
        }
        
        isParamsPopulated = true
        source = newSource
    }
    
    func populateParams(fromProvider provider: SKStylesProvider) throws {
        try populateParams(fromProvider: provider, except: [name] + (aliases ?? []))
    }
}
