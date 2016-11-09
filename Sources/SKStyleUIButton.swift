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
    
    public func apply(button: UIButton?, title: String?, forState state: UIControlState) {
        
        apply(control: button)
        
        if button?.buttonType != UIButtonType.custom {
            StyleKit.log("Style kit warning: style support for non custom button types is limited, consider changing button type to custom", onlyOnce: true)
        }
        
        if let _ = textAlignment {
            StyleKit.log("Style kit warning: textAlignment have no effect on UIButton, use contentHorizontalAlignment instead", onlyOnce: true)
        }
        
        guard flags & labelAllFlags != 0 else {
            
            button?.sk_setTitleWithoutStyleApplication(title, forState: state)
            return
        }
        
        // Set style using attributed string
        if flags & labelAdvancedFlag != 0 {
            
            let styledTitle = StyleKit.string(withStyle: self, string: title, defaultParagraphStyle: button?.sk_defaultParagraphStyle())
            button?.setAttributedTitle(styledTitle, for: state)
        
            return
        }
        
        // Set style using label properties only (2 times faster!)
        if flags & labelCommonFlag != 0 {
            
            if let fontColor = fontColor {
                button?.setTitleColor(fontColor, for: state)
            }
            
            if let font = font() {
                button?.titleLabel?.font = font
            }
            
            button?.sk_setTitleWithoutStyleApplication(title, forState: state)
        }
    }
}
