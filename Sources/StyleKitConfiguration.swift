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

@objc public final class StyleKitConfiguration: NSObject {
    
    public var factory: StyleKitFactory = DefaultStyleKitFactory()
    public var suppressLogMessages: Bool = false
    public var sources: [SKStyleKitSource] = []
    
    // MARK: - Source -
    public func addMainSource() {
        sources.append(SKStyleKitSource.main())
    }
    
    public func addDefaultSource() {
        sources.append(SKStyleKitSource.styleKit())
    }
    
    public func addFileSource(path: String) {
        sources.append(SKStyleKitSource.file(path, zIndex: 0))
    }
    
    public func addBundleSource(bundle: Bundle) {
        sources.append(SKStyleKitSource.bundle(bundle, zIndex: 0))
    }
    
    // MARK: - Factory - 
    public class func defaultConfiguration() -> StyleKitConfiguration {
    
        let result = StyleKitConfiguration()
        result.addMainSource()
        result.addDefaultSource()
        return result
    }
}
