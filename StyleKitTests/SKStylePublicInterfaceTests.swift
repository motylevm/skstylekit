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

class StyleKitLogMock: StyleKit {
    
    static var lastLogMessage: String?
    
    override class func log(_ message: String) {
        
        lastLogMessage = message
    }
}

class SKStylePublicInterfaceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
    
        // given
        let defConf = StyleKitConfiguration()
        
        // when
        StyleKit.initStyleKit()
        
        // then
        let conf = StyleKit.sharedInstance!.configuration
        XCTAssertEqual(conf.loadDefaultStyles, defConf.loadDefaultStyles)
        XCTAssertEqual(conf.loadFrameworkStyles, defConf.loadFrameworkStyles)
        XCTAssertEqual(conf.loadApplicationStyles, defConf.loadApplicationStyles)
        XCTAssertEqual(conf.styleFiles ?? [], defConf.styleFiles ?? [])
        XCTAssertEqual(conf.suppressLogMessages, defConf.suppressLogMessages)
        
    }
    
    func testIsInitCheck() {
        
        // when
        StyleKit.sharedInstance = nil

        // then
        XCTAssertFalse(StyleKit.isInitialized())
        
        // when
        StyleKit.initStyleKit()
        
        // then
        XCTAssertTrue(StyleKit.isInitialized())
    }
    
    func testGetStyleWithNotInitializedStyleKit() {
        
        // given
        let styleName = "some name"
        StyleKitLogMock.sharedInstance = nil
        
        // when
        let style = StyleKitLogMock.style(withName: styleName)
        
        // then
        XCTAssertNil(style)
        XCTAssertEqual("Style kit is not initialized, call initStyleKit()", StyleKitLogMock.lastLogMessage)
    }
    
    func testGetStyleWithNoSuchStyle() {
        
        // given
        let styleName = "some absent name"
        StyleKitLogMock.initStyleKit()
        
        // when
        let style = StyleKitLogMock.style(withName: styleName)
        
        // then
        XCTAssertNil(style)
        XCTAssertEqual("Style kit warning: style named \(styleName) not found", StyleKitLogMock.lastLogMessage)
    }
    
    func testGetStyleWithOutName() {
        
        // given
        StyleKit.initStyleKit()
        
        // when
        let style = StyleKit.style(withName: nil)
        
        // then
        XCTAssertNil(style)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
