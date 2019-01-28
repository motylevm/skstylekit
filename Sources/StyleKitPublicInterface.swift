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
    
    // MARK: - Initialization -
    
    /**
        Initializes style kit with default configuration
    */
    public class func initStyleKit() {
        initStyleKit(withConfiguration: StyleKitConfiguration.defaultConfiguration())
    }
    
    /**
        Initializes style kit with given configuration
     
        - parameter withConfiguration: Configuration to initialize style kit with
    */
    public class func initStyleKit(withConfiguration configuration: StyleKitConfiguration) {
        sharedInstance = StyleKit(withConfiguration: configuration)
    }
    
    /**
        Flag to check style kit current state
    */
    public class func isInitialized() -> Bool {
        return sharedInstance != nil
    }
    
    /**
        Method to get all available styles

        - returns: All available styles
    */
    public class func allStyles() -> [SKStyle]? {
        guard let styles = sharedInstance?.styles else { return nil }
        
        var result = [SKStyle]()
        var includedNames = Set<String>()
        
        for (_, value) in styles {
            guard !includedNames.contains(value.name) else { continue }
            
            result.append(value)
            includedNames.insert(value.name)
        }
        
        return result.count > 0 ? result : nil
    }
    
    // MARK: - Style methods -
    /**
        Returns style for given name (if any)
     
        - parameter withName:
            Style name (can be short name or name with category(s) prefix
            Example: "myStyle" or "category1.myStyle"
     
        - returns: Style for given name or nil
    */
    public class func style(withName name: String?) -> SKStyle? {
        guard let name = name else { return nil }
 
        guard let styleKit = sharedInstance else {
            
            log("Style kit is not initialized, call initStyleKit()")
            return nil
        }
        
        guard let style = styleKit.style(withName: name) else {
            
            log("Style kit warning: style named \(name) not found")
            return nil
        }
        
        return style
    }
    
    /**
         Checks if style exists for given name
     
         - parameter withName:
            Style name (can be short name or name with category(s) prefix
            Example: "myStyle" or "category1.myStyle"
     
         - returns: true if style was found, false otherwise
     */
    public class func hasStyle(withName name: String?) -> Bool {
        guard let name = name else { return false }
        
        guard let styleKit = sharedInstance else {
            
            log("Style kit is not initialized, call initStyleKit()")
            return false
        }
        
        return styleKit.style(withName: name) != nil
    }
    
    /**
        Applies style to attributed string

        - parameter withStyle: Style to apply
        - parameter attributedString: String to apply style to
        - parameter range: Range in string to apply style, nil - apply to whole string (default nil)
        - parameter defaultParagraphStyle: Paragraph style to apply before applying style (mainly for internal purposes) (default nil)
     
        - returns: Styled attributed string
    */
    public class func string(withStyle style: SKStyle?,
                             attributedString: NSAttributedString?,
                             range: NSRange? = nil,
                             defaultParagraphStyle: NSParagraphStyle? = nil) -> NSAttributedString? {
        
        return style?.styleString(text: attributedString, range: range, defaultParagraphStyle: defaultParagraphStyle) ?? attributedString
    }
    
    /**
        Applies style to string
     
        - parameter withStyle: Style to apply
        - parameter string: String to apply style to
        - parameter range: Range in string to apply style, nil - apply to whole string (default nil)
        - parameter defaultParagraphStyle: Paragraph style to apply before applying style (mainly for internal purposes) (default nil)
     
        - returns: Styled attributed string
    */
    public class func string(withStyle style: SKStyle?,
                             string: String?,
                             range: NSRange? = nil,
                             defaultParagraphStyle: NSParagraphStyle? = nil) -> NSAttributedString? {
        
        let attributedString = string.map({ NSAttributedString(string: $0) })
        return style?.styleString(text: attributedString, range: range, defaultParagraphStyle: defaultParagraphStyle) ?? attributedString
    }
    
    /**
        Merges array of styles
     
        - parameter withStyles: Array of SKStyle objects
     
        - returns: Single SKStyle object, application of which gives the same result as application of styles from given array (in FIFO order)
    */
    public class func style(withStyles styles: [SKStyle]) -> SKStyle? {
        
        guard let styleKit = sharedInstance else {
            
            StyleKit.log("Style kit is not initialized, call initStyleKit()")
            return nil
        }
        
        return styleKit.complexStyle(withStyles: styles, name: styles.map({ $0.name }).joined(separator: "."))
    }
    
    // MARK: - Objective C Compatible methods -
    /**
        Applies style to string (Objective C compatible method)

        - parameter style: Style to apply
        - parameter attributedString: String to apply style to
     
        - returns: Styled attributed string
    */
    @objc public class func objc_stringWithStyle(_ style: SKStyle?, attributedString: NSAttributedString?) -> NSAttributedString? {
        return StyleKit.string(withStyle: style, attributedString: attributedString)
    }
    
    /**
        Applies style to string (Objective C compatible method)
     
        - parameter style: Style to apply
        - parameter attributedString: String to apply style to
        - parameter range: Range in string to apply style, nil - apply to whole string (default nil)
     
        - returns: Styled attributed string
    */
    @objc public class func objc_stringWithStyle(_ style: SKStyle?, attributedString: NSAttributedString?, range: NSRange) -> NSAttributedString? {
        return StyleKit.string(withStyle: style, attributedString: attributedString, range: range)
    }
    
    /**
        Applies style to string (Objective C compatible method)
     
        - parameter style: Style to apply
        - parameter attributedString: String to apply style to
        - parameter range: Range in string to apply style, nil - apply to whole string (default nil)
        - parameter defaultParagraphStyle: Paragraph style to apply before applying style (mainly for internal purposes) (default nil)
     
        - returns: Styled attributed string
    */
    @objc public class func objc_stringWithStyle(_ style: SKStyle?, attributedString: NSAttributedString?, range: NSRange, defaultParagraphStyle: NSParagraphStyle?) -> NSAttributedString? {
        return StyleKit.string(withStyle: style, attributedString: attributedString, range: range, defaultParagraphStyle: defaultParagraphStyle)
    }
    
    /**
         Applies style to string (Objective C compatible method)
     
         - parameter style: Style to apply
         - parameter string: String to apply style to
     
         - returns: Styled attributed string
    */
    @objc public class func objc_stringWithStyle(_ style: SKStyle?, string: String?) -> NSAttributedString? {
        return StyleKit.string(withStyle: style, string: string)
    }
    
    /**
        Applies style to string (Objective C compatible method)
     
        - parameter style: Style to apply
        - parameter string: String to apply style to
        - parameter range: Range in string to apply style, nil - apply to whole string (default nil)

        - returns: Styled attributed string
    */
    @objc public class func objc_stringWithStyle(_ style: SKStyle?, string: String?, range: NSRange) -> NSAttributedString? {
        return StyleKit.string(withStyle: style, string: string, range: range)
    }
    
    /**
        Applies style to string (Objective C compatible method)
     
        - parameter style: Style to apply
        - parameter string: String to apply style to
        - parameter range: Range in string to apply style, nil - apply to whole string (default nil)
        - parameter defaultParagraphStyle: Paragraph style to apply before applying style (mainly for internal purposes) (default nil)
     
        - returns: Styled attributed string
    */
    @objc public class func objc_stringWithStyle(_ style: SKStyle?, string: String?, range: NSRange, defaultParagraphStyle: NSParagraphStyle) -> NSAttributedString? {
        return StyleKit.string(withStyle: style, string: string, range: range, defaultParagraphStyle: defaultParagraphStyle)
    }
}
