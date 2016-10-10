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

class SKStyleHierarchyTests: XCTestCase {
    
    func testParentLink() {
        
        // given
        let style = SKStyle(source: ["parent": "p1", "paretns": ["p2", "p3"]], name: "")
        let expected = ["p1"]

        // when
        let parentLinks = style.parentLinks
        
        // then
        XCTAssertEqual(parentLinks, expected)
    }
    
    func testParentLinks() {
        
        // given
        let style = SKStyle(source: ["parents": ["p2", "p3"]], name: "")
        let expected = ["p2", "p3"]
        
        // when
        let parentLinks = style.parentLinks
        
        // then
        XCTAssertEqual(parentLinks, expected)
    }
    
    func testRemoveParentLinks() {
        
        // given
        let style = SKStyle(source: ["parent": "p1", "parents": ["p2", "p3"]], name: "")
        let expected: [String] = []
        
        // when
        style.removeParentsLinks()
        
        // then
        XCTAssertEqual(style.parentLinks, expected)
    }
    
    func testParentStyles() {
        
        // given
        let style = SKStyle(source: ["parents": ["p2", "p3"]], name: "")
            
        // when 
        let parentsStyles = try! style.parentsStyles(fromProvider: SKStylesProviderMock(), except: [""])
        
        // then
        XCTAssertEqual(parentsStyles.count, 2)
        XCTAssertEqual(parentsStyles[0].name, "p2")
        XCTAssertEqual(parentsStyles[0].source["p1"] as? String, "p2")
        XCTAssertEqual(parentsStyles[1].name, "p3")
        XCTAssertEqual(parentsStyles[1].source["p1"] as? String, "p3")
    }
    
    func testParentStylesCycleRef() {
     
        // given
        let style = SKStyle(source: ["parent": "style1"], name: "style1")
        
        // when
        // then
        XCTAssertThrowsError(try style.parentsStyles(fromProvider: SKStylesProviderMock(), except: ["style1"]))
    }
    
    func testConcatSources() {
        
        // given
        let sources: [[String: Any]] = [["p1": 1, "p2": 2], ["p1": 3, "p3": 4]]
        let expected: [String: Any] = ["p1": 3, "p3": 4, "p2": 2]
        
        // when
        let source = SKStyle.concat(styleSources: sources)
        
        // then
        XCTAssertEqual(source as NSDictionary, expected as NSDictionary)
    }
    
    func testPopulateParents() {
        
        // given
        let style = SKStyle(source: ["parents": ["p2", "p3"], "p2": 1], name: "")
        let expectedSource: [String: Any] = ["p1": "p3", "p2": 1]
        
        // when
        try? style.populateParents(fromProvider: SKStylesProviderMock())
        
        // then
        XCTAssertEqual(expectedSource as NSDictionary, style.source as NSDictionary)
    }
    
    func testSourceStyleForKey() {
        
        // given
        let provider = SKStylesProviderJSONMock(source: jsonFrom(named: "styleParamParent")!)
        let style1 = provider.style(withName: "style1")!
        let style2 = provider.style(withName: "style2")!
        
        // when
        let sourceStyle = try! style2.sourceStyle(key: "p1", fromProvider: provider, except: ["style2"])!
        
        // then
        XCTAssertEqual(sourceStyle.name, style1.name)
        XCTAssertEqual(sourceStyle.source as NSDictionary, style1.source as NSDictionary)
    }
    
    func testSourceStyleSelf() {
        
        // given
        let provider = SKStylesProviderJSONMock(source: jsonFrom(named: "styleParamParent")!)
        let style3 = provider.style(withName: "style3")!
        
        // when
        // then
        XCTAssertThrowsError(try style3.sourceStyle(key: "p1", fromProvider: provider, except: ["style3"]))
    }
    
    func testSourcePopulatedParamForKey() {
        
        // given
        let provider = SKStylesProviderJSONMock(source: jsonFrom(named: "styleParamParent")!)
        let style1 = provider.style(withName: "style1")!
        let style2 = provider.style(withName: "style2")!
        
        // when
        let param = try! style2.populatedParam(key: "p1", fromProvider: provider, except: ["style2"])
        let numberParam = (param as? NSNumber).map({ CGFloat($0.floatValue) })
        
        // then
        XCTAssertNotNil(numberParam)
        XCTAssertEqual(numberParam, style1.cgFloatValue(forKey: "p1"))
    }
    
    func testSourcePopulateParams() {
        
        // given
        let provider = SKStylesProviderJSONMock(source: jsonFrom(named: "styleParamParent")!)
        let style1 = provider.style(withName: "style1")!
        let style2 = provider.style(withName: "style2")!
        
        // when
        try! style2.populateParams(fromProvider: provider)
        
        // then
        XCTAssertEqual(style2.cgFloatValue(forKey: "p1"), style1.cgFloatValue(forKey: "p1"))
    }
}
