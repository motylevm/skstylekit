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

class SKStyleTests: XCTestCase {
    
    func testStyleFloatValue() {
        
        // given
        let source: [String: Any] = ["cornerRadius": 1, "borderWidth": 2.2]
        let style = SKStyle(source: source, name: "")
        let expected: [CGFloat] = [1, 2.2]
        
        // when
        let ret: [CGFloat] = [style.cornerRadius!, style.borderWidth!]
        
        // then
        XCTAssertEqual(expected, ret)
    }
    
    func testStyleColorValue() {
        
        // given
        let source: [String: Any] = ["color": "#FFFFFF"]
        let style = SKStyle(source: source, name: "")
        let expected = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        // when
        let ret = style.color!
        
        // then
        XCTAssertEqual(expected, ret)
    }
    
    func testIsEqualToStyle() {
        
        // given 
        basicSetup()
        
        let style1 = StyleKit.style(withName: "viewStyle")
        let _style1 = StyleKit.style(withName: "viewStyle")!
        let style2 = StyleKit.style(withName: "labelStyle")
        let style3 = StyleKit.style(withName: "labelStyle")
        
        let nStyle1: SKStyle? = nil
        let nStyle2: SKStyle? = nil
        
        let e1 = StyleKit.style(withName: "equal1.eqLabelStyle")
        let e2 = StyleKit.style(withName: "equal2.eqLabelStyle")
        
        // then
        XCTAssertFalse(_style1.isEqual(toStyle: nil))
        
        XCTAssertTrue(style1 == style1)
        XCTAssertFalse(style1 == nil)
        XCTAssertFalse(style1 == style2)
        XCTAssertTrue(style2 == style3)
        XCTAssertFalse(style3 == style1)
        XCTAssertTrue(nStyle1 == nStyle2)
        XCTAssertFalse(e1 == e2)
    }
}
