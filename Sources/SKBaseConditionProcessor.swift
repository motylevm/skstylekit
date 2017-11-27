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

private let conditionChar = "@"

class SKBaseConditionProcessor: SKConditionProcessor {
    
    // MARK: - Properties
    private let factory: SKConditionFactory
    
    // MARK: - Init
    init(factory: SKConditionFactory) {
        self.factory = factory
    }
    
    convenience init() {
        self.init(factory: SKBaseConditionFactory())
    }
    
    // MARK: - SKConditionProcessor
    func isCondition(key: String) -> Bool {
        return key.hasPrefix(conditionChar)
    }
    
    func checkCondition(key: String) throws -> Bool {
        
        guard isCondition(key: key) else {
            throw SKError.invalidCondition(key)
        }
        
        var conditions = try grouppedConditions(fromKey: key)
        
        for group in conditions.keys {
            
            if !checkConditions(group: conditions[group]!) {
                return false
            }
        }
        
        return true
    }
    
    func isParamWithCondition(key: String) -> Bool {
        
        if let pos = key.range(of: conditionChar), pos.lowerBound > key.startIndex {
            return true
        }
        return false
    }
    
    func checkParamWithCondition(key: String) throws -> (valid: Bool, param: String) {
        
        if let pos = key.range(of: conditionChar) {
            
            let param = String(key[..<pos.lowerBound])
            let condition = String(key[pos.lowerBound...])
            
            let valid = try checkCondition(key: condition)
            return (valid, param)
        }
        
        return (true, key)
    }
    
    // MARK: - Parsing/Checking
    private func conditionStrings(from string: String) -> [String] {
        return string.lowercased().trimmingCharacters(in: CharacterSet(charactersIn: conditionChar)).components(separatedBy: conditionChar)
    }
    
    private func grouppedConditions(fromKey key: String) throws -> [String: [SKCondition]]{
        
        var result = [String: [SKCondition]]()
        
        for conditionString in conditionStrings(from: key) {
            
            guard let condition = factory.conditionFromString(string: conditionString) else {
                throw SKError.invalidCondition(conditionString)
            }
            
            if let sameGroupConditions = result[condition.groupKey] {
                result[condition.groupKey] = sameGroupConditions + [condition]
            } else {
                result[condition.groupKey] = [condition]
            }
        }
        
        return result
    }
    
    private func checkConditions(group: [SKCondition]) -> Bool {
        
        for condition in group {
            
            if condition.check() {
                return true
            }
        }
        return false
    }
}
