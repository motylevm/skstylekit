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

class SKStylesSourceTests: XCTestCase {
    
    func testInitFromPath() {
        
        // given
        let path = Bundle(for: SKStylesSourceTests.self).path(forResource: "TestStyleJson1", ofType: "json")!
        
        // when
        let stylesSource = SKStylesSource(filePath: path, sourceType: .other)!
        
        // then
        XCTAssertTrue(stylesSource.source.count > 0)
    }
    
    func testSort() {
        
        // given
        let pathes = ["styleZIndexDefault", "styleZIndex10", "styleZIndex20"].flatMap({ Bundle(for: SKStylesSourceTests.self).path(forResource: $0, ofType: "json") })
        
        var array = pathes.flatMap({ SKStylesSource(filePath: $0, sourceType: .other) }) +
                    pathes.flatMap({ SKStylesSource(filePath: $0, sourceType: .main) }) +
                    pathes.flatMap({ SKStylesSource(filePath: $0, sourceType: .styleKit) })
        
        array.sort(by: { _,_ in arc4random() % 2 == 0 })
        
        
        
        // when
        let ret = array.sorted { (s1, s2) -> Bool in
            return s1.isOrderedBefore(otherSource: s2)
        }
        
        // then
        for i in 0 ..< 3 {
            
            XCTAssertEqual(ret[i].sourceType, .styleKit)
            XCTAssertEqual(ret[i].zIndex, i * 10)
            
            XCTAssertEqual(ret[i + 3].sourceType, .other)
            XCTAssertEqual(ret[i + 3].zIndex, i * 10)
            
            XCTAssertEqual(ret[i + 6].sourceType, .main)
            XCTAssertEqual(ret[i + 6].zIndex, i * 10)
        }
    }
}
