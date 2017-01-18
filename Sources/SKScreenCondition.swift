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

private let screenConditionRegExp = try! NSRegularExpression(pattern: "([<>!=]*)([0-9]*)([hw])")

final class SKScreenCondition: SKCondition {
 
    // MARK: - Properties
    private(set) var value: CGFloat
    private(set) var isHeightCondition: Bool
    private(set) var relation: SKRelation
    
    // MARK: - Init
    init?(string: String) {
        
        let totalRange = NSRange(location: 0, length: string.characters.count)
        let matches = screenConditionRegExp.matches(in: string, range: totalRange)
        guard matches.count == 1, let match = matches.first, NSEqualRanges(match.range, totalRange) && match.numberOfRanges == 4 else { return nil }
        
        guard let relationString = string.sk_substring(with: match.rangeAt(1)) else { return nil }
        guard let valueString = string.sk_substring(with: match.rangeAt(2)) else { return nil }
        guard let dimensionString = string.sk_substring(with: match.rangeAt(3)) else { return nil }
        
        guard let relation = SKRelation.from(relationString) else { return nil }
        guard let value = Int(valueString) else { return nil }
    
        switch dimensionString {
            
            case "h": isHeightCondition = true
            case "w": isHeightCondition = false
            default: return nil
        }
        
        self.value = CGFloat(value)
        self.relation = relation
    }
    
    // MARK: - SKCondition
    func check() -> Bool {
        
        let left = isHeightCondition ? UIScreen.main.bounds.height : UIScreen.main.bounds.width
        return relation.compare(left: left, right: value)
    }
    
    var groupKey: String {
        return "screenSize"
    }
    
    // MARK: - CustomStringConvertible
    var description: String {
        return relation.rawValue + "\(Int(value))" + (isHeightCondition ? "h" : "w")
    }
}
