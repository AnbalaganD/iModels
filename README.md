# iModels

[![Version](https://img.shields.io/cocoapods/v/iModels.svg?style=flat)](https://cocoapods.org/pods/iModels)
[![License](https://img.shields.io/cocoapods/l/iModels.svg?style=flat)](https://cocoapods.org/pods/iModels)
[![Platform](https://img.shields.io/cocoapods/p/iModels.svg?style=flat)](https://cocoapods.org/pods/iModels)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FAnbalaganD%2FiModels%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/AnbalaganD/iModels)

This library facilitates developers in easily determining the device model, which is particularly valuable for gathering statistics on user device distribution. It offers various other benefits as well.

## Examples

To run the **Example** project, clone the repo, and run `pod install` from the Example directory first, then open the Xcode workspace.

To run the **iModelsExample** project, clone the repo, and open the Xcode project.

## Installation

### Swift Package manager (SPM)

iModels is available through [SPM](https://github.com/AnbalaganD/iModels). Use below URL to add it as a dependency

```swift
dependencies: [
    .package(url: "https://github.com/AnbalaganD/iModels", .upToNextMajor(from: "0.1.7"))
]
```

### CocoaPods

iModels is available through [CocoaPods](https://cocoapods.org/pods/iModels). To install
it, simply add the following line to your Podfile:

```ruby
pod 'iModels'
```

> **Note:** CocoaPods updates will not be provided for upcoming releases, as CocoaPods is no longer actively supported and has entered maintenance mode.

## Usage
```swift
import iModels

Device.modelName // The most commonly used
Device.identifier // Apple's identifiers

// for other device identifiers
print("\(Device.modelName(for: "iPhone8,2") ?? "unknown")")
// output: iPhone 6s Plus
```

#### Simulator Note
The `Device.modelName` variable will now append the name "Simulator" to the model name when running within the simulator. If you want to avoid this behavior, you can use `Device.modelName(for: Device.identifier)`.

## Authors

* [Anbalagan D](mailto:anbu94p@gmail.com)
* [Bill Shirley](mailto:bshirley@shirl.com)

## License

iModels is available under the MIT license. See the LICENSE file for more info.
