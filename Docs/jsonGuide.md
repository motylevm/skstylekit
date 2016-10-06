# Naming

SKStyleKit automatically loads files matching `style<...>.json` pattern from app's and frameworks' bundles

# Structure

Styles declared in styles file use following structure:

```json
{
	"style1": {

		"param1": value1,
		"param2": value2,
		...
		"paramN": valueN
	},
	"style2": { ... }

	"styleN": { ... }
}
```

Styles can be grouped into categories:

```json
{
	"category": {
		"style1": { ... }
	},

	"style2": { ... }
}
```
In this case `style2` can be fetched by it's name, `style1` by it's name and name with category prefix `category.style1`.

# Inheritance

There are two types of inheritance in SKStyleKit:

## Full

Full inheritance make one style inherit all parameters from other:

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

# Parameters

## Abstract



## UIView

### backgroundColor [String]
Sets backgroundColor of UIView
Type - String representing color in hex format: `#RRGGBB` or `#AARRGGBB`


### cornerRadius [Number]
Sets `layer.cornerRadius` of UIView 

### borderColor [String]
Sets `layer.borderColor` of UIView 
Type - String representing color in hex format: `#RRGGBB` or `#AARRGGBB`

### borderWidth [Number]
Sets `layer.borderWidth` of UIView 

### borderColor [String]
Sets `layer.borderColor` of UIView 
Type - String representing color in hex format: `#RRGGBB` or `#AARRGGBB`

### alpha [Number]
Sets `alpha` of UIView

### shadowRadius [Number]
Sets `layer.shadowRadius` of UIView 

### shadowOffset [String]
Sets layer.shadowOffset of UIView
Type - String representing CGSize, for example: "{0, -3}"

### shadowColor [String]
Sets layer.shadowColor of UIView 
Type - String representing color in hex format: "#RRGGBB" or "#AARRGGBB"

### shadowOpacity [Number]
Sets layer.shadowOpacity of UIView
Note: This value is automatically sets to 1 when any of shadowColor, shadowOffset or shadowRadius is set

### tintColor [String]
Sets tintColor of UIView 
Type - String representing color in hex format: "#RRGGBB" or "#AARRGGBB"

## UIControl

### contentVerticalAlignment [String]
Sets contentVerticalAlignment of UIControl
Type - String one of "center", "top", "bottom", "fill"

### contentHorizontalAlignment [String]
Sets contentHorizontalAlignment of UIControl
Type - String one of "center", "left", "right", "fill"

## UISwitch

### onTintColor [String]
Sets onTintColor of UISwitch
Type - String representing color in hex format: "#RRGGBB" or "#AARRGGBB"

### thumbTintColor [String]
Sets thumbTintColor of UISwitch 
Type - String representing color in hex format: "#RRGGBB" or "#AARRGGBB"

## Text attributes

Text attributes is applied to text containers UILable, UIButton, UITextView, UITextField and NSAttributedString

### fontName [String]

Name of font

### fontStyle [String]
If no fontName specified, sets corresponding system's font style and in thus case should be one of the following:
`ultraLight`, `thin`, `light`, `regular`, `medium`, `semibold`, `bold`, `heavy`, `black`, `italic`
If fontName exists fontStyle string will be appended to it: `fontName-fontStyle`

### fontSize [Number]
Font size in points

### fontColor [String]
Font color 
Type - String representing color in hex format: "#RRGGBB" or "#AARRGGBB"

### fontKern [Number]
Font kern in points

### fontLineSpacing [Number]
The distance in points between the bottom of one line fragment and the top of the next.

### fontLineHeightMultiple [Number]
The line height multiple.

### fontMinimumLineHeight [Number]
The font minimum line height

### fontMaximumLineHeight [Number]
The font maximum line height

### textParagraphSpacing [Number]
The space after the end of the paragraph.

### textParagraphFirstLineHeadIndent [Number]
The indentation of the first line.

### textParagraphHeadIndent [Number]
The indentation of the lines other than the first.

### textParagraphTailIndent [Number]
The trailing indentation.

### textParagraphSpacingBefore [Number]
The distance between the paragraph’s top and the beginning of its text content.

### textHyphenationFactor [Number]
The paragraph’s threshold for hyphenation.

### textUnderline [String]
Text underline style should be one of the following:
`none`, `single`, `thick`, `double`

### textUnderlinePattern [String]
Text underline pattern should be one of the following:
`solid`, `dot`, `dash`, `dashDot`, `dashDotDot`

### textAlignment [String]
The text alignment should be one of the following:
`right`, `left`, `center`, `justified`

