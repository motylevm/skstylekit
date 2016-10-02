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

import Foundation

enum SKStylesSourceType: Int {
    
    case main = 1
    case styleKit = -1
    case other = 0
}

class SKStylesSource: SKStylesSourceProvider {

    // MARK: - Properties
    private(set) var source = [String: Any]()
    private(set) var zIndex: Int = 0
    private(set) var sourceType: SKStylesSourceType = .other
    
    // MARK: - Init
    init?(filePath: String, sourceType: SKStylesSourceType) {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return nil }
        
        do {

            if let source = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any] {
                self.source = try SKStylesSourcePreprocessor().preprocess(source: source)
            }
        
            if let zIndex = source["zIndex"] as? Int {
                self.zIndex = zIndex
            }
            
            self.sourceType = sourceType
        }
        catch SKError.invalidCondition(let description) {
            
            StyleKit.log("Style kit: Invalid condition in \(description)")
            return nil
        }
        catch SKError.invalidStyleStructure(let description) {
            
            StyleKit.log("Style kit: Invalid structure in \(description)")
            return nil
        }
        catch {
            
            StyleKit.log("Style kit: Error loading style json from \(filePath)")
            return nil
        }
    }
    
    // MARK: - Source type
    class func sourceType(forBundle bundle: Bundle) -> SKStylesSourceType {
        
        switch bundle {
            
            case Bundle.main: return .main
            case Bundle(for: SKStylesSource.self): return .styleKit
            default: return .other
        }
    }
    
    // MARK: - Sorting by priority
    func isOrderedBefore(otherSource: SKStylesSource) -> Bool {
        
        if sourceType == otherSource.sourceType {
            return zIndex < otherSource.zIndex
        }
        
        return sourceType.rawValue < otherSource.sourceType.rawValue
    }
}


