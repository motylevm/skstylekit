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

class SKBaseConditionProcessorMock: SKBaseConditionProcessor {
    
    override func checkCondition(key: String) throws -> Bool {
        return true
    }
    
    override func checkParamWithCondition(key: String) throws -> (valid: Bool, param: String) {
        return (true, try super.checkParamWithCondition(key: key).param)
    }
}

class SKStylesSourcePreprocessorTests: XCTestCase {
    
    private var preprocessor: SKStylesSourcePreprocessor!
    
    override func setUp() {
        super.setUp()
        
        preprocessor = SKStylesSourcePreprocessor()
    }
    
    func testIsCategoryTrue() {
        
        // given
        let json = jsonFrom(named: "TestStyleJson1")!
        
        // when
        let ret = preprocessor.isCategory(source: json)
        
        // then
        XCTAssertTrue(ret)
    }
    
    func testIsCategoryFalse() {
        
        // given
        let json = jsonFrom(named: "TestStyleJson1")!["category1"] as! [String: Any]
        let sources = (1 ... 4).map({ "style\($0)" }).map({ json[$0] as! [String: Any] })
        
        // when
        let ret = sources.map({ preprocessor.isCategory(source: $0) })
        
        // then
        ret.forEach({
            XCTAssertFalse($0)
        })
    }
    
    func testProcessStyle() {
        
        // given
        let preprocessor = SKStylesSourcePreprocessor(conditionProcessor: SKBaseConditionProcessorMock())
        
        let json = jsonFrom(named: "TestStyleJson1")!["category1"] as! [String: Any]
        let sources = (1 ... 4).map({ "style\($0)" }).map({ json[$0] as! [String: Any] })
        
        let expectedJson = jsonFrom(named: "TestStyleJson1_AllConditionsTrue")!["category1"] as! [String: Any]
        let expected = (1 ... 4).map({ "style\($0)" }).map({ expectedJson[$0] as! [String: Any] })
        
        // when
        let processed = sources.map({ try! preprocessor.processStyle(source: $0) })
        
        // then
        XCTAssertEqual(expected as NSArray, processed as NSArray)
    }
    
    func testPreprocess() {
        
        // given
        let preprocessor = SKStylesSourcePreprocessor(conditionProcessor: SKBaseConditionProcessorMock())
        let json = jsonFrom(named: "TestStyleJson1")!
        let expected = jsonFrom(named: "PreprocessedTestStyle1")!
        
        //when
        let processed = try! preprocessor.preprocess(source: json)
        
        // then
        XCTAssertEqual(expected as NSDictionary, processed as NSDictionary)
    }
    
    func testPreprocessInvalidConditionException() {
        
        // given
        let json = jsonFrom(named: "styleInvalidCondition")!
        
        // when
        
        // then
        XCTAssertThrowsError(try preprocessor.preprocess(source: json))
    }
    
    func testPreprocessInvalidStructureException() {
        
        // given
        let json = jsonFrom(named: "styleInvalidStructure")!
        
        // when
        
        // then
        XCTAssertThrowsError(try preprocessor.preprocess(source: json))
    }
}
