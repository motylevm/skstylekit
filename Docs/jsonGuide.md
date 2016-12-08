# Naming

SKStyleKit automatically loads files matching `style<...>.json` pattern from app's and frameworks' bundles

# Structure

Styles declared in styles file use following structure:

```json
{
	"style1": {

		"param1": "value1",
		"param2": "value2",
		"paramN": "valueN"
	},
	"style2": { },
	"styleN": { }
}
```

Styles can be grouped into categories:

```json
{
	"category": {
		"style1": { }
	},

	"style2": { }
}
```
In this case `style2` can be fetched by it's name, `style1` by it's name and name with category prefix `category.style1`.

# Inheritance

There are two types of inheritance in SKStyleKit:

## Full

Full inheritance makes one style inherit all parameters from other:

```json
{
	"style": {
		"parent": "otherStyle"
	}
}
```

SKStyleKit also supports multiple full inheritance:

```json
{
	"style": {
		"parents": ["otherStyle1", "otherStyle2"]
	}
}
```

## Parameter Inheritance

The other type of supported inheritance works only for related parameter:

```json
{
	"black": {
		"color": "#000000"
	},
	"style": {
		"fontColor": "black"
	}
}
```

So any parameter value can be replaced by other style name from wich actual value should be fetched. 
General purpose of parameter inheritance is working with abstract parameters (such as `color`)

# Conditions

Parameters can be condition based, so they will be applied only if condition check passes. For example: 

```json
{
	"defaultText": {

		"fontSize@pad": 15,
		"fontSize@phone": 14
	},

	"defBorder": {

		"borderWidth@1x": 1,
		"borderWidth@2x": 0.5,
		"borderWidth@3x": 0.333,
	}
}
```

# Parameters

## Abstract

Abstract parameters set values of multiple other parameters. Main purpose of abstract parameters is to use them for parameter inheritance. For example, it's good idea to declare all colors your app using in one place:

```json
{
	"color": {
		"dark": { "color": "#000000" },
		"white": { "color": "#FFFFFF" }
	},

	"darkText": {
		"fontColor": "dark"
	},
	"whiteView": {
		"backgroundColor": "white"
	}
}
```

### color
Can be referenced from any other color parameter. SKStyleKit have buildin styles: `black`, `darkGray`, `lightGray`, `white`, `gray`, `red`, `green`, `blue`, `cyan`, `yellow`, `magenta`, `orange`, `purple`, `brown`, `clear`.

### size
Can be referenced from any other number type parameter
SKStyleKit have buildin style: `1pixel`

## UIView

### backgroundColor 
Background color, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`

### cornerRadius
Corner radius, in points

### borderColor
Border color, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`

### borderWidth
Border width, in points

### borderColor
Border color, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`

### alpha
`alpha` value [0 - 1]

### shadowRadius
Shadow radius, in points

### shadowOffset
Shadow offset, string representing CGSize structure, for example: "{0, -3}"

### shadowColor
Shadow color, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`

### shadowOpacity
Shadow opacity [0 - 1]

### tintColor
Tint color, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`

## UISlider

### minimumTrackTintColor
Minimum track color, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`

### maximumTrackTintColor
Maximum track color, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`

### thumbTintColor
Thumnb tint color, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`

## UIControl

### contentVerticalAlignment
Content vertical aligment, possible values: `center`, `top`, `bottom`, `fill`

### contentHorizontalAlignment
Content horizontal aligment, possible values: `center`, `left`, `right`, `fill`

## UISwitch

### onTintColor
Tint color in on state, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`

### thumbTintColor [String]
Thumnb tint color, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`

## UIProgressView

### progressTintColor
Progress tint color, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`

### trackTintColor
Track tint color, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`

## Text attributes

Text attributes is applied to text containers UILabel, UIButton, UITextView, UITextField and NSAttributedString

### fontName
Font name

### fontStyle 
If no fontName specified, sets corresponding system's font style and in thus case should be one of the following:
`ultraLight`, `thin`, `light`, `regular`, `medium`, `semibold`, `bold`, `heavy`, `black`, `italic`
If fontName exists fontStyle string will be appended to it: `fontName-fontStyle`.

### fontSize
Font size in points.

### fontColor
Font color, string representing color in hex format: `#RRGGBB` or `#AARRGGBB`.

### fontKern
Font kern in points.

### fontLineSpacing
The distance in points between the bottom of one line fragment and the top of the next.

### fontLineHeightMultiple
The line height multiple.

### fontMinimumLineHeight
The font minimum line height, in points.

### fontMaximumLineHeight
The font maximum line height, in points.

### textParagraphSpacing
The space after the end of the paragraph, in points.

### textParagraphFirstLineHeadIndent
The indentation of the first line, in points.

### textParagraphHeadIndent
The indentation of the lines other than the first, in points.

### textParagraphTailIndent
The trailing indentation, in points.

### textParagraphSpacingBefore
The distance between the paragraph’s top and the beginning of its text content, in points.

### textHyphenationFactor
The paragraph’s threshold for hyphenation.

### textUnderline
Text underline style, possible values: `none`, `single`, `thick`, `double`

### textUnderlinePattern
Text underline pattern, possible values: `solid`, `dot`, `dash`, `dashDot`, `dashDotDot`

### textUnderlineColor
Text underline color in hex format: `#RRGGBB` or `#AARRGGBB`.

### textAlignment
The text alignment, possible values: `right`, `left`, `center`, `justified`

### textStrikethrough
Text strikethrough style, possible values: `none`, `single`, `thick`, `double`

### textStrikethroughPattern
Text strikethrough pattern, possible values: `solid`, `dot`, `dash`, `dashDot`, `dashDotDot`

### textStrikethroughColor
Text strikethrough color in hex format: `#RRGGBB` or `#AARRGGBB`.
