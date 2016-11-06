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

public extension SKStyle {

    // MARK: - UILabel
    public func apply(label: UILabel?, text: String?) {
        
        apply(view: label)
        
        label?.attributedText = StyleKit.string(withStyle: self,
                                                string: text,
                                                defaultParagraphStyle: label?.sk_defaultParagraphStyle())
        
        if let textAlignment = textAlignment {
            label?.textAlignment = textAlignment
        }
    }
    
    /*func checkIfContainsLabelCommonStyle() -> Bool {
        return fontColor != nil || textAlignment != nil || font() != nil
    }
    
    func checkIfContainsLabelAdvancedStyle() -> Bool {
        return fontKern != nil || textUnderline != nil || paragraphStyle() != nil
    }*/
}
