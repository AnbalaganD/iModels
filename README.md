# iModels

[![Version](https://img.shields.io/cocoapods/v/iModels.svg?style=flat)](https://cocoapods.org/pods/iModels)
[![License](https://img.shields.io/cocoapods/l/iModels.svg?style=flat)](https://cocoapods.org/pods/iModels)
[![Platform](https://img.shields.io/cocoapods/p/iModels.svg?style=flat)](https://cocoapods.org/pods/iModels)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)

This library facilitates developers in easily determining the device model, which is particularly valuable for gathering statistics on user device distribution. It offers various other benefits as well.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### CocoaPods

iModels is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'iModels'
```

### Swift Package manager (SPM)

iModels is available through [SPM](https://github.com/AnbalaganD/iModels). Use below URL to add as a dependency

```swift
dependencies: [
    .package(url: "https://github.com/AnbalaganD/iModels", .upToNextMajor(from: "0.1.2"))
]
```

## Usage
```swift
import iModels

Device.modelName
```

## Author

[Anbalagan D](mailto:anbu94p@gmail.com)

## License

iModels is available under the MIT license. See the LICENSE file for more info.
