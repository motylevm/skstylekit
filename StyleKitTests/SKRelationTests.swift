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

class SKRelationTests: XCTestCase {
    
    func testFactory() {
        
        // given
        let rawStrings = ["", "=", "==", ">", ">=", "<", "<=", "!=", "!", "<>"]
        let expected: [SKRelation] = [.equal, .equal, .equal, .greater, .greaternOrEqual, .less, .lessOrEqual, .notEqual, .notEqual, .notEqual]
        
        // when
        let result = rawStrings.flatMap { SKRelation.from($0) }
        
        // then
        XCTAssertEqual(result, expected)
    }
    
    func testFactoryFail() {
        
        // given
        let rawStrings = ["fsd", "===", "=>", "><"]
        
        // when
        let result = rawStrings.flatMap { SKRelation.from($0) }
        
        // then
        XCTAssertEqual(0, result.count)
    }
    
    func testCompare() {
        
        // given
        let relations: [SKRelation] = [.equal, .greater, .less, .greaternOrEqual, .lessOrEqual, .notEqual]
        
        let pairs: [(CGFloat, CGFloat)] = [(1, 2), (2, 1), (2, 2)]
        let expected: [[Bool]] = [
                                    /*equal*/           [false, false, true],
                                    /*greater*/         [false, true, false],
                                    /*less*/            [true, false, false],
                                    /*greaternOrEqual*/ [false, true, true],
                                    /*lessOrEqual*/     [true, false, true],
                                    /*notEqual*/        [true, true, false],
                                 ]
        
        // wheny
        let result = relations.map { relation -> [Bool] in
            return pairs.map { relation.compare(left: $0.0, right: $0.1) }
        }
        
        // then
        XCTAssertEqual(result.flatMap { $0 }, expected.flatMap { $0 })
    }
}
