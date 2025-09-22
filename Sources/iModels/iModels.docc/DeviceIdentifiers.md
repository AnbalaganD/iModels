# Device Identifiers

Understanding Apple's device identifier system.

## Overview

Apple uses internal hardware identifiers to distinguish between different device models and configurations. These identifiers follow a consistent pattern across device types.

## Identifier Format

Device identifiers follow the pattern: `DeviceType#,#`

Examples:
- `iPhone16,1` - iPhone 15 Pro
- `iPad16,3` - iPad Pro 11-inch (M4)
- `Watch7,1` - Apple Watch Series 9 41mm (GPS)

## Device Type Prefixes

- **iPhone** - All iPhone models
- **iPad** - All iPad models (iPad, iPad Air, iPad Pro, iPad mini)
- **iPod** - iPod touch models
- **Watch** - Apple Watch models
- **AppleTV** - Apple TV models
- **RealityDevice** - Apple Vision products

## Version Numbers

The numbers after the device type indicate:
1. **Major version** - Generally increases with new product generations
2. **Minor version** - Distinguishes between variants (size, cellular capability, storage)

## Examples by Category

### iPhone Identifiers
```swift
"iPhone1,1" // iPhone (original)
"iPhone8,1" // iPhone 6s
"iPhone16,1" // iPhone 15 Pro
"iPhone17,3" // iPhone 16
```

### iPad Identifiers
```swift
"iPad1,1" // iPad (original)
"iPad13,1" // iPad Air 4th Gen (WiFi)
"iPad16,3" // iPad Pro 11-inch (M4)
```

### Apple Watch Identifiers
```swift
"Watch1,1" // Apple Watch 38mm
"Watch6,18" // Apple Watch Ultra
"Watch7,5" // Apple Watch Ultra 2
```

## Cellular Variants

Many devices have multiple identifiers for different cellular capabilities:
- WiFi-only models
- GSM models
- CDMA models
- Global/Universal models
- WiFi+Cellular models

## Unknown Identifiers

When `Device.modelName(for:)` encounters an unknown identifier, it returns `nil`. The `Device.modelName` property falls back to returning the raw identifier if the device model is unknown.