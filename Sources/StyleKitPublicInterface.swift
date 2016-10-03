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

public extension StyleKit {
    
    // MARK: - Initialization
    public class func initStyleKit() {
        initStyleKit(withConfiguration: StyleKitConfiguration())
    }
    
    public class func initStyleKit(withConfiguration configuration: StyleKitConfiguration) {
        sharedInstance = StyleKit(withConfiguration: configuration)
    }
    
    public class func isInitialized() -> Bool {
        return sharedInstance != nil
    }
    
    // MARK: - Style methods
    public class func style(withName name: String?) -> SKStyle? {
        guard let name = name else { return nil }
 
        guard let styleKit = sharedInstance else {
            
            StyleKit.log("Style kit is not initialized, call initStyleKit()")
            return nil
        }
        
        guard let style = styleKit.style(withName: name) else {
            
            StyleKit.log("Style kit warning: style named \(name) not found")
            return nil
        }
        
        return style
    }
    
    public class func string(withStyle style: SKStyle?,
                             attributedString: NSAttributedString?,
                             range: NSRange? = nil,
                             defaultParagraphStyle: NSParagraphStyle? = nil) -> NSAttributedString? {
        
        return style?.styleString(text: attributedString, range: range, defaultParagraphStyle: defaultParagraphStyle) ?? attributedString
    }
    
    public class func string(withStyle style: SKStyle?,
                             string: String?,
                             range: NSRange? = nil,
                             defaultParagraphStyle: NSParagraphStyle? = nil) -> NSAttributedString? {
        
        let attributedString = string.map({ NSAttributedString(string: $0) })
        return style?.styleString(text: attributedString, range: range, defaultParagraphStyle: defaultParagraphStyle) ?? attributedString
    }
    
    public class func style(withStyles styles: [SKStyle]) -> SKStyle? {
        
        guard let styleKit = sharedInstance else {
            
            StyleKit.log("Style kit is not initialized, call initStyleKit()")
            return nil
        }
        
        return styleKit.complexStyle(withStyles: styles, name: styles.map({ $0.name }).joined(separator: "."))
    }
    
    // MARK: - Objective C Compatible methods
    @objc public class func objc_stringWithStyle(_ style: SKStyle?, attributedString: NSAttributedString?) -> NSAttributedString? {
        return StyleKit.string(withStyle: style, attributedString: attributedString)
    }
    
    @objc public class func objc_stringWithStyle(_ style: SKStyle?, attributedString: NSAttributedString?, range: NSRange) -> NSAttributedString? {
        return StyleKit.string(withStyle: style, attributedString: attributedString, range: range)
    }
    
    @objc public class func objc_stringWithStyle(_ style: SKStyle?, attributedString: NSAttributedString?, range: NSRange, defaultParagraphStyle: NSParagraphStyle?) -> NSAttributedString? {
        return StyleKit.string(withStyle: style, attributedString: attributedString, range: range, defaultParagraphStyle: defaultParagraphStyle)
    }
    
    @objc public class func objc_stringWithStyle(_ style: SKStyle?, string: String?) -> NSAttributedString? {
        return StyleKit.string(withStyle: style, string: string)
    }
    
    @objc public class func objc_stringWithStyle(_ style: SKStyle?, string: String?, range: NSRange) -> NSAttributedString? {
        return StyleKit.string(withStyle: style, string: string, range: range)
    }
    
    @objc public class func objc_stringWithStyle(_ style: SKStyle?, string: String?, range: NSRange, defaultParagraphStyle: NSParagraphStyle) -> NSAttributedString? {
        return StyleKit.string(withStyle: style, string: string, range: range, defaultParagraphStyle: defaultParagraphStyle)
    }
}
