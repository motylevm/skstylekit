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
@testable import StyleKit

class SKScaleConditionTests: XCTestCase {
    
    func testInit() {
        
        // given
        let str = "3x"
        
        // when
        let condition = SKScaleCondition(string: str)
        
        // then
        XCTAssertNotNil(condition)
        XCTAssertEqual(condition?.scale, 3)
        XCTAssertEqual(condition?.reverse, false)
    }
    
    func testInitReverse() {
        
        // given
        let str = "!2.5x"
        
        // when
        let condition = SKScaleCondition(string: str)
        
        // then
        XCTAssertNotNil(condition)
        XCTAssertEqual(condition?.scale, 2.5)
        XCTAssertEqual(condition?.reverse, true)
    }
    
    func testCondition() {
        
        // given
        let str = "\(UIScreen.main.scale)x"
        
        // when
        let condition = SKScaleCondition(string: str)!
        
        // then
        XCTAssertTrue(condition.check())
    }
    
    func testConditionReverse() {
        
        // given
        let str = "!\(UIScreen.main.scale)x"
        
        // when
        let condition = SKScaleCondition(string: str)!
        
        // then
        XCTAssertFalse(condition.check())
    }
}
