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


import XCTest
@testable import SKStyleKit

class SKButtonApplyMock: SKButton {
    
    var styleWasApplied: Bool = false
    
    override func applyCurrentStyle(includeTextStyle: Bool) {
        
        styleWasApplied = true
        super.applyCurrentStyle(includeTextStyle: includeTextStyle)
    }
}

class SKButtonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        basicSetup()
    }
    
    func testSetStyle() {
        
        // given
        let style = StyleKit.style(withName: "buttonNormal")
        let button = SKButton()
        button.setTitle(defString, for: .normal)
        
        // when
        button.style = style
        
        // then
        XCTAssertNotNil(style)
        
        XCTAssertEqual(button.styleName, "buttonNormal")
        XCTAssertNotNil(button.style)
        XCTAssertNil(button.highlightedStyle)
        XCTAssertNil(button.disabledStyle)
        XCTAssertNil(button.selectedStyle)
        XCTAssertNil(button.highlightedStyleName)
        XCTAssertNil(button.disabledStyleName)
        XCTAssertNil(button.selectedStyleName)

        checkStringStyle(button.attributedTitle(for: .normal), aligmentCheck: false)
        checkControlStyle(button)
        checkViewStyle(button)
    }
    
    func testSetStyleHighlighted() {
        
        // given
        let style = StyleKit.style(withName: "buttonNormal")
        let button = SKButton()
        button.setTitle(defString, for: .highlighted)
        
        // when
        button.highlightedStyle = style
        button.isHighlighted = true
        
        // then
        XCTAssertNotNil(style)
        
        XCTAssertEqual(button.highlightedStyleName, "buttonNormal")
        XCTAssertNotNil(button.highlightedStyle)
        XCTAssertNil(button.style)
        XCTAssertNil(button.disabledStyle)
        XCTAssertNil(button.selectedStyle)
        XCTAssertNil(button.styleName)
        XCTAssertNil(button.disabledStyleName)
        XCTAssertNil(button.selectedStyleName)
        
        checkStringStyle(button.attributedTitle(for: .highlighted), aligmentCheck: false)
        checkControlStyle(button)
        checkViewStyle(button)
    }
    
    func testSetStyleDisabled() {
        
        // given
        let style = StyleKit.style(withName: "buttonNormal")
        let button = SKButton()
        button.setTitle(defString, for: .disabled)
        
        // when
        button.disabledStyle = style
        button.isEnabled = false
        
        // then
        XCTAssertNotNil(style)
        
        XCTAssertEqual(button.disabledStyleName, "buttonNormal")
        XCTAssertNotNil(button.disabledStyle)
        XCTAssertNil(button.style)
        XCTAssertNil(button.highlightedStyle)
        XCTAssertNil(button.selectedStyle)
        XCTAssertNil(button.styleName)
        XCTAssertNil(button.highlightedStyleName)
        XCTAssertNil(button.selectedStyleName)
        
        checkStringStyle(button.attributedTitle(for: .disabled), aligmentCheck: false)
        checkControlStyle(button)
        checkViewStyle(button)
    }
    
    func testSetStyleSelected() {
        
        // given
        let style = StyleKit.style(withName: "buttonNormal")
        let button = SKButton()
        button.setTitle(defString, for: .selected)
        
        // when
        button.selectedStyle = style
        button.isSelected = true
        
        // then
        XCTAssertNotNil(style)
        
        XCTAssertEqual(button.selectedStyleName, "buttonNormal")
        XCTAssertNotNil(button.selectedStyle)
        XCTAssertNil(button.style)
        XCTAssertNil(button.highlightedStyle)
        XCTAssertNil(button.disabledStyle)
        XCTAssertNil(button.styleName)
        XCTAssertNil(button.highlightedStyleName)
        XCTAssertNil(button.disabledStyleName)
        
        checkStringStyle(button.attributedTitle(for: .selected), aligmentCheck: false)
        checkControlStyle(button)
        checkViewStyle(button)
    }
    
    func testSetTitleWithoutStyle() {
        
        // given
        let style = StyleKit.style(withName: "buttonNormal")
        let button = SKButtonApplyMock()
        button.set(style: style, forState: .normal)
        button.styleWasApplied = false
        
        // when
        button.sk_setTitleWithoutStyleApplication(defText, forState: .normal)
        
        // then
        XCTAssertEqual(defText, button.title(for: .normal))
        XCTAssertEqual(false, button.styleWasApplied)
    }
}
