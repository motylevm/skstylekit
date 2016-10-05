# SKStyleKit

<p align="left">
	<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/Swift_3.0-compatible-4BC51D.svg?style=flat" alt="Swift 3.0 compatible" /></a>
	<a href="https://cocoapods.org/pods/tablekit"><img src="https://img.shields.io/badge/pod-0.7.1-blue.svg" alt="CocoaPods compatible" /></a>
	<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
	<a href="https://raw.githubusercontent.com/maxsokolov/tablekit/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
</p>

SKStyleKit is an easy to use library for styling visual components.

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

## Style Declaration

Styles are declared in json format, add JSON file to your project, name it style<Your name>.json, and decalre first style:

```json
{
	"labelStyle": {

		"fontSize": 15,
		"fontColor": "#7F007F"
		"borderWidth": 1,
		"borderColor": "red",
		"backgroundColor": "lightGray"
	}
}
```
Now we have style named "labelStyle" with bunch of parameters, we already can use it, but let's decalre second one:

```json
{
	<...>
		"backgroundColor": "lightGray"
	},

	"titleLabelStyle": {

		"fontSize": 25,
		"fontColor": "#7F007F"
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

		"parent": "defBorder"
		"fontSize": 15,
		"fontColor": "#7F007F"
	},

	"titleLabelStyle": {

		"parent": "labelStyle",
		"fontSize": 25
	}
}
```

First step

Coming soon

## Basic usage

Coming soon

# Advanced