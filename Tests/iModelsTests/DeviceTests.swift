//
//  DeviceTests.swift
//  iModels
//
//  Created by Anbalagan on 24/09/25.
//

import Testing
@testable import iModels

@Suite("Test all the device model is properly working or not")
struct DeviceTests {
    @Test("identifier should not be empty")
    func identifierNotEmpty() {
        let id = Device.identifier
        #expect(!id.isEmpty, "Device.identifier must not be empty")
    }

    @Test("modelName should match mapping for current identifier (handles Simulator suffix)")
    func modelNameMatchesIdentifierMapping() {
        let id = Device.identifier
        let base = Device.modelName(for: id) ?? id
        #if targetEnvironment(simulator)
        #expect(Device.modelName == "\(base) Simulator")
        #else
        #expect(Device.modelName == base)
        #endif
    }

    @Test("known identifier mappings")
    func knownIdentifierMappings() {
        #expect(Device.modelName(for: "iPhone8,2") == "iPhone 6s Plus")
        #expect(Device.modelName(for: "iPhone10,6") == "iPhone X")
        #expect(Device.modelName(for: "iPad16,6") == "iPad Pro 13-inch (M4)")
        #expect(Device.modelName(for: "Watch7,12") == "Apple Watch Ultra 3")
        #expect(Device.modelName(for: "AppleTV14,1") == "Apple TV 4K (3rd generation)")
        #expect(Device.modelName(for: "RealityDevice14,1") == "Apple Vision Pro")
    }

    @Test("unknown identifier returns nil")
    func unknownIdentifierReturnsNil() {
        #expect(Device.modelName(for: "UnknownDevice1,1") == nil)
    }
}
