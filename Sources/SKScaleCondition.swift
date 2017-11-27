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

final class SKScaleCondition: SKCondition {
    
    // MARK: - Properties
    private(set) var reverse: Bool = false
    private(set) var scale: CGFloat
    
    // MARK: - Init
    init?(string: String) {
        guard string.hasSuffix("x") else { return nil }
  
        var processedString = String(string[..<string.index(before: string.endIndex)])

        if processedString.hasPrefix("!") {
            
            reverse = true
            processedString = String(processedString[string.index(after: string.startIndex)...])
        }
        
        if let scale = NumberFormatter().number(from: processedString) as? CGFloat {
            self.scale = scale
        } else {
            return nil
        }
    }
    
    // MARK: - SKCondition
    func check() -> Bool {
        
        let result = UIScreen.main.scale == scale
        return reverse ? !result : result
    }
    
    var groupKey: String {
        return "scale"
    }
    
    // MARK: - CustomStringConvertible
    var description: String {
        return "\(reverse ? "!" : "")\(scale)x"
    }
}
