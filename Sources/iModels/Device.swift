//
//  Device.swift
//  iModels
//
//  Created by Anbalagan D on 01/03/23.
//

import Foundation

/// A utility for identifying Apple device models from hardware identifiers.
///
/// The `Device` enum provides static methods and properties to determine the human-readable
/// device model name from Apple's internal hardware identifiers. This is useful for analytics,
/// device compatibility checks, and user interface customization.
///
/// ## Usage
///
/// ```swift
/// import iModels
///
/// // Get current device model
/// let model = Device.modelName
/// print(model) // "iPhone 16 Pro"
///
/// // Get current device identifier
/// let id = Device.identifier
/// print(id) // "iPhone17,1"
///
/// // Get model for specific identifier
/// let specificModel = Device.modelName(for: "iPhone17,5")
/// print(specificModel) // "iPhone 16e"
/// ```
public enum Device {
    /// The Apple hardware identifier of the current device.
    ///
    /// This property returns the internal hardware identifier that Apple uses to distinguish
    /// between different device models and configurations.
    ///
    /// ## Examples
    ///
    /// ```swift
    /// let identifier = Device.identifier
    /// print(identifier) // "iPhone17,1" (iPhone 16 Pro)
    /// ```
    ///
    /// - Note: In the iOS Simulator, this returns the simulated device's identifier from
    ///   the `SIMULATOR_MODEL_IDENTIFIER` environment variable.
    ///
    /// - Returns: A string representing the device's hardware identifier (e.g., "iPhone16,1").
    public static var identifier: String {
        let identifier: String
#if targetEnvironment(simulator)
        identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
#else
        var systemInfo = utsname()
        uname(&systemInfo)
        
        identifier = withUnsafeBytes(of: &systemInfo.machine) { ptr in
            guard let cPtr = ptr.baseAddress?.assumingMemoryBound(to: CChar.self) else {
                return ""
            }
            return String(cString: cPtr)
        }
#endif
        return identifier
    }
    
    /// The human-readable model name of the current device.
    ///
    /// This property returns the marketing name of the current device. If the device identifier
    /// is not recognized, it falls back to returning the raw identifier.
    ///
    /// ## Examples
    ///
    /// ```swift
    /// let modelName = Device.modelName
    /// print(modelName) // "iPhone 16 Pro"
    /// ```
    ///
    /// ## Simulator Behavior
    ///
    /// When running in the iOS Simulator, " Simulator" is automatically appended to the model name:
    ///
    /// ```swift
    /// // On simulator
    /// print(Device.modelName) // "iPhone 16 Pro Simulator"
    /// ```
    ///
    /// To get the base model name without the "Simulator" suffix, use:
    ///
    /// ```swift
    /// let baseModel = Device.modelName(for: Device.identifier)
    /// print(baseModel) // "iPhone 16 Pro"
    /// ```
    ///
    /// - Returns: The device's marketing name, or the raw identifier if unknown.
    public static var modelName: String {
#if targetEnvironment(simulator)
        return "\(modelName(for: identifier) ?? identifier) Simulator"
#else
        return modelName(for: identifier) ?? identifier
#endif
    }
    
