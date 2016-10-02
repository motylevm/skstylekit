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

extension UIColor {

    class func sk_Color(fromHexString hexString: String?) -> UIColor? {
        guard let hexString = hexString else { return nil }
        
        var cString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        var cursorIndex = 0
        
        func nextDigit() -> CGFloat? {
            
            var result: CUnsignedInt = 0
            
            let range = cString.index(cString.startIndex, offsetBy: cursorIndex) ..< cString.index(cString.startIndex, offsetBy: cursorIndex + 2)
            let subString = cString.substring(with: range)
            
            let success = Scanner(string: subString).scanHexInt32(&result)
            cursorIndex += 2
            
            return success ? (CGFloat(result) / 255.0) : nil
        }
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.index(after: cString.startIndex))
        }
        
        // ARGB
        if cString.characters.count == 8 {
            
            if let a = nextDigit(),
               let r = nextDigit(),
               let g = nextDigit(),
               let b = nextDigit() {
            
                return UIColor(red: r, green: g, blue: b, alpha: a)
            }
            
            return nil
        }
        
        // RGB
        if cString.characters.count == 6 {
            
            if let r = nextDigit(),
               let g = nextDigit(),
               let b = nextDigit() {
                
                return UIColor(red: r, green: g, blue: b, alpha: 1)
            }
            
            return nil
        }
        
        return nil
    }
}
