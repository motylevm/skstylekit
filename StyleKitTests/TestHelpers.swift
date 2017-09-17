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
import XCTest
@testable import SKStyleKit

let defString = "123456789"

class TestClass {
    
}

func jsonFrom(named: String) -> [String: Any]? {
    
    guard let filePath = Bundle(for: TestClass.self).path(forResource: named, ofType: "json") else { return nil }
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return nil }
    
    return (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())) as? [String: Any]
}

func basicSetup() {
    
    let path = Bundle(for: TestClass.self).path(forResource: "styleUITestsStyles", ofType: "json")!
    
    let configuration = StyleKitConfiguration()
    configuration.sources = [path].map { SKStyleKitSource.file($0) }
    
    StyleKit.sharedInstance = StyleKit(withConfiguration: configuration)
}

func checkViewStyle(_ view: UIView) {
    
    XCTAssertEqual(view.tintColor, UIColor.green)
    XCTAssertEqual(view.backgroundColor, UIColor.red)
    XCTAssertEqual(view.layer.cornerRadius, 5.0)
    XCTAssertEqual(view.layer.borderWidth, 4.0)
    XCTAssertEqual(UIColor(cgColor: view.layer.borderColor!), UIColor.green)
    XCTAssertEqual(view.layer.shadowOffset, CGSize(width: 3, height: 2))
    XCTAssertEqual(UIColor(cgColor: view.layer.shadowColor!), UIColor.blue)
    XCTAssertEqual(view.layer.shadowOpacity, 0.3)
}

func checkStringStyle(_ attributedText: NSAttributedString?, aligmentCheck: Bool = true) {
    
    var effectiveRange: NSRange = NSRange()
    
    let attributes = attributedText?.attributes(at: 0, effectiveRange: &effectiveRange)
    XCTAssertTrue(NSEqualRanges(NSMakeRange(0, 9), effectiveRange))
    checkStringStyle(attributes: attributes, aligmentCheck: aligmentCheck)
}

func checkStringStyle(attributes: [NSAttributedStringKey: Any]?, aligmentCheck: Bool = true) {
    
    let pargraphStyle = attributes?[NSAttributedStringKey.paragraphStyle] as? NSParagraphStyle

    guard let font = attributes?[NSAttributedStringKey.font] as? UIFont else {
        
        XCTAssert(false)
        return
    }
    
    let isBold = (font.fontDescriptor.symbolicTraits.rawValue & UIFontDescriptorSymbolicTraits.traitBold.rawValue) != 0
    
    XCTAssertNotNil(pargraphStyle)
    XCTAssertTrue(isBold)
    
    XCTAssertEqual(font.pointSize, 21)
    XCTAssertEqual(attributes?[NSAttributedStringKey.foregroundColor] as? UIColor, UIColor.green)
    XCTAssertEqual((attributes?[NSAttributedStringKey.kern] as? NSNumber)?.floatValue, 0.1)
    XCTAssertEqual(pargraphStyle?.lineSpacing, 15)
    XCTAssertEqual(pargraphStyle?.lineHeightMultiple, 3)
    XCTAssertEqual(pargraphStyle?.minimumLineHeight, 10)
    XCTAssertEqual(pargraphStyle?.maximumLineHeight, 50)
    
    if aligmentCheck {
        XCTAssertEqual(pargraphStyle?.alignment, NSTextAlignment.right)
    }
    
    XCTAssertEqual(pargraphStyle?.paragraphSpacing, 12)
    XCTAssertEqual(pargraphStyle?.firstLineHeadIndent, 20)
    XCTAssertEqual(pargraphStyle?.headIndent, 4)
    XCTAssertEqual(pargraphStyle?.tailIndent, 8)
    XCTAssertEqual(pargraphStyle?.paragraphSpacingBefore, 7)
    XCTAssertEqual(pargraphStyle?.hyphenationFactor, 1.5)
    XCTAssertEqual((attributes?[NSAttributedStringKey.underlineStyle] as? NSNumber)?.intValue, NSUnderlineStyle.patternDashDotDot.rawValue | NSUnderlineStyle.styleDouble.rawValue)
    XCTAssertEqual((attributes?[NSAttributedStringKey.underlineColor] as? UIColor), UIColor.red)
    XCTAssertEqual((attributes?[NSAttributedStringKey.strikethroughStyle] as? NSNumber)?.intValue, NSUnderlineStyle.patternDashDotDot.rawValue | NSUnderlineStyle.styleDouble.rawValue)
    XCTAssertEqual((attributes?[NSAttributedStringKey.strikethroughColor] as? UIColor), UIColor.blue)
}

func checkActivityIndicatorViewStyle(_ activityIndicatorView: UIActivityIndicatorView?) {
    XCTAssertEqual(activityIndicatorView?.color, UIColor.green)
}

func checkControlStyle(_ control: UIControl?) {
    
    XCTAssertEqual(control?.contentHorizontalAlignment, UIControlContentHorizontalAlignment.right)
    XCTAssertEqual(control?.contentVerticalAlignment, UIControlContentVerticalAlignment.top)
}

func checkSliderStyle(_ slider: UISlider?) {
    
    XCTAssertEqual(slider?.minimumTrackTintColor, UIColor.red)
    XCTAssertEqual(slider?.maximumTrackTintColor, UIColor.green)
    XCTAssertEqual(slider?.thumbTintColor, UIColor.blue)
}

func checkProgressStyle(_ progress: UIProgressView?) {
    
    XCTAssertEqual(progress?.progressTintColor, UIColor.red)
    XCTAssertEqual(progress?.trackTintColor, UIColor.green)
}

class SKStylesProviderMock: SKStylesProvider {
    
    func style(withName name: String?) -> SKStyle? {
        return SKStyle(source: ["p1": name ?? ""], name: name ?? "")
    }
}

class SKStylesProviderJSONMock: SKStylesProvider {
    
    let source: [String: Any]
    
    init(source: [String: Any]) {
        self.source = source
    }
    
    func style(withName name: String?) -> SKStyle? {
        return name.flatMap({ source[$0] as? [String: Any] }).map({ SKStyle(source: $0, name: name ?? "") })
    }
}
