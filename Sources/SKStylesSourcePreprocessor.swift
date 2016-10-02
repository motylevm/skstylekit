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

import Foundation

class SKStylesSourcePreprocessor {
    
    // MARK: - Properties
    private let conditionProcessor: SKConditionProcessor
    
    // MARK: - Init
    init(conditionProcessor: SKConditionProcessor) {
        self.conditionProcessor = conditionProcessor
    }
    
    convenience init() {
        self.init(conditionProcessor: SKBaseConditionProcessor())
    }
    
    // MARK: - Processing
    func preprocess(source: [String: Any]) throws -> [String: Any] {
        return try processCategory(aliases: [], source: source)
    }
    
    func processCategory(aliases: [String], source: [String: Any]) throws -> [String: Any] {
        
        var result = [String: Any]()
        
        for (key, value) in source {
            
            guard let subSource = value as? [String: Any] else {
                
                if aliases.isEmpty {
                    
                    result[key] = value
                    continue
                }
                
                throw SKError.invalidStyleStructure(String(describing: source))
            }
            
            if isCategory(source: subSource) {
                
                let styles = try processCategory(aliases: aliases + [key], source: subSource)
                
                for (styleName, styleSource) in styles {
                    result[styleName] = styleSource
                }
                
                continue
            }
            
            guard !key.isEmpty else { continue } // No anonymous style allowed
            
            var styleSource = try processStyle(source: subSource)
            
            var styleAliases = [String]()
            var complexAllias = key
            
            for alias in aliases.reversed() {
                
                complexAllias = "\(alias).\(complexAllias)"
                styleAliases.append(complexAllias)
            }
            styleSource[aliasesKey] = styleAliases.count > 0 ? styleAliases : nil
        
            result[key] = styleSource
        }
        
        return result
    }
    
    func processStyle(source: [String: Any]) throws -> [String: Any] {
        
        var result = source
        
        for (key, value) in source {
            
            if conditionProcessor.isCondition(key: key) {
                
                result.removeValue(forKey: key)
                
                guard let conditionSource = value as? [String: Any] else {
                    throw SKError.invalidStyleStructure(String(describing: source))
                }
                
                let valid = try conditionProcessor.checkCondition(key: key)
                
                if valid {
                    
                    for (conditionalParam, conditionalParamValue) in try processStyle(source: conditionSource) {
                        result[conditionalParam] = conditionalParamValue
                    }
                }
                
                continue
            }
            
            if conditionProcessor.isParamWithCondition(key: key) {
                
                result.removeValue(forKey: key)
                
                let (valid, param) = try conditionProcessor.checkParamWithCondition(key: key)
                
                if valid {
                    result[param] = value
                }
            }
        }
        
        return result
    }
    
    func isCategory(source: [String: Any]) -> Bool {
        
        if let (key, value) = source.first {
            
            if conditionProcessor.isCondition(key: key) {
                return false
            }
            
            if value is [String: Any] {
                return true
            }
        }
        
        return false
    }
}
