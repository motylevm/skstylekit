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

open class SKTextField: UITextField {
    
    // MARK: - Private properties
    private var hasExternalAttributedText: Bool = false
    private var hasExternalAttributedPlaceholder: Bool = false
    
    // MARK: - Style properties
    @IBInspectable open var styleName: String? {
        
        get {
            return style?.name
        }
        
        set {
            style = StyleKit.style(withName: newValue)
        }
    }
    
    @IBInspectable open var placeholderStyleName: String? {
        
        get {
            return placeholderStyle?.name
        }
        
        set {
            placeholderStyle = StyleKit.style(withName: newValue)
        }
    }
    
    open var style: SKStyle? {
        
        didSet {
            applyCurrentStyle(includeTextStyle: !hasExternalAttributedText && text != nil)
        }
    }
    
    open var placeholderStyle: SKStyle? {
        
        didSet {
            
            if !hasExternalAttributedPlaceholder {
                applyCurrentPlaceholderStyle()
            }
        }
    }
    
    // MARK: - Style application
    private func applyCurrentStyle(includeTextStyle: Bool) {
        
        if includeTextStyle {
            
            sk_apply(text: text, withStyle: style)
            hasExternalAttributedText = false
        }
        else {
            sk_apply(viewStyle: style)
        }
    }
    
    private func applyCurrentPlaceholderStyle() {
        
        sk_apply(placeholderText: placeholder, withStyle: placeholderStyle)
        hasExternalAttributedPlaceholder = false
    }
    
    // MARK: - Overridden properties
    override open var text: String? {
        
        didSet {
            applyCurrentStyle(includeTextStyle: true)
        }
    }
    
    override open var attributedText: NSAttributedString? {
        
        didSet {
            hasExternalAttributedText = attributedText != nil
        }
    }
    
    override open var placeholder: String? {
        
        didSet {
            applyCurrentPlaceholderStyle()
        }
    }
    
    override open var attributedPlaceholder: NSAttributedString? {
        
        didSet {
            hasExternalAttributedPlaceholder = attributedPlaceholder != nil
        }
    }
}

