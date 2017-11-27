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

final class SKDeviceCondition: SKCondition {
    
    // MARK: - Properties
    private(set) var reverse: Bool = false
    private(set) var idiom: UIUserInterfaceIdiom
    
    // MARK: - Init
    init?(string: String) {

        var processedString = string
        
        if processedString.hasPrefix("!") {
            
            reverse = true
            processedString = String(processedString[string.index(after: string.startIndex)...])
        }
        
        switch processedString {
            
            case "iphone", "phone": idiom = .phone
            case "ipad", "pad": idiom = .pad
            case "tv":
                
                if #available(iOS 9.0, *) {
                    idiom = .tv
                } else {
                    idiom = .unspecified
                }
            
            case "carPlay", "car":
                
                if #available(iOS 9.0, *) {
                    idiom = .carPlay
                } else {
                    idiom = .unspecified
                }
            
            default: return nil
        }
    }
    
    // MARK: - SKCondition
    func check() -> Bool {
        
        let result = UIDevice.current.userInterfaceIdiom == idiom
        return reverse ? !result : result
    }
    
    var groupKey: String {
        return "device"
    }
    
    // MARK: - CustomStringConvertible
    var description: String {
        
        var result = reverse ? "!" : ""
        
        switch idiom {
            
            case .pad: result += "pad"
            case .phone: result += "phone"
            case .tv: result += "tv"
            case .carPlay: result += "car"
            default: return ""
        }
        
        return result
    }
}
