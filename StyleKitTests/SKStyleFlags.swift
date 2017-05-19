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

class SKStyleFlags: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        basicSetup()
    }
    
    func testFlagSetView() {
        
        // given
        let styles = ["viewStyle", "viewStyleExceptShadow", "viewStyleExceptShadowBorderCorner", "viewStyleExceptColor"].map({ StyleKit.style(withName: $0)! })
        let expectedFlags = [flagViewAny | flagViewWasSet,
                             flagViewAny | flagViewWasSet ^ flagViewShadow,
                             flagViewAny | flagViewWasSet ^ flagViewShadow ^ flagViewBorder,
                             flagViewAny | flagViewWasSet ^ flagViewColor]
        
        // when & then
        styles.forEach {
            
            XCTAssertFalse($0.checkFlag(flagViewWasSet))
            XCTAssertFalse($0.checkFlag(flagViewAny))
            
            $0.apply(view: nil)
            
            XCTAssertTrue($0.checkFlag(flagViewWasSet))
        }
        
        let flags = styles.map({ $0.flags })
        
        XCTAssertEqual(flags, expectedFlags)
    }
    
    func testFlagSetLabel() {
        
        // given
        let styles = ["labelCommon", "labelAdvanced"].map({ StyleKit.style(withName: $0)! })
        let expectedFlags = [flagLabelCommon | flagLabelWasSet | flagViewWasSet, flagLabelAdvanced | flagLabelCommon | flagLabelWasSet | flagViewWasSet]
        
        // when & then
        styles.forEach {
            
            XCTAssertFalse($0.checkFlag(flagLabelWasSet))
            XCTAssertFalse($0.checkFlag(flagLabelAny))
            
            $0.apply(label: nil, text: nil)
            
            XCTAssertTrue($0.checkFlag(flagLabelWasSet))
        }
        
        let flags = styles.map({ $0.flags })
        XCTAssertEqual(flags, expectedFlags)
    }
    
    func testFlagSetControl() {
        
        // given
        let style = StyleKit.style(withName: "controlStyle")!
        
        // when & then
        XCTAssertFalse(style.checkFlag(flagControllWasSet))
        XCTAssertFalse(style.checkFlag(flagControllAny))
        
        style.apply(control: nil)
        
        XCTAssertTrue(style.checkFlag(flagControllWasSet))
        XCTAssertTrue(style.checkFlag(flagControllAny))
    }
}
