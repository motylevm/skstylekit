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

private var statePriorityChain: [UIControlState] = [.normal, .selected, .highlighted, .disabled]

open class SKButton: UIButton {
    
    // MARK: - Private properties
    private var hasExternalAttributedText = [UInt: Bool]()
    private var styles = [UInt: SKStyle]()
    var suppressStyleOnTextChange: Bool = false
    
    // MARK: - Style properties
    @IBInspectable open var styleName: String? {
        
        get {
            return style?.name
        }
        
        set {
            style = StyleKit.style(withName: newValue)
        }
    }
    
    @IBInspectable open var highlightedStyleName: String? {
        
        get {
            return highlightedStyle?.name
        }
        
        set {
            highlightedStyle = StyleKit.style(withName: newValue)
        }
    }
    
    @IBInspectable open var disabledStyleName: String? {
        
        get {
            return disabledStyle?.name
        }
        
        set {
            disabledStyle = StyleKit.style(withName: newValue)
        }
    }
    
    @IBInspectable open var selectedStyleName: String? {
        
        get {
            return selectedStyle?.name
        }
        
        set {
            selectedStyle = StyleKit.style(withName: newValue)
        }
    }
    
    open var style: SKStyle? {
        
        get {
            return style(forState: .normal)
        }
        
        set {
            
            if style(forState: .normal) != newValue {
                set(style: newValue, forState: .normal)
            }
        }
    }
    
    open var highlightedStyle: SKStyle? {
        
        get {
            return style(forState: .highlighted)
        }
        
        set {
            
            if style(forState: .highlighted) != newValue {
                set(style: newValue, forState: .highlighted)
            }
        }
    }
    
    open var disabledStyle: SKStyle? {
        
        get {
            return style(forState: .disabled)
        }
        
        set {
            
            if style(forState: .disabled) != newValue {
                set(style: newValue, forState: .disabled)
            }
        }
    }
    
    open var selectedStyle: SKStyle? {
        
        get {
            return style(forState: .selected)
        }
        
        set {
            
            if style(forState: .selected) != newValue {
                set(style: newValue, forState: .selected)
            }
        }
    }
    
    // MARK: - State change properties
    open override var isSelected: Bool {
        
        didSet {
            applyCurrentStyle()
        }
    }
    
    open override var isHighlighted: Bool {
        
        didSet {
            applyCurrentStyle()
        }
    }
    
    open override var isEnabled: Bool {
        
        didSet {
            applyCurrentStyle()
        }
    }
    
    // MARK: - Style get/set
    open func style(forState state: UIControlState) -> SKStyle? {
        return styles[state.rawValue]
    }
    
    open func set(style: SKStyle?, forState state: UIControlState) {
        
        if let style = style {
            styles.updateValue(style, forKey: state.rawValue)
        }
        else {
            styles.removeValue(forKey: state.rawValue)
        }
        
        self.applyCurrentStyle()
    }
    
    // MARK: - Style application
    func applyCurrentStyle() {
        
        let hasExternalAttributedText = self.hasExternalAttributedText[state.rawValue] ?? false
        let includeTextStyle = !hasExternalAttributedText && title(for: state) != nil
        
        self.applyCurrentStyle(includeTextStyle: includeTextStyle)
    }
    
    func applyCurrentStyle(includeTextStyle: Bool) {
        
        let style = StyleKit.style(withStyles: statePriorityChain.filter({ state.contains($0) }).compactMap({ self.style(forState: $0) }))
        
        if includeTextStyle {
            
            let title = self.title(for: state)
            style?.apply(button: self, title: title, forState: state)
            hasExternalAttributedText.updateValue(false, forKey: state.rawValue)
        }
        else {
            style?.apply(control: self)
        }
    }
    
    // MARK: - Overridden methods
    override open func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)
        
        if !suppressStyleOnTextChange {
            applyCurrentStyle(includeTextStyle: true)
        }
    }
    
    override open func setAttributedTitle(_ title: NSAttributedString?, for state: UIControlState) {
        super.setAttributedTitle(title, for: state)
        
        hasExternalAttributedText.updateValue(title != nil, forKey: state.rawValue)
    }
}