    /// Returns the human-readable model name for a specific device identifier.
    ///
    /// This method maps Apple's internal hardware identifiers to their corresponding
    /// marketing names. It supports all released Apple devices including iPhone, iPad,
    /// iPod touch, Apple Watch, Apple TV, and Apple Vision Pro.
    ///
    /// ## Examples
    ///
    /// ```swift
    /// let model1 = Device.modelName(for: "iPhone17,5")
    /// print(model1) // Optional("iPhone 16e")
    ///
    /// let model2 = Device.modelName(for: "iPad15,3")
    /// print(model2) // Optional("iPad Air 11-inch (M3)")
    ///
    /// let model3 = Device.modelName(for: "Watch7,12")
    /// print(model3) // Optional("Apple Watch Ultra 3")
    ///
    /// let unknown = Device.modelName(for: "UnknownDevice1,1")
    /// print(unknown) // nil
    /// ```
    ///
    /// ## Supported Device Types
    ///
    /// - **iPhone**: All models from original iPhone to iPhone 17 series and iPhone Air
    /// - **iPad**: All iPad, iPad Air, iPad Pro, and iPad mini models
    /// - **iPod**: All iPod touch generations
    /// - **Apple Watch**: All Apple Watch models including SE and Ultra
    /// - **Apple TV**: All Apple TV models including 4K generations
    /// - **Apple Vision**: Apple Vision Pro
    ///
    /// - Parameter identifier: The Apple-defined hardware identifier (e.g., "iPhone17,1", "iPad15,3", "Watch7,12").
    /// - Returns: The human-readable model name, or `nil` if the identifier is not recognized.
    public static func modelName(for identifier: String) -> String? {
        return switch identifier {
        case "iPhone1,1": "iPhone"
        case "iPhone1,2": "iPhone 3G"
        case "iPhone2,1": "iPhone 3GS"
        case "iPhone3,1": "iPhone 4"
        case "iPhone3,2": "iPhone 4 GSM Rev A"
        case "iPhone3,3": "iPhone 4 CDMA"
        case "iPhone4,1": "iPhone 4S"
        case "iPhone5,1": "iPhone 5"
        case "iPhone5,2": "iPhone 5"
        case "iPhone5,3": "iPhone 5c"
        case "iPhone5,4": "iPhone 5c"
        case "iPhone6,1": "iPhone 5s"
        case "iPhone6,2": "iPhone 5s"
        case "iPhone7,1": "iPhone 6 Plus"
        case "iPhone7,2": "iPhone 6"
        case "iPhone8,1": "iPhone 6s"
        case "iPhone8,2": "iPhone 6s Plus"
        case "iPhone8,4": "iPhone SE (1st generation)"
        case "iPhone9,1": "iPhone 7"
        case "iPhone9,2": "iPhone 7 Plus"
        case "iPhone9,3": "iPhone 7"
        case "iPhone9,4": "iPhone 7 Plus"
        case "iPhone10,1": "iPhone 8"
        case "iPhone10,2": "iPhone 8 Plus"
        case "iPhone10,3": "iPhone X"
        case "iPhone10,4": "iPhone 8"
        case "iPhone10,5": "iPhone 8 Plus"
        case "iPhone10,6": "iPhone X"
        case "iPhone11,2": "iPhone XS"
        case "iPhone11,4": "iPhone XS Max"
        case "iPhone11,6": "iPhone XS Max"
        case "iPhone11,8": "iPhone XR"
        case "iPhone12,1": "iPhone 11"
        case "iPhone12,3": "iPhone 11 Pro"
        case "iPhone12,5": "iPhone 11 Pro Max"
        case "iPhone12,8": "iPhone SE (2nd generation)"
        case "iPhone13,1": "iPhone 12 mini"
        case "iPhone13,2": "iPhone 12"
        case "iPhone13,3": "iPhone 12 Pro"
        case "iPhone13,4": "iPhone 12 Pro Max"
        case "iPhone14,2": "iPhone 13 Pro"
        case "iPhone14,3": "iPhone 13 Pro Max"
        case "iPhone14,4": "iPhone 13 mini"
        case "iPhone14,5": "iPhone 13"
        case "iPhone14,6": "iPhone SE (3rd generation)"
        case "iPhone14,7": "iPhone 14"
        case "iPhone14,8": "iPhone 14 Plus"
        case "iPhone15,2": "iPhone 14 Pro"
        case "iPhone15,3": "iPhone 14 Pro Max"
        case "iPhone15,4": "iPhone 15"
        case "iPhone15,5": "iPhone 15 Plus"
        case "iPhone16,1": "iPhone 15 Pro"
        case "iPhone16,2": "iPhone 15 Pro Max"
        case "iPhone17,1": "iPhone 16 Pro"
        case "iPhone17,2": "iPhone 16 Pro Max"
        case "iPhone17,3": "iPhone 16"
        case "iPhone17,4": "iPhone 16 Plus"
        case "iPhone17,5": "iPhone 16e"
        case "iPhone18,1": "iPhone 17 Pro"
        case "iPhone18,2": "iPhone 17 Pro Max"
        case "iPhone18,3": "iPhone 17"
        case "iPhone18,4": "iPhone Air"
            
        case "iPod1,1": "1st Gen iPod"
        case "iPod2,1": "2nd Gen iPod"
        case "iPod3,1": "3rd Gen iPod"
        case "iPod4,1": "4th Gen iPod"
        case "iPod5,1": "iPod touch"
        case "iPod7,1": "iPod touch (6th generation)"
        case "iPod9,1": "iPod touch (7th generation)"
            
        case "iPad1,1": "iPad"
        case "iPad1,2": "iPad 3G"
        case "iPad2,1": "iPad 2"
        case "iPad2,2": "iPad 2"
        case "iPad2,3": "iPad 2"
        case "iPad2,4": "iPad 2"
        case "iPad2,5": "iPad mini"
        case "iPad2,6": "iPad mini"
        case "iPad2,7": "iPad mini"
        case "iPad3,1": "iPad (3rd generation)"
        case "iPad3,2": "iPad (3rd generation)"
        case "iPad3,3": "iPad (3rd generation)"
        case "iPad3,4": "iPad (4th generation)"
        case "iPad3,5": "iPad (4th generation)"
        case "iPad3,6": "iPad (4th generation)"
        case "iPad4,1": "iPad Air"
        case "iPad4,2": "iPad Air"
        case "iPad4,3": "iPad Air"
        case "iPad4,4": "iPad mini 2"
        case "iPad4,5": "iPad mini 2"
        case "iPad4,6": "iPad mini 2"
        case "iPad4,7": "iPad mini 3"
        case "iPad4,8": "iPad mini 3"
        case "iPad4,9": "iPad mini 3"
        case "iPad5,1": "iPad mini 4"
        case "iPad5,2": "iPad mini 4"
        case "iPad5,3": "iPad Air 2"
        case "iPad5,4": "iPad Air 2"
        case "iPad6,3": "iPad Pro (9.7-inch)"
        case "iPad6,4": "iPad Pro (9.7-inch)"
        case "iPad6,7": "iPad Pro (12.9-inch)"
        case "iPad6,8": "iPad Pro (12.9-inch)"
        case "iPad6,11": "iPad (5th generation)"
        case "iPad6,12": "iPad (5th generation)"
        case "iPad7,1": "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad7,2": "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad7,3": "iPad Pro (10.5-inch)"
        case "iPad7,4": "iPad Pro (10.5-inch)"
        case "iPad7,5": "iPad (6th generation)"
        case "iPad7,6": "iPad (6th generation)"
        case "iPad7,11": "iPad (7th generation)"
        case "iPad7,12": "iPad (7th generation)"
        case "iPad8,1": "iPad Pro (11-inch)"
        case "iPad8,2": "iPad Pro (11-inch)"
        case "iPad8,3": "iPad Pro (11-inch)"
        case "iPad8,4": "iPad Pro (11-inch)"
        case "iPad8,5": "iPad Pro (12.9-inch) (3rd generation)"
        case "iPad8,6": "iPad Pro (12.9-inch) (3rd generation)"
        case "iPad8,7": "iPad Pro (12.9-inch) (3rd generation)"
        case "iPad8,8": "iPad Pro (12.9-inch) (3rd generation)"
        case "iPad8,9": "iPad Pro (11-inch) (2nd generation)"
        case "iPad8,10": "iPad Pro (11-inch) (2nd generation)"
        case "iPad8,11": "iPad Pro (12.9-inch) (4th generation)"
        case "iPad8,12": "iPad Pro (12.9-inch) (4th generation)"
        case "iPad11,1": "iPad mini (5th generation)"
        case "iPad11,2": "iPad mini (5th generation)"
        case "iPad11,3": "iPad Air (3rd generation)"
        case "iPad11,4": "iPad Air (3rd generation)"
        case "iPad11,6": "iPad (8th generation)"
        case "iPad11,7": "iPad (8th generation)"
        case "iPad12,1": "iPad (9th generation)"
        case "iPad12,2": "iPad (9th generation)"
        case "iPad13,1": "iPad Air (4th generation)"
        case "iPad13,2": "iPad Air (4th generation)"
        case "iPad13,4": "iPad Pro (11-inch) (3rd generation)"
        case "iPad13,5": "iPad Pro (11-inch) (3rd generation)"
        case "iPad13,6": "iPad Pro (11-inch) (3rd generation)"
        case "iPad13,7": "iPad Pro (11-inch) (3rd generation)"
        case "iPad13,8": "iPad Pro (12.9-inch) (5th generation)"
        case "iPad13,9": "iPad Pro (12.9-inch) (5th generation)"
        case "iPad13,10": "iPad Pro (12.9-inch) (5th generation)"
        case "iPad13,11": "iPad Pro (12.9-inch) (5th generation)"
        case "iPad13,16": "iPad Air (5th generation)"
        case "iPad13,17": "iPad Air (5th generation)"
        case "iPad13,18": "iPad (10th generation)"
        case "iPad13,19": "iPad (10th generation)"
        case "iPad14,1": "iPad mini (6th generation)"
        case "iPad14,2": "iPad mini (6th generation)"
        case "iPad14,3": "iPad Pro (11-inch) (4th generation)"
        case "iPad14,4": "iPad Pro (11-inch) (4th generation)"
        case "iPad14,5": "iPad Pro (12.9-inch) (6th generation)"
        case "iPad14,6": "iPad Pro (12.9-inch) (6th generation)"
        case "iPad14,8": "iPad Air 11-inch (M2)"
        case "iPad14,9": "iPad Air 11-inch (M2)"
        case "iPad14,10": "iPad Air 13-inch (M2)"
        case "iPad14,11": "iPad Air 13-inch (M2)"
        case "iPad15,3": "iPad Air 11-inch (M3)"
        case "iPad15,4": "iPad Air 11-inch (M3)"
        case "iPad15,5": "iPad Air 13-inch (M3)"
        case "iPad15,6": "iPad Air 13-inch (M3)"
        case "iPad15,7": "iPad (A16)"
        case "iPad15,8": "iPad (A16)"
        case "iPad16,1": "iPad mini (A17 Pro)"
        case "iPad16,2": "iPad mini (A17 Pro)"
        case "iPad16,3": "iPad Pro 11-inch (M4)"
        case "iPad16,4": "iPad Pro 11-inch (M4)"
        case "iPad16,5": "iPad Pro 13-inch (M4)"
        case "iPad16,6": "iPad Pro 13-inch (M4)"
            
        case "Watch1,1": "Apple Watch (1st generation) 38mm"
        case "Watch1,2": "Apple Watch (1st generation) 42mm"
        case "Watch2,3": "Apple Watch Series 2 38mm"
        case "Watch2,4": "Apple Watch Series 2 42mm"
        case "Watch2,6": "Apple Watch Series 1 38mm"
        case "Watch2,7": "Apple Watch Series 1 42mm"
        case "Watch3,1": "Apple Watch Series 3 (GPS + Cellular) 38mm"
        case "Watch3,2": "Apple Watch Series 3 (GPS + Cellular) 42mm"
        case "Watch3,3": "Apple Watch Series 3 (GPS) 38mm"
        case "Watch3,4": "Apple Watch Series 3 (GPS) 42mm"
        case "Watch4,1": "Apple Watch Series 4"
        case "Watch4,2": "Apple Watch Series 4"
        case "Watch4,3": "Apple Watch Series 4"
        case "Watch4,4": "Apple Watch Series 4"
        case "Watch5,1": "Apple Watch Series 5"
        case "Watch5,2": "Apple Watch Series 5"
        case "Watch5,3": "Apple Watch Series 5"
        case "Watch5,4": "Apple Watch Series 5"
        case "Watch5,9": "Apple Watch SE (GPS)"
        case "Watch5,10": "Apple Watch SE (GPS)"
        case "Watch5,11": "Apple Watch SE (GPS + Cellular)"
        case "Watch5,12": "Apple Watch SE (GPS + Cellular)"
        case "Watch6,1": "Apple Watch Series 6 (GPS)"
        case "Watch6,2": "Apple Watch Series 6 (GPS)"
        case "Watch6,3": "Apple Watch Series 6 (GPS + Cellular)"
        case "Watch6,4": "Apple Watch Series 6 (GPS + Cellular)"
        case "Watch6,6": "Apple Watch Series 7 (GPS)"
        case "Watch6,7": "Apple Watch Series 7 (GPS)"
        case "Watch6,8": "Apple Watch Series 7 (GPS + Cellular)"
        case "Watch6,9": "Apple Watch Series 7 (GPS + Cellular)"
        case "Watch6,10": "Apple Watch SE (GPS)"
        case "Watch6,11": "Apple Watch SE (GPS)"
        case "Watch6,12": "Apple Watch SE (GPS + Cellular)"
        case "Watch6,13": "Apple Watch SE (GPS + Cellular)"
        case "Watch6,14": "Apple Watch Series 8 (GPS)"
        case "Watch6,15": "Apple Watch Series 8 (GPS)"
        case "Watch6,16": "Apple Watch Series 8 (GPS + Cellular)"
        case "Watch6,17": "Apple Watch Series 8 (GPS + Cellular)"
        case "Watch6,18": "Apple Watch Ultra"
        case "Watch7,1": "Apple Watch Series 9 (GPS)"
        case "Watch7,2": "Apple Watch Series 9 (GPS)"
        case "Watch7,3": "Apple Watch Series 9 (GPS + Cellular)"
        case "Watch7,4": "Apple Watch Series 9 (GPS + Cellular)"
        case "Watch7,5": "Apple Watch Ultra 2"
        case "Watch7,8": "Apple Watch Series 10 (GPS)"
        case "Watch7,9": "Apple Watch Series 10 (GPS)"
        case "Watch7,10": "Apple Watch Series 10 (GPS + Cellular)"
        case "Watch7,11": "Apple Watch Series 10 (GPS + Cellular)"
        case "Watch7,12": "Apple Watch Ultra 3"
        case "Watch7,13": "Apple Watch SE 3 (GPS)"
        case "Watch7,14": "Apple Watch SE 3 (GPS)"
        case "Watch7,15": "Apple Watch SE 3 (GPS + Cellular)"
        case "Watch7,16": "Apple Watch SE 3 (GPS + Cellular)"
        case "Watch7,17": "Apple Watch Series 11 (GPS)"
        case "Watch7,18": "Apple Watch Series 11 (GPS)"
        case "Watch7,19": "Apple Watch Series 11 (GPS + Cellular)"
        case "Watch7,20": "Apple Watch Series 11 (GPS + Cellular)"
            
        case "AppleTV3,1": "AppleTV"
        case "AppleTV3,2": "AppleTV"
        case "AppleTV5,3": "Apple TV"
        case "AppleTV6,2": "Apple TV 4K"
        case "AppleTV11,1": "Apple TV 4K (2nd generation)"
        case "AppleTV14,1": "Apple TV 4K (3rd generation)"
            
        case "RealityDevice14,1": "Apple Vision Pro"
            
        case "MacFamily20,1": "Mac"
            
        case "RealityFamily22,1": "Apple Vision"
            
        default: nil
        }
    }
}
