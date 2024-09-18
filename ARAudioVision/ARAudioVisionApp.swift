//
//  ARAudioVisionApp.swift
//  ARAudioVision
//
//  Created by Ashley Neall on 9/8/24.
//

// NEW VERSION of OVERALL APP STRUCTURE (Volume only)
import SwiftUI

@main
struct ARAudioVisionApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup(id: "VolumetricWindow") {
            ContentView()
                .environment(appModel)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1.0, height: 1.0, depth: 1.0, in: .meters) // Define the volume size

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}
