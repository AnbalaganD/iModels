# Getting Started

Learn how to use iModels to identify Apple device models.

## Installation

### Swift Package Manager

Add iModels to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/AnbalaganD/iModels", .upToNextMajor(from: "0.1.6"))
]
```

### CocoaPods

Add to your Podfile:

```ruby
pod 'iModels'
```

## Basic Usage

Import the library and use the static properties:

```swift
import iModels

// Get the current device's model name
let modelName = Device.modelName
print(modelName) // "iPhone 15 Pro"

// Get the current device's identifier
let identifier = Device.identifier
print(identifier) // "iPhone16,1"

// Get model name for a specific identifier
let specificModel = Device.modelName(for: "iPhone8,2")
print(specificModel) // "iPhone 6s Plus"
```

## Simulator Support

When running in the iOS Simulator, the library automatically appends "Simulator" to the model name:

```swift
// On simulator
print(Device.modelName) // "iPhone 15 Pro Simulator"

// To get the base model name without "Simulator" suffix
print(Device.modelName(for: Device.identifier)) // "iPhone 15 Pro"
```
