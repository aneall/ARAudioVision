//
// AppModel.swift
//  Created by Ashley Neall on 9/8/24.
    // Manages state of entire demo (i.e. choosing between VOLUME or FULLY IMMERSVIVE)

import SwiftUI

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    let immersiveSpaceID = "ImmersiveSpace"
    enum ImmersiveSpaceState { // Only relevant when switching between FULLY IMMERSIVE (open) and VOLUME (closed)
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
}
