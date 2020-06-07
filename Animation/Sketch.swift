import Foundation
import CanvasGraphics
import AudioKit

class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas : Canvas
    
    // Tortoise to draw with
    let turtle : Tortoise
    
    // Which direction to turn the turtle
    var turnRight = true
    
    // Set up objects needed for microphone analysis
    // SOURCE: https://audiokit.io/examples/MicrophoneAnalysis/
    var mic: AKMicrophone!
    var tracker: AKFrequencyTracker!
    var silence: AKBooster!
    
    // Track whether AudioKit has been started
    var audioKitStarted = false
    
    // Used to analyze mic input
    let noteFrequencies = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
    let noteNamesWithSharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
    let noteNamesWithFlats = ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"]
    
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Create turtle to draw with
        turtle = Tortoise(drawingUpon: canvas)
        
        // Move to middle of screen
        turtle.penUp()
        turtle.setPosition(to: Point(x: 250, y: 250))
        turtle.penDown()
        
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // How much to turn the turtle by
        var angle: Degrees = 1
        
        // On first frame, initialize the audio analysis
        if canvas.frameCount == 0 {
            
            // Ask for permission to access the microphone, then start audio kit
            getMicrophoneAccessPermission()

        }
        
        // See what's happening with the microphone, if AudioKit is available
        if audioKitStarted {
            
            updateMicrophoneInputAnalysis()
            
            // Adjust how the turtle will turn
            angle = Degrees(map(value: tracker.amplitude, fromLower: 0, fromUpper: 0.2, toLower: 1, toUpper: 5))
            
            // Change direction when loud sound occurs
            if angle > 2.5 {
                
                if turnRight == true {
                    turnRight = false
                } else {
                    turnRight = true
                }
                
            }
        }
        
        // Required to bring canvas into same orientation and origin position as last run of draw() function
        turtle.restoreStateOnCanvas()
        
        // Move the turtle forward and turn it a bit
        turtle.forward(steps: 1)
        if turnRight {
            turtle.right(by: angle)
        } else {
            turtle.left(by: angle)
        }
        
    }
    
    // Update analysis of input from mic
    func updateMicrophoneInputAnalysis() {
        
        if tracker.amplitude > 0.1 {
            let trackerFrequency = Float(tracker.frequency)
            
            guard trackerFrequency < 7_000 else {
                // This is a bit of hack because of modern Macbooks giving super high frequencies
                return
            }
            
            let frequencyText = String(format: "%0.1f", tracker.frequency)
            print("Frequency is: \(frequencyText)")
            
            var frequency = trackerFrequency
            while frequency > Float(noteFrequencies[noteFrequencies.count - 1]) {
                frequency /= 2.0
            }
            while frequency < Float(noteFrequencies[0]) {
                frequency *= 2.0
            }
            
            var minDistance: Float = 10_000.0
            var index = 0
            
            for i in 0..<noteFrequencies.count {
                let distance = fabsf(Float(noteFrequencies[i]) - frequency)
                if distance < minDistance {
                    index = i
                    minDistance = distance
                }
            }
            let octave = Int(log2f(trackerFrequency / frequency))
            
            let noteNameWithSharps =  "\(noteNamesWithSharps[index])\(octave)"
            print("Note name with sharps is: \(noteNameWithSharps)")
            let noteNameWithFlats = "\(noteNamesWithFlats[index])\(octave)"
            print("Note name with flats is: \(noteNameWithFlats)")
            
        }
        
        let amplitudeValue = String(format: "%0.2f", tracker.amplitude)
        print("Amplitude is: \(amplitudeValue)")
        
    }
    
    // This is necessary to gain access to the microphone
    func getMicrophoneAccessPermission() {
        
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.audio) {
        case .authorized: // The user has previously granted access to the camera.
            print("User has previously granted microphone access.")
            self.setupCaptureSession()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: AVMediaType.audio) { granted in
                if granted {
                    print("User granted microphone access.")
                    self.setupCaptureSession()
                } else {
                    print("Error: User did not grant microphone access.")
                }
            }
            
        case .denied: // The user has previously denied access.
            print("Error: User has previously denied access to the microphone.")
            
        case .restricted: // The user can't grant access due to restrictions.
            print("Error: User does not have permission to grant access to the microphone.")
        @unknown default:
            fatalError()
        }
        
    }
    
    // Setup microphone capture and start audio kit
    func setupCaptureSession() {

        // Allow for audio input
        AKSettings.audioInputEnabled = true
        
        // Set audio kit sample rate to match microphone sampling rate
        // NOTE: This is key to avoid a crash.
        // SEE: https://github.com/AudioKit/AudioKit/issues/1851
        AKSettings.sampleRate = AudioKit.engine.inputNode.inputFormat(forBus: 0).sampleRate
        
        // Initialize audio objects
        mic = AKMicrophone()
        tracker = AKFrequencyTracker(mic)
        silence = AKBooster(tracker, gain: 0)
        
        // Try starting AudioKit
        AudioKit.output = silence
        do {
            try AudioKit.start()
            audioKitStarted = true
        } catch {
            AKLog("AudioKit did not start!")
        }
        
        
    }
    
    
}
