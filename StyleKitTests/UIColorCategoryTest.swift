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
import XCTest
@testable import StyleKit

class UIColorCategoryTest: XCTestCase {


    func testSk_ColorWithHex_1() {
        
        // given
        let hex = "#ffffff"
        let standartColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        
        // when
        let color = UIColor.sk_Color(fromHexString: hex)
        
        // then
        XCTAssertEqual(standartColor, color)
    }
    
    func testSk_ColorWithHex_2() {
        
        // given
        let hex: String? = nil
        
        // when
        let color = UIColor.sk_Color(fromHexString: hex)
        
        // then
        XCTAssertNil(color)
    }
    
    func testSk_ColorWithHex_3() {
        
        // given
        let hex: String? = "00ff00"
        let standartColor: UIColor? = UIColor.init(red: 0, green: 1, blue: 0, alpha: 1)
        
        // when
        let color = UIColor.sk_Color(fromHexString: hex)
        
        // then
        XCTAssertEqual(standartColor, color)
    }
    
    func testSk_ColorWithHex_4() {
     
        // given
        let hex: String? = "#fdMfff"
        
        // when
        let color = UIColor.sk_Color(fromHexString: hex)
        
        // then
        XCTAssertNil(color)
    }
    
    func testSk_ColorWithHex_Alpha() {
        
        // given
        let hex: String? = "#0000ff00"
        
        // when
        let color = UIColor.sk_Color(fromHexString: hex)
        
        // then
        XCTAssertNotNil(color)
        
        var a: CGFloat = 0
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        
        color!.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        XCTAssertEqual(a, 0)
    }
}
