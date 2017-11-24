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

import UIKit

public extension SKStyle {
    
    // MARK: - UITabBar -
    /**
        Applies style to a tab bar
     
        - parameter tabBar: Tab bar to apply style to
    */
    public func apply(tabBar: UITabBar) {
        
        if let tintColor = tintColor {
            tabBar.tintColor = tintColor
        }
        
        if let barTintColor = barTintColor {
            tabBar.barTintColor = barTintColor
        }
        
        if let unselectedItemTintColor = unselectedItemTintColor {
            
            if #available(iOS 10.0, *) {
                tabBar.unselectedItemTintColor = unselectedItemTintColor
            } else {
                StyleKit.log("Style kit warning: unselectedItemTintColor is only available on iOS 10.0 or newer", onlyOnce: true)
            }
        }
    }
}
