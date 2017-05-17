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
    
    // MARK: - UIView
    public func apply(view: UIView?) {
        
        if !checkFlag(flagViewWasSet) {
            setViewFlags()
        }
        
        guard checkFlag(flagViewAny) else { return }

        // Common
        if checkFlag(flagViewCommon) {
        
            if let alpha = alpha {
                view?.alpha = alpha
            }
            
            if let cornerRadius = cornerRadius {
                view?.layer.cornerRadius = cornerRadius
            }
        }
        
        // Border
        if checkFlag(flagViewBorder) {
            
            if let borderWidth = borderWidth {
                view?.layer.borderWidth = borderWidth
            }
            
            if let borderColor = borderColor {
                view?.layer.borderColor = borderColor.cgColor
            }
        }

        // Colors
        if checkFlag(flagViewBorder) {
            
            if let backgroundColor = backgroundColor {
                view?.backgroundColor = backgroundColor
            }
            
            if let tintColor = tintColor {
                view?.tintColor = tintColor
            }
        }
        
        // Shadow
        if checkFlag(flagViewShadow) {
            
            if let shadowRadius = shadowRadius {
                view?.layer.shadowRadius = shadowRadius
            }
            
            if let shadowOffset = shadowOffset {
                view?.layer.shadowOffset = shadowOffset
            }
            
            if let shadowColor = shadowColor {
                view?.layer.shadowColor = shadowColor.cgColor
            }
            
            if let shadowOpacity = shadowOpacity {
                view?.layer.shadowOpacity = Float(shadowOpacity)
            }
        }
    }
    
    // MARK: - Set flags
    func setViewFlags() {
        
        if alpha != nil || cornerRadius != nil {
            setFlag(flagViewCommon)
        }
        
        if borderWidth != nil || borderColor != nil {
            setFlag(flagViewBorder)
        }
        
        if backgroundColor != nil || tintColor != nil {
            setFlag(flagViewColor)
        }
        
        if shadowRadius != nil || shadowOffset != nil || shadowColor != nil || shadowOpacity != nil {
            setFlag(flagViewShadow)
        }
        
        setFlag(flagViewWasSet)
    }
}
