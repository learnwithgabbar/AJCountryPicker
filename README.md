# AJCountryPicker


AJCountryPicker is library to pick country code and flag written in Swift.
[![Language](https://img.shields.io/badge/language-Swift%204.0-orange.svg)](https://swift.org)
[![License: MIT](http://img.shields.io/badge/license-MIT-70a1fb.svg?style=flat)](https://github.com/techmehra/AJCountryPicker/master/README.md)
## Features

- [x] Country Flag
- [x] Country Code
- [x] Country Calling Code
- [x] Country Name
- [x] Colusres to pick country 



## Installation

> **Copy Paste Files on project... Pod is coming soon**

## Basic usage ✨

```swift
let countryPicker = AJCountryPicker()
countryPicker.showSearchBar = true
countryPicker.customCountriesCodes = ["IN", "US"]
countryPicker.showCallingCodes = true
countryPicker.country = {
print("Selected Country Name =====> ", $0.name)
print("Selected Country ISO Code =====> ", $0.ISOCode)
print("Selected Country Calling Code =====> ", $0.callingCode)

}
self.navigationController?.pushViewController(countryPicker, animated: true)
```
## License

AJCountryPicker is released under the MIT license. See LICENSE for details.
