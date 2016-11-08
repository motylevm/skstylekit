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

class SKLabelApplyMock: SKLabel {
    
    var styleWasApplied: Bool = false
    
    override func applyCurrentStyle(includeTextStyle: Bool) {
        
        styleWasApplied = true
        super.applyCurrentStyle(includeTextStyle: includeTextStyle)
    }
}

class SKLabelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        basicSetup()
    }
    
    func testSetStyle() {
        
        // given
        let style = StyleKit.style(withName: "labelStyle")
        let label = SKLabel()
        label.text = defString
        
        // when
        label.style = style
        
        // then
        XCTAssertNotNil(style)
        XCTAssertEqual(label.styleName, "labelStyle")
        
        checkStringStyle(label.attributedText)
        checkViewStyle(label)
    }
    
    func testSetStyleByName() {
        
        // given
        let label = SKLabel()
        label.text = defString
        
        // when
        label.styleName = "labelStyle"
        
        // then
        checkStringStyle(label.attributedText)
        checkViewStyle(label)
    }
    
    func testSetAttributedString() {
        
        // given
        let style = StyleKit.style(withName: "labelStyle")
        let label = SKLabel()
        let attrStr = NSAttributedString(string: defString)
        
        // when
        label.style = style
        label.attributedText = attrStr
        
        // then
        XCTAssertEqual(attrStr, label.attributedText)
    }
    
    func testSetSKLabelTextWithEmptyStyle() {
        
        // given
        let style = SKStyle(source: [:], name: "")
        let label = SKLabel()
        
        // when
        style.apply(label: label, text: defText)
        
        // then
        XCTAssertEqual(defText, label.text)
    }
    
    func testSetTextWithoutStyle() {
        
        // given
        let style = StyleKit.style(withName: "labelStyle")
        let label = SKLabelApplyMock()
        label.style = style
        label.styleWasApplied = false
        
        // when
        label.sk_setTextWithoutStyleApplication(defText)
        
        // then
        XCTAssertEqual(defText, label.text)
        XCTAssertEqual(false, label.styleWasApplied)
    }
}
