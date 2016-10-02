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

class SKConditionMock: SKCondition {
    
    let result: Bool
    var groupKey: String
    
    init(result: Bool, groupKey: String) {
        
        self.result = result
        self.groupKey = groupKey
    }
    
    func check() -> Bool {
        return result
    }
    
    var description: String {
        return "\(result)"
    }
}

class SKConditionFactoryMock: SKConditionFactory {
    
    func conditionFromString(string: String) -> SKCondition? {
        
        let result = string.components(separatedBy: ":").first == "t" ? true : false
        let group = string.components(separatedBy: ":").last ?? ""
        
        return SKConditionMock(result: result, groupKey: group)
    }
}

class SKBaseConditionProcessorTests: XCTestCase {
    
    var processor: SKConditionProcessor!
    
    override func setUp() {
        super.setUp()
        
        processor = SKBaseConditionProcessor(factory: SKConditionFactoryMock())
    }

    func testIsCondition() {
   
        // given
        let strs = ["@2.0x", "@!4.0x@pad@car", "@phone", "phone", "2@tv"]
        let expected = [true, true, true, false, false]
        
        // when
        let isConditions = strs.map({ processor.isCondition(key: $0) })
        
        // then
        XCTAssertEqual(expected, isConditions)
    }
    
    func testIsParameterWithCondition() {
        
        // given
        let strs = ["fontSize@2.0x", "fontColor@!4.0x@pad@car", "@phone", "phone", "d@!2x"]
        let expected = [true, true, false, false, true]
        
        // when
        let isConditions = strs.map({ processor.isParamWithCondition(key: $0) })
        
        // then
        XCTAssertEqual(expected, isConditions)
    }
    
    func testComplexConditionTrue() {
        
        // given
        let str = "@T:g1@F:g1@T:g2@F:g2@T:g3@T:g3"
        
        // when
        let result = try? processor.checkCondition(key: str)
        
        // then
        XCTAssertEqual(result, true)
    }
    
    func testComplexConditionFalse() {
        
        // given
        let str = "@F:g1@F:g1@T:g2@F:g2@T:g3@T:g3"
        
        // when
        let result = try? processor.checkCondition(key: str)
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func testCheckParamWithCondition() {
        
        // given
        let str = "fontSize@ipad@2x"
        
        // when
        let result = try? SKBaseConditionProcessor().checkParamWithCondition(key: str)
        
        // then
        XCTAssertNotNil(result)
    }
}
