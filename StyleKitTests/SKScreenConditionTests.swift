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

func ==(left: SKScreenCondition, right: SKScreenCondition) -> Bool {
    return left.value == right.value && left.relation == right.relation && left.isHeightCondition == right.isHeightCondition
}

class SKScreenConditionTests: XCTestCase {
    
    func testInit() {
        
        // given
        let conditions = ["568h", "!320w", ">=3h", "<=350w"]
        
        // when
        let result = conditions.compactMap { SKScreenCondition(string: $0) }
        
        // then
        XCTAssertEqual(result.count, conditions.count)
        
        XCTAssertEqual(result[0].relation, .equal)
        XCTAssertEqual(result[0].value, 568)
        XCTAssertEqual(result[0].isHeightCondition, true)
        
        XCTAssertEqual(result[1].relation, .notEqual)
        XCTAssertEqual(result[1].value, 320)
        XCTAssertEqual(result[1].isHeightCondition, false)
        
        XCTAssertEqual(result[2].relation, .greaternOrEqual)
        XCTAssertEqual(result[2].value, 3)
        XCTAssertEqual(result[2].isHeightCondition, true)
        
        XCTAssertEqual(result[3].relation, .lessOrEqual)
        XCTAssertEqual(result[3].value, 350)
        XCTAssertEqual(result[3].isHeightCondition, false)
    }
    
    func testFailInit() {
        
        // given
        let conditions = ["==+568h", "!!320w", "><3h", "=>350w", "=350", "40"]
        
        // when
        let result = conditions.compactMap { SKScreenCondition(string: $0) }
        
        // then
        XCTAssertEqual(result.count, 0)
    }
    
    func testCondition() {
        
        // given
        let screenBounds = UIScreen.main.bounds
        let width = Int(screenBounds.width)
        let height = Int(screenBounds.height)
        
        let conditions = ["\(height)h", "\(width)w", "==\(height)h", "=\(width)w", "!\(height)h", "!=\(width)w", ">=\(height)h", "<=\(width)w", ">=\(height + 1)h", "<=\(width - 1)w"]
        let expected = [true, true, true, true, false, false, true, true, false, false]
        
        // when 
        let result = conditions.compactMap { SKScreenCondition(string: $0)?.check() }
        
        // then
        XCTAssertEqual(result, expected)
    }
    
    /*func testInit() {
        
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
    }*/

}
