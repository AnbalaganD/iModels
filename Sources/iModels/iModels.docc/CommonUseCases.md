# Common Use Cases

Practical examples of using iModels in your applications.

## Analytics and Crash Reporting

Track device distribution in your app:

```swift
import iModels

func trackDeviceInfo() {
    let deviceModel = Device.modelName
    let deviceIdentifier = Device.identifier
    
    // Send to analytics service
    Analytics.track("app_launch", properties: [
        "device_model": deviceModel,
        "device_identifier": deviceIdentifier
    ])
}
```

## Feature Compatibility Checks

Enable features based on device capabilities:

```swift
import iModels

func supportsAdvancedCamera() -> Bool {
    let identifier = Device.identifier
    
    // Check for devices with advanced camera systems
    let advancedCameraDevices = [
        "iPhone15,2", "iPhone15,3", // iPhone 14 Pro models
        "iPhone16,1", "iPhone16,2", // iPhone 15 Pro models
        "iPhone17,1", "iPhone17,2"  // iPhone 16 Pro models
    ]
    
    return advancedCameraDevices.contains(identifier)
}
```

## UI Customization

Adapt UI based on device type:

```swift
import iModels

func configureUI() {
    let modelName = Device.modelName
    
    if modelName.contains("iPad") {
        // Configure for iPad
        setupTabletLayout()
    } else if modelName.contains("iPhone") {
        if modelName.contains("Plus") || modelName.contains("Pro Max") {
            // Large iPhone
            setupLargePhoneLayout()
        } else {
            // Standard iPhone
            setupPhoneLayout()
        }
    }
}
```

## Device Generation Detection

Determine device generation for performance optimization:

```swift
import iModels

func getDeviceGeneration() -> DeviceGeneration {
    let identifier = Device.identifier
    
    if identifier.hasPrefix("iPhone") {
        let components = identifier.components(separatedBy: ",")
        if let majorVersion = components.first?.replacingOccurrences(of: "iPhone", with: ""),
           let version = Int(majorVersion) {
            switch version {
            case 1...4: return .legacy
            case 5...8: return .older
            case 9...13: return .modern
            case 14...: return .latest
            default: return .unknown
            }
        }
    }
    return .unknown
}

enum DeviceGeneration {
    case legacy, older, modern, latest, unknown
}
```

## Debug Information

Display device info in debug builds:

```swift
import iModels

#if DEBUG
func showDeviceInfo() {
    print("Device Model: \(Device.modelName)")
    print("Device Identifier: \(Device.identifier)")
    
    // Test with different identifiers
    let testIdentifiers = ["iPhone8,2", "iPad13,1", "Watch6,18"]
    for identifier in testIdentifiers {
        if let model = Device.modelName(for: identifier) {
            print("\(identifier) -> \(model)")
        }
    }
}
#endif
```

## Server-Side Device Mapping

Map device identifiers received from client apps:

```swift
import iModels

struct DeviceInfo {
    let identifier: String
    let modelName: String?
    let isKnownDevice: Bool
}

func processClientDeviceInfo(_ identifier: String) -> DeviceInfo {
    let modelName = Device.modelName(for: identifier)
    return DeviceInfo(
        identifier: identifier,
        modelName: modelName,
        isKnownDevice: modelName != nil
    )
}
```