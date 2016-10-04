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
    
    // MARK: - Abstract properties
    public var color: UIColor? {
        return UIColor.sk_Color(fromHexString: stringValue(forKey: #function))
    }
    
    public var size: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
   
    // MARK: - [View] Properties
    
    /// Background color, can be applied to any View
    public var backgroundColor: UIColor? {
        return UIColor.sk_Color(fromHexString: stringValue(forKey: #function))
    }
    
    /// Cackground radius, can be applied to any View
    public var cornerRadius: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Border width, can be applied to any View
    public var borderWidth: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Border color, can be applied to any View
    public var borderColor: UIColor? {
        return UIColor.sk_Color(fromHexString: stringValue(forKey: #function))
    }
    
    /// Alpha, can be applied to any View
    public var alpha: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Shadow radius, can be applied to any View
    public var shadowRadius: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Shadow offset, can be applied to any View
    public var shadowOffset: CGSize? {
        
        if let str = stringValue(forKey: #function) {
            return CGSizeFromString(str)
        }
        
        return nil
    }
    
    /// Tint color, can be applied to any View
    public var tintColor: UIColor? {
        return UIColor.sk_Color(fromHexString: stringValue(forKey: #function))
    }
    
    /// Shadow color, can be applied to any View
    public var shadowColor: UIColor? {
        return UIColor.sk_Color(fromHexString: stringValue(forKey: #function))
    }
    
    /// Shadow opacity, can be applied to any View
    public var shadowOpacity: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    // MARK: - [Control] Properties
    
    public var contentVerticalAlignment: UIControlContentVerticalAlignment? {
        return SKControlContentVerticalAlignment.from(rawValue: stringValue(forKey: #function))?.alignment
    }
    
    public var contentHorizontalAlignment: UIControlContentHorizontalAlignment? {
        return SKControlContentHorizontalAlignment.from(rawValue: stringValue(forKey: #function))?.alignment
    }
    
    // MARK: - [Switch] Properties
    
    /// On tint color, can be applied to Switch
    public var onTintColor: UIColor? {
        return UIColor.sk_Color(fromHexString: stringValue(forKey: #function))
    }
    
    /// Thumb tint color, can be applied to Switch
    public var thumbTintColor: UIColor? {
        return UIColor.sk_Color(fromHexString: stringValue(forKey: #function))
    }
    
    // MARK: - [Font] Properties
    
    /// Font name, can be applied to text containers (Label, TextField, TextView)
    public var fontName: String? {
        return stringValue(forKey: #function)
    }
    
    /// Font style, can be applied to text containers (Label, TextField, TextView)
    public var fontStyle: String? {
        return stringValue(forKey: #function)
    }
    
    /// Font size, can be applied to text containers (Label, TextField, TextView)
    public var fontSize: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Font color, can be applied to text containers (Label, TextField, TextView)
    public var fontColor: UIColor? {
        return UIColor.sk_Color(fromHexString: stringValue(forKey: #function))
    }
    
    /// Font kern, can be applied to text containers (Label, TextField, TextView)
    public var fontKern: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Font line spacing, can be applied to text containers (Label, TextField, TextView)
    public var fontLineSpacing: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Font line height multiplier, can be applied to text containers (Label, TextField, TextView)
    public var fontLineHeightMultiple: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Font minimum line height, can be applied to text containers (Label, TextField, TextView)
    public var fontMinimumLineHeight: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Font maximum line height, can be applied to text containers (Label, TextField, TextView)
    public var fontMaximumLineHeight: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    // MARK: - [Text] Properties
    
    /// Text aligment, can be applied to text containers (Label, TextField, TextView)
    public var textAlignment: NSTextAlignment? {
        return SKTextAlignment.from(rawValue: stringValue(forKey: #function))?.alignment
    }
    
    /// Text paragraph spacing, can be applied to text containers (Label, TextField, TextView)
    public var textParagraphSpacing: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Text paragraph first line head indent, can be applied to text containers (Label, TextField, TextView)
    public var textParagraphFirstLineHeadIndent: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Text paragraph head indent, can be applied to text containers (Label, TextField, TextView)
    public var textParagraphHeadIndent: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Text paragraph tail indent, can be applied to text containers (Label, TextField, TextView)
    public var textParagraphTailIndent: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Text paragraph spacing before, can be applied to text containers (Label, TextField, TextView)
    public var textParagraphSpacingBefore: CGFloat? {
        return cgFloatValue(forKey: #function)
    }
    
    /// Text hypernation factor, can be applied to text containers (Label, TextField, TextView)
    public var textHyphenationFactor: Float? {
        return floatValue(forKey: #function)
    }
    
    /// Text underline style, can be applied to text containers (Label, TextField, TextView)
    public var textUnderline: NSUnderlineStyle? {
        return SKUnderlineStyle.from(rawValue: styleValue(forKey: #function) as? String)?.style
    }
    
    /// Text underline pattern, can be applied to text containers (Label, TextField, TextView)
    public var textUnderlinePattern: NSUnderlineStyle? {
        return SKUnderlinePatternStyle.from(rawValue: stringValue(forKey: #function))?.style
    }
    
    // MARK: - Calculated text attributes
    public func font() -> UIFont? {
        
        guard fontName != nil || self.fontSize != nil || fontStyle != nil else {
            return nil
        }
        
        let fontSize = self.fontSize ?? UIFont.systemFontSize
        
        if let fontName = fontName {
            
            let fullFontName = (fontStyle == nil) ? fontName : "\(fontName)-\(fontStyle!)"
            let result: UIFont? = UIFont(name: fullFontName, size: fontSize)
            
            if result == nil {
                StyleKit.log("Style kit: No font with name \(fullFontName)")
            }
            
            return result
        }
        else {
            
            if let fontStyle = self.fontStyle {
            
                if let style = SKFontStyle.from(rawValue: fontStyle) {
                    return style.systemFont(ofSize: fontSize)
                } else {
                    StyleKit.log("Style kit: No system font with style \"\(fontStyle)\", using default style")
                }
            }

            return UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    private func paragraphStyle(defaultParagraphStyle: NSParagraphStyle? = nil) -> NSParagraphStyle? {
        
        var resultIsEmpty = true
        let result = (defaultParagraphStyle?.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()
        
        if let fontLineSpacing = fontLineSpacing {
            
            result.lineSpacing = fontLineSpacing
            resultIsEmpty = false
        }
        
        if let fontLineHeightMultiple = fontLineHeightMultiple {
            
            result.lineHeightMultiple = fontLineHeightMultiple
            resultIsEmpty = false
        }
        
        if let fontMinimumLineHeight = fontMinimumLineHeight {
            
            result.minimumLineHeight = fontMinimumLineHeight
            resultIsEmpty = false
        }
        
        if let fontMaximumLineHeight = fontMaximumLineHeight {
            
            result.maximumLineHeight = fontMaximumLineHeight
            resultIsEmpty = false
        }
        
        if let textParagraphSpacing = textParagraphSpacing {
            
            result.paragraphSpacing = textParagraphSpacing
            resultIsEmpty = false
        }
        
        if let textParagraphFirstLineHeadIndent = textParagraphFirstLineHeadIndent {
            
            result.firstLineHeadIndent = textParagraphFirstLineHeadIndent
            resultIsEmpty = false
        }
        
        if let textParagraphHeadIndent = textParagraphHeadIndent {
            
            result.headIndent = textParagraphHeadIndent
            resultIsEmpty = false
        }
        
        if let textParagraphTailIndent = textParagraphTailIndent {
            
            result.tailIndent = textParagraphTailIndent
            resultIsEmpty = false
        }
        
        if let textParagraphSpacingBefore = textParagraphSpacingBefore {
            
            result.paragraphSpacingBefore = textParagraphSpacingBefore
            resultIsEmpty = false
        }
        
        if let textHyphenationFactor = textHyphenationFactor {
            
            result.hyphenationFactor = textHyphenationFactor
            resultIsEmpty = false
        }
        
        return resultIsEmpty ? nil : result
    }
    
    public func textAttributes(defaultParagraphStyle: NSParagraphStyle? = nil) -> [String: Any]? {
        
        var result = [String: Any]()
        
        if let font = font() {
            result.updateValue(font, forKey: NSFontAttributeName)
        }
        
        if let fontColor = fontColor {
            result.updateValue(fontColor, forKey: NSForegroundColorAttributeName)
        }
        
        if let kern = fontKern {
            result.updateValue(kern, forKey: NSKernAttributeName)
        }
        
        if let paragraphStyle = paragraphStyle(defaultParagraphStyle: defaultParagraphStyle) {
            result.updateValue(paragraphStyle, forKey: NSParagraphStyleAttributeName)
        }
        
        if let underlineStyle = textUnderline {
            
            var value: [NSUnderlineStyle] = [underlineStyle]
            
            if let underlinePatternStyle = textUnderlinePattern {
                value.append(underlinePatternStyle)
            }
            
            result.updateValue(value.reduce(0, { $0 | $1.rawValue }), forKey: NSUnderlineStyleAttributeName)
        }
        
        return result.isEmpty ? nil : result
    }
}
