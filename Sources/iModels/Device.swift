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
/// print(model) // "iPhone 15 Pro"
///
/// // Get current device identifier
/// let id = Device.identifier
/// print(id) // "iPhone16,1"
///
/// // Get model for specific identifier
/// let specificModel = Device.modelName(for: "iPhone8,2")
/// print(specificModel) // "iPhone 6s Plus"
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
    /// print(identifier) // "iPhone16,1" (iPhone 15 Pro)
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
    /// print(modelName) // "iPhone 15 Pro"
    /// ```
    ///
    /// ## Simulator Behavior
    ///
    /// When running in the iOS Simulator, " Simulator" is automatically appended to the model name:
    ///
    /// ```swift
    /// // On simulator
    /// print(Device.modelName) // "iPhone 15 Pro Simulator"
    /// ```
    ///
    /// To get the base model name without the "Simulator" suffix, use:
    ///
    /// ```swift
    /// let baseModel = Device.modelName(for: Device.identifier)
    /// print(baseModel) // "iPhone 15 Pro"
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
    /// let model1 = Device.modelName(for: "iPhone8,2")
    /// print(model1) // Optional("iPhone 6s Plus")
    ///
    /// let model2 = Device.modelName(for: "iPad13,1")
    /// print(model2) // Optional("iPad Air 4th Gen (WiFi)")
    ///
    /// let model3 = Device.modelName(for: "Watch6,18")
    /// print(model3) // Optional("Apple Watch Ultra")
    ///
    /// let unknown = Device.modelName(for: "UnknownDevice1,1")
    /// print(unknown) // nil
    /// ```
    ///
    /// ## Supported Device Types
    ///
    /// - **iPhone**: All models from original iPhone to iPhone 16 series
    /// - **iPad**: All iPad, iPad Air, iPad Pro, and iPad mini models
    /// - **iPod**: All iPod touch generations
    /// - **Apple Watch**: All Apple Watch models including SE and Ultra
    /// - **Apple TV**: Apple TV 4K models
    /// - **Apple Vision**: Apple Vision Pro
    ///
    /// - Parameter identifier: The Apple-defined hardware identifier (e.g., "iPhone16,1", "iPad13,1", "Watch6,18").
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
        case "iPhone5,1": "iPhone 5 (GSM)"
        case "iPhone5,2": "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3": "iPhone 5C (GSM)"
        case "iPhone5,4": "iPhone 5C (Global)"
        case "iPhone6,1": "iPhone 5S (GSM)"
        case "iPhone6,2": "iPhone 5S (Global)"
        case "iPhone7,1": "iPhone 6 Plus"
        case "iPhone7,2": "iPhone 6"
        case "iPhone8,1": "iPhone 6s"
        case "iPhone8,2": "iPhone 6s Plus"
        case "iPhone8,4": "iPhone SE (GSM)"
        case "iPhone9,1": "iPhone 7"
        case "iPhone9,2": "iPhone 7 Plus"
        case "iPhone9,3": "iPhone 7"
        case "iPhone9,4": "iPhone 7 Plus"
        case "iPhone10,1": "iPhone 8"
        case "iPhone10,2": "iPhone 8 Plus"
        case "iPhone10,3": "iPhone X Global"
        case "iPhone10,4": "iPhone 8"
        case "iPhone10,5": "iPhone 8 Plus"
        case "iPhone10,6": "iPhone X GSM"
        case "iPhone11,2": "iPhone XS"
        case "iPhone11,4": "iPhone XS Max"
        case "iPhone11,6": "iPhone XS Max Global"
        case "iPhone11,8": "iPhone XR"
        case "iPhone12,1": "iPhone 11"
        case "iPhone12,3": "iPhone 11 Pro"
        case "iPhone12,5": "iPhone 11 Pro Max"
        case "iPhone12,8": "iPhone SE 2nd Gen"
        case "iPhone13,1": "iPhone 12 Mini"
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
            
        case "iPod1,1": "1st Gen iPod"
        case "iPod2,1": "2nd Gen iPod"
        case "iPod3,1": "3rd Gen iPod"
        case "iPod4,1": "4th Gen iPod"
        case "iPod5,1": "5th Gen iPod"
        case "iPod7,1": "6th Gen iPod"
        case "iPod9,1": "7th Gen iPod"
            
        case "iPad1,1": "iPad"
        case "iPad1,2": "iPad 3G"
        case "iPad2,1": "2nd Gen iPad"
        case "iPad2,2": "2nd Gen iPad GSM"
        case "iPad2,3": "2nd Gen iPad CDMA"
        case "iPad2,4": "2nd Gen iPad New Revision"
        case "iPad2,5": "iPad mini"
        case "iPad2,6": "iPad mini GSM+LTE"
        case "iPad2,7": "iPad mini CDMA+LTE"
        case "iPad3,1": "3rd Gen iPad"
        case "iPad3,2": "3rd Gen iPad CDMA"
        case "iPad3,3": "3rd Gen iPad GSM"
        case "iPad3,4": "4th Gen iPad"
        case "iPad3,5": "4th Gen iPad GSM+LTE"
        case "iPad3,6": "4th Gen iPad CDMA+LTE"
        case "iPad4,1": "iPad Air (WiFi)"
        case "iPad4,2": "iPad Air (GSM+CDMA)"
        case "iPad4,3": "1st Gen iPad Air (China)"
        case "iPad4,4": "iPad mini Retina (WiFi)"
        case "iPad4,5": "iPad mini Retina (GSM+CDMA)"
        case "iPad4,6": "iPad mini Retina (China)"
        case "iPad4,7": "iPad mini 3 (WiFi)"
        case "iPad4,8": "iPad mini 3 (GSM+CDMA)"
        case "iPad4,9": "iPad Mini 3 (China)"
        case "iPad5,1": "iPad mini 4 (WiFi)"
        case "iPad5,2": "4th Gen iPad mini (WiFi+Cellular)"
        case "iPad5,3": "iPad Air 2 (WiFi)"
        case "iPad5,4": "iPad Air 2 (Cellular)"
        case "iPad6,3": "iPad Pro (9.7 inch, WiFi)"
        case "iPad6,4": "iPad Pro (9.7 inch, WiFi+LTE)"
        case "iPad6,7": "iPad Pro (12.9 inch, WiFi)"
        case "iPad6,8": "iPad Pro (12.9 inch, WiFi+LTE)"
        case "iPad6,11": "iPad (2017)"
        case "iPad6,12": "iPad (2017)"
        case "iPad7,1": "iPad Pro 2nd Gen (WiFi)"
        case "iPad7,2": "iPad Pro 2nd Gen (WiFi+Cellular)"
        case "iPad7,3": "iPad Pro 10.5-inch 2nd Gen"
        case "iPad7,4": "iPad Pro 10.5-inch 2nd Gen"
        case "iPad7,5": "iPad 6th Gen (WiFi)"
        case "iPad7,6": "iPad 6th Gen (WiFi+Cellular)"
        case "iPad7,11": "iPad 7th Gen 10.2-inch (WiFi)"
        case "iPad7,12": "iPad 7th Gen 10.2-inch (WiFi+Cellular)"
        case "iPad8,1": "iPad Pro 11 inch 3rd Gen (WiFi)"
        case "iPad8,2": "iPad Pro 11 inch 3rd Gen (1TB, WiFi)"
        case "iPad8,3": "iPad Pro 11 inch 3rd Gen (WiFi+Cellular)"
        case "iPad8,4": "iPad Pro 11 inch 3rd Gen (1TB, WiFi+Cellular)"
        case "iPad8,5": "iPad Pro 12.9 inch 3rd Gen (WiFi)"
        case "iPad8,6": "iPad Pro 12.9 inch 3rd Gen (1TB, WiFi)"
        case "iPad8,7": "iPad Pro 12.9 inch 3rd Gen (WiFi+Cellular)"
        case "iPad8,8": "iPad Pro 12.9 inch 3rd Gen (1TB, WiFi+Cellular)"
        case "iPad8,9": "iPad Pro 11 inch 4th Gen (WiFi)"
        case "iPad8,10": "iPad Pro 11 inch 4th Gen (WiFi+Cellular)"
        case "iPad8,11": "iPad Pro 12.9 inch 4th Gen (WiFi)"
        case "iPad8,12": "iPad Pro 12.9 inch 4th Gen (WiFi+Cellular)"
        case "iPad11,1": "iPad mini 5th Gen (WiFi)"
        case "iPad11,2": "iPad mini 5th Gen"
        case "iPad11,3": "iPad Air 3rd Gen (WiFi)"
        case "iPad11,4": "iPad Air 3rd Gen"
        case "iPad11,6": "iPad 8th Gen (WiFi)"
        case "iPad11,7": "iPad 8th Gen (WiFi+Cellular)"
        case "iPad12,1": "iPad 9th Gen (WiFi)"
        case "iPad12,2": "iPad 9th Gen (WiFi+Cellular)"
        case "iPad13,1": "iPad Air 4th Gen (WiFi)"
        case "iPad13,2": "iPad Air 4th Gen (WiFi+Cellular)"
        case "iPad13,4": "iPad Pro 11 inch 5th Gen"
        case "iPad13,5": "iPad Pro 11 inch 5th Gen"
        case "iPad13,6": "iPad Pro 11 inch 5th Gen"
        case "iPad13,7": "iPad Pro 11 inch 5th Gen"
        case "iPad13,8": "iPad Pro 12.9 inch 5th Gen"
        case "iPad13,9": "iPad Pro 12.9 inch 5th Gen"
        case "iPad13,10": "iPad Pro 12.9 inch 5th Gen"
        case "iPad13,11": "iPad Pro 12.9 inch 5th Gen"
        case "iPad13,16": "iPad Air 5th Gen (WiFi)"
        case "iPad13,17": "iPad Air 5th Gen (WiFi+Cellular)"
        case "iPad13,18": "iPad 10th Gen"
        case "iPad13,19": "iPad 10th Gen"
        case "iPad14,1": "iPad mini 6th Gen (WiFi)"
        case "iPad14,2": "iPad mini 6th Gen (WiFi+Cellular)"
        case "iPad14,3": "iPad Pro 11 inch 4th Gen"
        case "iPad14,4": "iPad Pro 11 inch 4th Gen"
        case "iPad14,5": "iPad Pro 12.9 inch 6th Gen"
        case "iPad14,6": "iPad Pro 12.9 inch 6th Gen"
        case "iPad14,8": "iPad Air 11-inch (M2)"
        case "iPad14,9": "iPad Air 11-inch (M2)"
        case "iPad14,10": "iPad Air 13-inch (M2)"
        case "iPad14,11": "iPad Air 13-inch (M2)"
        case "iPad16,3": "iPad Pro 11-inch (M4)"
        case "iPad16,4": "iPad Pro 11-inch (M4)"
        case "iPad16,5": "iPad Pro 13-inch (M4)"
        case "iPad16,6": "iPad Pro 13-inch (M4)"
            
        case "Watch1,1": "Apple Watch 38mm case"
        case "Watch1,2": "Apple Watch 42mm case"
        case "Watch2,3": "Apple Watch Series 2 38mm case"
        case "Watch2,4": "Apple Watch Series 2 42mm case"
        case "Watch2,6": "Apple Watch Series 1 38mm case"
        case "Watch2,7": "Apple Watch Series 1 42mm case"
        case "Watch3,1": "Apple Watch Series 3 38mm case (GPS+Cellular)"
        case "Watch3,2": "Apple Watch Series 3 42mm case (GPS+Cellular)"
        case "Watch3,3": "Apple Watch Series 3 38mm case (GPS)"
        case "Watch3,4": "Apple Watch Series 3 42mm case (GPS)"
        case "Watch4,1": "Apple Watch Series 4 40mm case (GPS)"
        case "Watch4,2": "Apple Watch Series 4 44mm case (GPS)"
        case "Watch4,3": "Apple Watch Series 4 40mm case (GPS+Cellular)"
        case "Watch4,4": "Apple Watch Series 4 44mm case (GPS+Cellular)"
        case "Watch5,1": "Apple Watch Series 5 40mm case (GPS)"
        case "Watch5,2": "Apple Watch Series 5 44mm case (GPS)"
        case "Watch5,3": "Apple Watch Series 5 40mm case (GPS+Cellular)"
        case "Watch5,4": "Apple Watch Series 5 44mm case (GPS+Cellular)"
        case "Watch5,9": "Apple Watch SE 40mm case (GPS)"
        case "Watch5,10": "Apple Watch SE 44mm case (GPS)"
        case "Watch5,11": "Apple Watch SE 40mm case (GPS+Cellular)"
        case "Watch5,12": "Apple Watch SE 44mm case (GPS+Cellular)"
        case "Watch6,1": "Apple Watch Series 6 40mm case (GPS)"
        case "Watch6,2": "Apple Watch Series 6 44mm case (GPS)"
        case "Watch6,3": "Apple Watch Series 6 40mm case (GPS+Cellular)"
        case "Watch6,4": "Apple Watch Series 6 44mm case (GPS+Cellular)"
        case "Watch6,6": "Apple Watch Series 7 41mm case (GPS)"
        case "Watch6,7": "Apple Watch Series 7 45mm case (GPS)"
        case "Watch6,8": "Apple Watch Series 7 41mm case (GPS+Cellular)"
        case "Watch6,9": "Apple Watch Series 7 45mm case (GPS+Cellular)"
        case "Watch6,10": "Apple Watch SE 40mm case (GPS)"
        case "Watch6,11": "Apple Watch SE 44mm case (GPS)"
        case "Watch6,12": "Apple Watch SE 40mm case (GPS+Cellular)"
        case "Watch6,13": "Apple Watch SE 44mm case (GPS+Cellular)"
        case "Watch6,14": "Apple Watch Series 8 41mm case (GPS)"
        case "Watch6,15": "Apple Watch Series 8 45mm case (GPS)"
        case "Watch6,16": "Apple Watch Series 8 41mm case (GPS+Cellular)"
        case "Watch6,17": "Apple Watch Series 8 45mm case (GPS+Cellular)"
        case "Watch6,18": "Apple Watch Ultra"
        case "Watch7,1": "Apple Watch Series 9 41mm case (GPS)"
        case "Watch7,2": "Apple Watch Series 9 45mm case (GPS)"
        case "Watch7,3": "Apple Watch Series 9 41mm case (GPS+Cellular)"
        case "Watch7,4": "Apple Watch Series 9 45mm case (GPS+Cellular)"
        case "Watch7,5": "Apple Watch Ultra 2"
        case "Watch7,8": "Apple Watch Series 10 (GPS)"
        case "Watch7,9": "Apple Watch Series 10 (GPS)"
        case "Watch7,10": "Apple Watch Series 10 (GPS + Cellular)"
        case "Watch7,11": "Apple Watch Series 10 (GPS + Cellular)"
            
        case "AppleTV14,1": "Apple TV 4K (3rd Generation)"
            
        case "RealityDevice14,1": "Apple Vision Pro"
            
        default: nil
        }
    }
}
