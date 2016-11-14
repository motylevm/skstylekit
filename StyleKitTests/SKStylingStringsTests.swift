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

class SKStylingStringsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        basicSetup()
    }
    
    func testStyleString() {
        
        // given
        let style = StyleKit.style(withName: "labelStyle")
        let str = defString
        
        // when
        let attrString = StyleKit.string(withStyle: style, string: str)
        let attrStringObjC = StyleKit.objc_stringWithStyle(style, string: str)

        // then
        XCTAssertNotNil(style)
        XCTAssertEqual(str, attrString?.string)
        XCTAssertEqual(str, attrStringObjC?.string)
        checkStringStyle(attrString, aligmentCheck: false)
        checkStringStyle(attrStringObjC, aligmentCheck: false)
    }
    
    func testStyleAtrrString() {
        
        // given
        let style = StyleKit.style(withName: "labelStyle")
        let str = NSAttributedString(string: defString)
        
        // when
        let attrString = StyleKit.string(withStyle: style, attributedString: str)
        let attrStringObjC = StyleKit.objc_stringWithStyle(style, attributedString: str)
        
        // then
        XCTAssertNotNil(style)
        XCTAssertEqual(str.string, attrString?.string)
        XCTAssertEqual(str.string, attrStringObjC?.string)
        checkStringStyle(attrString, aligmentCheck: false)
        checkStringStyle(attrStringObjC, aligmentCheck: false)
    }
    
    func testStyleStringNoStyle() {
        
        // given
        let str = "any string"
        
        // when
        let string = StyleKit.string(withStyle: nil, string: str)
        let stringObjC = StyleKit.objc_stringWithStyle(nil, string: str)
        
        // then
        XCTAssertTrue(string == NSAttributedString(string: str))
        XCTAssertTrue(stringObjC == NSAttributedString(string: str))
    }
    
    func testStyleAtrrStringNoStyle() {
        
        // given
        let str = NSAttributedString(string: "any string")
        
        // when
        let attrString = StyleKit.string(withStyle: nil, attributedString: str)
        let attrStringObjC = StyleKit.objc_stringWithStyle(nil, attributedString: str)
        
        // then
        XCTAssertTrue(attrString === str)
        XCTAssertTrue(attrStringObjC === str)
    }
}
