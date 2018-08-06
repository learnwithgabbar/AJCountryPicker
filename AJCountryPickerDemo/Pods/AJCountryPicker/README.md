# AJCountryPicker


AJCountryPicker is library to pick country code and flag written in Swift.

[![Pod Version](http://img.shields.io/cocoapods/v/AJCountryPicker.svg)](http://cocoadocs.org/docsets/AJCountryPicker/)
[![Cocoapods](http://img.shields.io/badge/Cocoapods-available-green.svg?style=flat)](http://cocoadocs.org/docsets/AJCountryPicker/)
[![Language](https://img.shields.io/badge/language-Swift%202.2-orange.svg)](https://swift.org)
[![License: MIT](http://img.shields.io/badge/license-MIT-70a1fb.svg?style=flat)](https://github.com/techmehra/AJCountryPicker/master/README.md)
## Features

- [x] Country Flag
- [x] Country Code
- [x] Country Calling Code
- [x] Country Name
- [x] Colusres to pick country 
- [x] Delegates to pick country


## Installation

> **Embedded frameworks require a minimum deployment target of iOS 8 or OS X Mavericks (10.9).**



### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build AJCountryPicker.

To integrate AJCountryPicker into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'AJCountryPicker', '~> 1.0'
end
```

Then, run the following command:

```bash
$ pod install
```
#### Demo

Do `pod try AJCountryPicker` in your console and run the project to try a demo.

## Basic usage ✨

```swift
let countryCodePicker = AJCountryPicker { country, code in
			print(country, code)
		}

// To get current country with calling code
let country = countryCodePicker.currentCountryWithCallingCode
print("country name :- ", country.$0)
print("country calling Code :- ", country.$1)

 // Display calling codes
countryCodePicker.showCallingCodes = true
 // Closure to show country details
countryCodePicker.countryWithCodeAndCallingCode = { name, code, dialCode in
	print("country calling Code :- ", dialCode)
}
navigationController?.pushViewController(countryCodePicker, animated: true)
```
## License

AJCountryPicker is released under the MIT license. See LICENSE for details.
