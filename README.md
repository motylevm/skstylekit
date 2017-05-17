# SKStyleKit

<p align="left">
	<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/Swift_3.0-compatible-4BC51D.svg?style=flat" alt="Swift 3.0 compatible" /></a>
	<a href="https://cocoapods.org/pods/tablekit"><img src="https://img.shields.io/badge/pod-0.9.14-blue.svg" alt="CocoaPods compatible" /></a>
	<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
	<a href="https://raw.githubusercontent.com/motylevm/skstylekit/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
</p>

SKStyleKit is an easy to use library for styling visual components. Written in swift it supports both swift and Objective C.

# Features

- [x] Once declared style can be used across your app.
- [x] Using StyleKit you can modify only style declaration you no longer have to edit xibs, storyboards or code.
- [x] Styles are declared in easy to read and write JSON format.

# Installation

## CocoaPods
To integrate SKStyleKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'SKStyleKit'
```

## Manual
Clone the repo and drag files from `Sources` folder into your Xcode project.

# Getting Started

Before first call style kit should be initialized. It's recomended to do this in your app delegate:

```swift
import SKStyleKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    <...>

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        StyleKit.initStyleKit()
        return true
    }

    <...>
}
```

# Styles Declaration

Styles are declared in json format, add JSON file to your project, name it `style.json`, and decalre first style:

```json
{
	"labelStyle": {

		"fontSize": 15,
		"fontColor": "#7F007F",
		"borderWidth": 1,
		"borderColor": "red",
		"backgroundColor": "lightGray"
	}
}
```
Now we have style named "labelStyle" with bunch of parameters, we already can use it, but let's decalre second one:

```json
{
	"titleLabelStyle": {

		"fontSize": 25,
		"fontColor": "#7F007F",
		"borderWidth": 1,
		"borderColor": "red",
		"backgroundColor": "lightGray"
	}
}
```

Ok, but both styles use same border settings and same fontColor, so decalration can be improved using inheritance:

```json
{
	"defBorder": {

		"borderWidth": 1,
		"borderColor": "red",
		"backgroundColor": "lightGray"
	},

	"labelStyle": {

		"parent": "defBorder",
		"fontSize": 15,
		"fontColor": "#7F007F"
	},

	"titleLabelStyle": {

		"parent": "labelStyle",
		"fontSize": 25
	}
}
```

For complete list of parameters and full syntax description please check [SKStyleKit parameters guide](Docs/jsonGuide.md).

# Basic Usage

The most convenient (but not the only!) way to use styles is to use them with SK components or their subclasses. SK components already have properties `style` and `styleName`:

## Label Example

Select any label in xib or storyboard file and make it SKLabel class. 

<p align="center">
	<img src="https://cloud.githubusercontent.com/assets/5831773/19125795/1cab1b22-8b41-11e6-9f11-5e3ef6552782.png"/>
</p>

Then switch to attributes inspector and set style name property:

<p align="center">
	<img src="https://cloud.githubusercontent.com/assets/5831773/19126418/88e80686-8b43-11e6-9f2e-f3309ea8bbaa.png"/>
</p>

That's it!

####Note: Styles also can be combined like "firstStyleName+secondStyleName+<...>"

## Button Example

SKButton has separate styles for differets states. Let's declare them:

```json
{
	"button.normal": {
		"parents": ["button.Text", "button.ViewStyle"],
		"alpha": 1
	},

	"button.selected": {
		"backgroundColor": "green"
	},

	"button.highlighted": {
		"alpha": 0.5
	},

	"button.disabled": {
		"backgroundColor": "gray"
	}
}
```
####Note: Style for "normal" should set all parameters that going to be changed in other stats' styles

Then set them in Interface Bilder:

<p align="center">
	<img src="https://cloud.githubusercontent.com/assets/5831773/20019939/b4b9faf4-a2df-11e6-8e21-800c6487ab93.png"/>
</p>

# Advanced

## Work With Styles Programmatically

SKStyleKit entry point is StyleKit class. 

To get instance of the certain style: 

```swift
let style = StyleKit.style(withName: "StyleName")
```

## Using Style Kit With Non SK Components

Style can be applied to any standart controls like: 

```swift
let style = StyleKit.style(withName: "StyleName")

style.apply(view: UIView?)
style.apply(slider: UISlider?)
style.apply(progress: UIProgressView?)
style.apply(label: UILabel?, text: String?)
style.apply(button: UIButton?, title: String?, forState state: UIControlState)
style.apply(switchControl: UISwitch?)
style.apply(textField: UITextField?, text: String?)
style.apply(textView: UITextView?, text: String?)
```
However in this case, you should not set text or attributedText property directly, use appropriate SKStyle method.

## Using Style Kit With Attributed Strings

Styles can also be applied to strings/attributed strings: 

```swift

let s = "Some string"
let style = StyleKit.style(withName: "StyleName")

SKStyle.string(withStyle: style, string: s) -> NSAttributedString?
SKStyle.string(withStyle: style, attributedString: NSAttributedString(string: s)) -> NSAttributedString?
```

These functions also allow to specify range to apply style like:

```swift

let s = "Some string"
let style = StyleKit.style(withName: "StyleName")

SKStyle.string(withStyle: style, string: s, range: NSRange(location: 0, length: 5)) -> NSAttributedString?
SKStyle.string(withStyle: style, attributedString: NSAttributedString(string: s), range: NSRange(location: 0, length: 8)) -> NSAttributedString?
```
