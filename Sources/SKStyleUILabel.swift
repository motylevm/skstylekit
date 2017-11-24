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

    // MARK: - UILabel -
    /**
        Applies style to a label
     
        - parameter label: Label to apply style to
        - parameter text: Text to set
    */
    public func apply(label: UILabel?, text: String?) {
        
        apply(view: label)
        
        if !checkFlag(flagLabelWasSet) {
            setLabelFlags()
        }
        
        guard checkFlag(flagLabelAny) else {
            
            label?.sk_setTextWithoutStyleApplication(text)
            return
        }
        
        // Set style using attributed string
        if checkFlag(flagLabelAdvanced) {
            
            label?.attributedText = StyleKit.string(withStyle: self,
                                                    string: text,
                                                    defaultParagraphStyle: label?.sk_defaultParagraphStyle())
            
            if let textAlignment = textAlignment {
                label?.textAlignment = textAlignment
            }
            
            return
        }
        
        // Set style using label properties only (2 times faster!)
        if checkFlag(flagLabelCommon) {
            
            if let fontColor = fontColor {
                label?.textColor = fontColor
            }
            
            if let textAlignment = textAlignment {
                label?.textAlignment = textAlignment
            }
            
            if let font = font() {
                label?.font = font
            }
            
            label?.sk_setTextWithoutStyleApplication(text)
        }
    }
    
    // MARK: - Set flags -
    func setLabelFlags() {
        
        if fontColor != nil || textAlignment != nil || font() != nil {
            setFlag(flagLabelCommon)
        }
        
        if fontKern != nil || textUnderline != nil || paragraphStyle() != nil || textStrikethrough != nil || textUnderline != nil {
            setFlag(flagLabelAdvanced)
        }

        setFlag(flagLabelWasSet)
    }
}
