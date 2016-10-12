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

class SKTextFieldTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        basicSetup()
    }
    
    func testSetStyle() {
        
        // given
        let style = StyleKit.style(withName: "textFieldStyle")
        let textField = SKTextField()
        textField.text = "123456789"
        textField.placeholder = "987654321"
        
        // when
        textField.style = style
        
        // then
        XCTAssertNotNil(textField)
        XCTAssertEqual(textField.styleName, "textFieldStyle")
        checkViewStyle(textField)
        checkStringStyle(textField.attributedText)
    }
    
    func testSetStylePlaceholder() {
        
        // given
        let style = StyleKit.style(withName: "textFieldPlaceholderStyle")
        let textField = SKTextField()
        textField.text = "123456789"
        textField.placeholder = "987654321"
        
        // when
        textField.placeholderStyle = style
        
        // then
        XCTAssertNotNil(textField)
        XCTAssertEqual(textField.placeholderStyleName, "textFieldPlaceholderStyle")
        checkStringStyle(textField.attributedPlaceholder, aligmentCheck: false)
    }

}
