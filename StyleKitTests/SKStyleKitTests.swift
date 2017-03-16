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

class SKStyleKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let path = Bundle(for: TestClass.self).path(forResource: "style", ofType: "json")!
        
        let configuration = StyleKitConfiguration()
        configuration.sources = [path].map { SKStyleKitSource.file($0) }
        
        StyleKit.sharedInstance = StyleKit(withConfiguration: configuration)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAllStylesFetch() {
        
        // given
        let names = Set<String>((1 ... 11).map { "style\($0)" })
        
        // when 
        let styles = StyleKit.allStyles()
        
        // then
        XCTAssertNotNil(styles)
        XCTAssertEqual(styles!.count, 11)
        
        for style in styles! {
            XCTAssertTrue(names.contains(style.name))
        }
    }
}
