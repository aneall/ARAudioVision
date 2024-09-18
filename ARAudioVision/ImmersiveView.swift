// ImmersiveView.swift

// Explanation
    // Swift code to set up the FULLY IMMERSIVE (full app) version of the demo
        // This enables us to use plane detection
        // Not using this file CURRENTLY because we're only using ContentView.swift (volume)
        // TODO: add changes to implement this view

// Code below for ImmersiveView.swift (FULLY IMMERSIVE)
import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {

    var body: some View {
        RealityView { content in
            // Add the 3D speaker model in RealityKit content
            if let speakerEntity = try? await Entity(named: "SpeakersAnimated", in: .main) {
                speakerEntity.position = [0, 0, 0] // Position at origin
                let anchor = AnchorEntity(world: [0, 0, 0]) // Anchor at origin
                content.add(anchor)
                anchor.addChild(speakerEntity)
                print("Model successfully loaded and placed.")
            } else {
                print("Failed to load speaker model.")
            }
        }
    }
}

#Preview(immersionStyle: .full) {
    ImmersiveView()
        .environment(AppModel())
}
