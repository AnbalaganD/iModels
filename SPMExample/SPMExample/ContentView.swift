//
//  ContentView.swift
//  SPMExample
//
//  Created by Bill Shirley on 4/2/25.
//

import SwiftUI
import iModels

extension Device {
    static func image(for identifier: String) -> Image {
        if Device.modelName(for: identifier) == nil {
            return Image(systemName: "questionmark")
        } else if identifier.contains("iPhone") {
            return Image(systemName: "iphone")
        } else if identifier.contains("iPod") {
            return Image(systemName: "ipod")
        } else if identifier.contains("iPad") {
            return Image(systemName: "ipad")
        } else if identifier.contains("Watch") {
            return Image(systemName: "applewatch")
        } else {
            return Image(systemName: "apple.logo")
        }
    }
}

struct ContentView: View {
    @State private var identifier: String = Device.identifier
    @State private var deviceImage: Image? = Device.image(for: Device.identifier)
    @State private var modelName: String = Device.modelName(for: Device.identifier) ?? ""
    
    
    var body: some View {
        VStack {
            Spacer()
            Device.image(for: Device.identifier)
                .imageScale(.large)
                .foregroundStyle(.tint)
            Spacer()
            Text("This Device")
                .font(.title)
            HStack {
                Text("identifier:")
                    .foregroundStyle(.secondary)
                Text("\(Device.identifier)")
            }
            HStack {
                Text("model name:")
                    .foregroundStyle(.secondary)
                Text("\(Device.modelName)")
            }
            Spacer()
            Form {
                HStack {
                    Text("identifier:")
                        .foregroundStyle(.secondary)
                    TextField("identifier", text: $identifier)
                        .onChange(of: identifier) {
                            updateModelName()
                        }
                    deviceImage
                        .imageScale(.large)
                }
                HStack {
                    Text("model name:")
                        .foregroundStyle(.secondary)
                    TextField("model name", text: $modelName)
                        .foregroundStyle(identifier == modelName ? .secondary : .primary)
                }
            }
        }
        .padding()
    }
    
    private func updateModelName() {
        modelName = Device.modelName(for: identifier) ?? identifier
        deviceImage = Device.image(for: identifier)
    }
}

#Preview {
    ContentView()
}
