// ContentView.swift

// Explanation
    // Swift code to set up the VOLUME (shared window app) version of the demo
        // This does not allow plane detection, but by default will be in passthrough
// TODO: clean up this code!

import SwiftUI
import RealityKit
import AVFoundation

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var speakersEntity: Entity?
    @State private var timelineController: AnimationPlaybackController?

    var body: some View {
        GeometryReader3D { geometry in
            RealityView { content in
                // Try loading the scene model specifically from the Reality Composer package
                guard let model = try? await ModelEntity(named: "Scene", in: .main) else {
                    print("Error: Failed to load scene model.")
                    return
                }
                print("Scene model loaded successfully.")

                // Scale and position the model
                let modelBounds = model.visualBounds(relativeTo: nil)
                let viewBounds = content.convert(geometry.frame(in: .local), from: .local, to: .scene)
                let scale = (viewBounds.extents / modelBounds.extents).min()
                model.scale *= SIMD3(repeating: scale)
                model.position.y -= model.visualBounds(relativeTo: nil).min.y
                model.position.y += viewBounds.min.y
                
                print("Model position: \(model.position)")
                print("Model scale: \(model.scale)")
                
                content.add(model)

                // Find the correct SpeakersAnimated entity inside Scene.usda
                if let foundSpeakersEntity = model.findEntity(named: "SpeakersAnimated") {
                    speakersEntity = foundSpeakersEntity
                    print("SpeakersAnimated entity found in Scene.usda.")
                    print("Available Animations: \(speakersEntity!.availableAnimations)") // Debugging step
                } else {
                    print("SpeakersAnimated entity not found.")
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomOrnament) {
                Button("Start 1") {
                    startAnimationAndAudioGroundTruth()
                }
                Button("Start 2") {
                    playNVASAudio()
                }
                Button("Start 3") {
                    playOurAudio()
                }
                Button("Stop") {
                    stopAnimationAndAudio()
                }
            }
        }
    }

    // Start animation and audio (groundtruth)
    func startAnimationAndAudioGroundTruth() {
        guard let speakersEntity = speakersEntity else {
            print("SpeakersAnimated model not loaded or not found.")
            return
        }

        // Access the animation called "Clip" (change this if you use a different name for the animation)
        if let animation = speakersEntity.availableAnimations.first(where: { $0.name == "Clip" }) {
            timelineController = speakersEntity.playAnimation(animation, transitionDuration: 0.5, startsPaused: false)
            print("Animation 'Clip' started on SpeakersAnimated.")
        } else {
            print("No available animations with the name 'Clip'.")
        }

        // Play the audio
        playGroundTruthAudio()
    }

    // Stop the animation and audio (ANY AUDIO) - TODO: VERIFY THAT IT WILL STOP ANY AUDIO
    func stopAnimationAndAudio() {
        print("Animation paused.")
        if let timelineController = timelineController {
            timelineController.stop()
        }
        audioPlayer?.stop()
    }

    // Play GROUND TRUTH audio
    func playGroundTruthAudio() {
        if let soundURL = Bundle.main.url(forResource: "groundtruth-audio", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Failed to load or play groundtruth-audio file: \(error.localizedDescription)")
            }
        } else {
            print("Failed to load groundtruth-audio.")
        }
    }
    
    // Play NVAS audio
    func playNVASAudio() {
        if let soundURL = Bundle.main.url(forResource: "nvas-audio", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Failed to load or play nvas-audio file: \(error.localizedDescription)")
            }
        } else {
            print("Failed to load nvas-audio.")
        }
    }
    
    // Play our audio
    func playOurAudio() {
        if let soundURL = Bundle.main.url(forResource: "nvas-audio", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Failed to load or play ours-audio file: \(error.localizedDescription)")
            }
        } else {
            print("Failed to load ours-audio.")
        }
    }
}
