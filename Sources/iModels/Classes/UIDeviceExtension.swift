//
//  DeviceModel.swift
//  iModels
//
//  Created by Anbalagan D on 01/03/23.
//

import Foundation

public enum Device {
    static public var modelName: String {
#if targetEnvironment(simulator)
        let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
        return identifier
#else
        var systemInfo = utsname()
        uname(&systemInfo)

        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return switch identifier {
            case "iPhone1,1": "iPhone 1G"
            case "iPhone1,2": "iPhone 3G"
            case "iPhone2,1": "iPhone 3GS"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3": "iPhone 4"
            case "iPhone4,1": "iPhone 4s"
            case "iPhone5,1", "iPhone5,2": "iPhone 5"
            case "iPhone5,3", "iPhone5,4": "iPhone 5c"
            case "iPhone6,1", "iPhone6,2": "iPhone 5s"
            case "iPhone7,2": "iPhone 6"
            case "iPhone7,1": "iPhone 6 Plus"
            case "iPhone8,1": "iPhone 6s"
            case "iPhone8,2": "iPhone 6s Plus"
            case "iPhone8,4": "iPhone SE"
            case "iPhone9,1", "iPhone9,3": "iPhone 7"
            case "iPhone9,2", "iPhone9,4": "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4": "iPhone 8"
            case "iPhone10,2", "iPhone10,5": "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6": "iPhone X"
            case "iPhone11,2": "iPhone XS"
            case "iPhone11,4", "iPhone11,6": "iPhone XS Max"
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
            case "iPhone14,3": "iPhone 13"
            case "iPhone14,4": "iPhone 13 mini"
            case "iPhone14,5": "iPhone 13 Pro Max"
            case "iPad1,1": "iPad"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3": "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6": "iPad (4th generation)"
            case "iPad6,11", "iPad6,12": "iPad (5th generation)"
            case "iPad7,5", "iPad7,6": "iPad (6th generation)"
            case "iPad7,11", "iPad7,12": "iPad (7th generation)"
            case "iPad11,6", "iPad11,7": "iPad (8th generation)"
            case "iPad12,1", "iPad12,2": "iPad (9th generation)"
            default: identifier
        }
#endif
    }
}
