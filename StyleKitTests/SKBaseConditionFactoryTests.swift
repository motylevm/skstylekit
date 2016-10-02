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

class SKConditionFactoryTests: XCTestCase {
    
    func testFactoryScale() {
        
        // given
        let str = "!2.0x"
        
        // when
        let condition = SKBaseConditionFactory().conditionFromString(string: str)

        // then
        XCTAssertNotNil(condition)
        XCTAssertTrue(condition is SKScaleCondition)
        XCTAssertEqual(String(describing: condition!), str)
    }
    
    func testDeviceCondition() {
     
        // given
        let str = "!pad"
        
        // when
        let condition = SKBaseConditionFactory().conditionFromString(string: str)
        
        // then
        XCTAssertNotNil(condition)
        XCTAssertTrue(condition is SKDeviceCondition)
        XCTAssertEqual(String(describing: condition!), str)
    }
    
    func testInvalid() {
        
        // given
        let strs = ["!", "4", "!2", "8", "pda"]
        
        // when
        let conditions = strs.map({ SKBaseConditionFactory().conditionFromString(string: $0) })
        
        // then
        conditions.forEach({
            XCTAssertNil($0)
        })
    }
}
