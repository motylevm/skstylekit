//
//  SKPerformanceTests.swift
//  SKStyleKit
//
//  Created by Мотылёв Михаил on 02/11/2016.
//  Copyright © 2016 mmotylev. All rights reserved.
//

import XCTest
@testable import SKStyleKit

let viewsCount = 5000

class SKPerformanceUIViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        basicSetup()
    }
    
    func testPerformanceUIViewFull() {
        
        // given
        let style = StyleKit.style(withName: "viewStyle")
        let views = (0 ..< viewsCount).map({ _ in SKView() })
        
        // when
        self.measure {
        
            for view in views {
                view.style = style
            }
        }
    }
    
    func testPerformanceUIViewExceptShadow() {
        
        // given
        let style = StyleKit.style(withName: "viewStyleExceptShadow")
        let views = (0 ..< viewsCount).map({ _ in SKView() })
        
        // when
        self.measure {
            
            for view in views {
                view.style = style
            }
        }
    }
    
    func testPerformanceUIViewExceptShadowBorderCorner() {
        
        // given
        let style = StyleKit.style(withName: "viewStyleExceptShadowBorderCorner")
        let views = (0 ..< viewsCount).map({ _ in SKView() })
        
        // when
        self.measure {
            
            for view in views {
                view.style = style
            }
        }
    }
    
}
