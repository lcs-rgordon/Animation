////
////  AudioAnalyser.swift
////  Animation
////
////  Created by Russell Gordon on 2020-06-08.
////  Copyright © 2020 Russell Gordon. All rights reserved.
////
//
//import Foundation
//import CanvasGraphics
//import AudioKit
//
//enum AudioAnalyserDebugLevels: Int {
//
//    case none = 0
//    case amplitudeOnly
//    case frequencyOnly
//    case notesOnly
//    case amplitudeAndFrequency
//    case amplitudeAndNotes
//    case frequencyAndNotes
//    case amplitudeFrequencyAndNotes
//    
//}
//
//// Describes results of the analysis
//public struct AudioAnalyserResult {
//    
//    var frequency: Double
//    var amplitude: Double
//    var noteNameWithSharps: String
//    var noteNameWithFlats: String
//    var octave: Int
//    
//}
//
//public class AudioAnalyser {
//    
//    // MARK: - Properties
//    
//    // Canvas this audio analyser is working with
//    var c: Canvas
//    
//    // What type of debug output to provide
//    var debugLevel: AudioAnalyserDebugLevels
//    
//    // What the threshold for analysing notes based upon amplitude should be
//    var analysisThresholdByAmplitude: Double
//    
//    // What the threshold for analysing notes based upon frequency should be
//    var analysisThresholdByFrequency: Float
//    
//    // Whether to filter by frequency
//    var filterByFrequency: Bool
//
//    // Results of current analysis
//    var result: AudioAnalyserResult?
//    
//    // Set up objects needed for microphone analysis
//    // SOURCE: https://audiokit.io/examples/MicrophoneAnalysis/
//    var mic: AKMicrophone!
//    var tracker: AKFrequencyTracker!
//    var silence: AKBooster!
//    
//    // Track whether AudioKit has been started
//    var audioKitStarted = false
//    
//    // Used to analyze mic input
//    let noteFrequencies = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
//    let noteNamesWithSharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
//    let noteNamesWithFlats = ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"]
//    
//    // MARK: - Initializers
//    init(listeningFor: Canvas, analysisThresholdByAmplitude: Double = 0.1, debugLevel: AudioAnalyserDebugLevels = .none, analysisThresholdByFrequency: Float = 7_000, filterByFrequency: Bool = false) {
//        
//        // Initialize structure properties
//        self.c = listeningFor
//        self.analysisThresholdByAmplitude = analysisThresholdByAmplitude
//        self.debugLevel = debugLevel
//        self.analysisThresholdByFrequency = analysisThresholdByFrequency
//        self.filterByFrequency = filterByFrequency
//        
//    }
//    
//    // MARK: - Methods
//    func update() -> AudioAnalyserResult? {
//        
//        // On first frame, initialize the audio analysis
//        if c.frameCount == 0 {
//            
//            // Ask for permission to access the microphone, then start audio kit
//            getMicrophoneAccessPermission()
//
//        }
//        
//        // Now update the result, if AudioKit has been initialized
//        if audioKitStarted {
//            updateMicrophoneInputAnalysis()
//        }
//
//        // Return whatever result we have available
//        return result
//        
//    }
//    
//    // Update analysis of input from mic
//    func updateMicrophoneInputAnalysis() {
//
//        // Set up the result
//        result = AudioAnalyserResult(frequency: 0,
//                                     amplitude: 0,
//                                     noteNameWithSharps: "",
//                                     noteNameWithFlats: "",
//                                     octave: 0)
//        
//        // Get the amplitude
//        let amplitudeValue = String(format: "%0.2f", tracker.amplitude)
//        result?.amplitude = tracker.amplitude
//        
//        // Report on amplitude
//        if debugLevel == .amplitudeAndFrequency ||
//            debugLevel == .amplitudeAndNotes ||
//            debugLevel == .amplitudeOnly ||
//            debugLevel == .amplitudeFrequencyAndNotes {
//            print("Amplitude is:\t\t\t\t\(amplitudeValue)")
//        }
//
//        if tracker.amplitude > analysisThresholdByAmplitude {
//            
//            let trackerFrequency = Float(tracker.frequency)
//            result?.frequency = tracker.frequency
//            let frequencyText = String(format: "%0.1f", tracker.frequency)
//
//            if filterByFrequency {
//
//                guard trackerFrequency < 7_000 else {
//
//                    // This is a bit of hack because of modern Macbooks giving super high frequencies
//                    if debugLevel != .none {
//                        
//                        if debugLevel == .amplitudeAndFrequency ||
//                            debugLevel == .frequencyAndNotes ||
//                            debugLevel == .frequencyOnly ||
//                            debugLevel == .amplitudeFrequencyAndNotes {
//                            print("Frequency is:\t\t\t\t\(frequencyText)")
//                        }
//
//                        if debugLevel == .amplitudeAndNotes ||
//                            debugLevel == .frequencyAndNotes ||
//                            debugLevel == .notesOnly ||
//                            debugLevel == .amplitudeFrequencyAndNotes {
//
//                            print("Note name with sharps is:\tNot available – frequency over analysis threshold of \(analysisThresholdByFrequency)")
//                            print("Note name with flats is:\tNot available – frequency over analysis threshold of \(analysisThresholdByFrequency)")
//                            print("Octave is:\t\t\t\t\tNot available – frequency over analysis threshold of \(analysisThresholdByFrequency)")
//
//                        }
//                        
//                    }
//                    
//                    // Separate the results so they are more easily read
//                    if debugLevel != .none {
//                        print("--")
//                    }
//
//                    // End analysis, we are below the threshold frequency
//                    return
//
//                }
//
//            }
//            
//            // OK, we are over the threshold frequency, so analysis can continue
//            if debugLevel == .amplitudeAndFrequency ||
//                debugLevel == .frequencyAndNotes ||
//                debugLevel == .frequencyOnly ||
//                debugLevel == .amplitudeFrequencyAndNotes {
//                print("Frequency is:\t\t\t\t\(frequencyText)")
//            }
//            
//            var frequency = trackerFrequency
//            while frequency > Float(noteFrequencies[noteFrequencies.count - 1]) {
//                frequency /= 2.0
//            }
//            while frequency < Float(noteFrequencies[0]) {
//                frequency *= 2.0
//            }
//            
//            var minDistance: Float = 10_000.0
//            var index = 0
//            
//            for i in 0..<noteFrequencies.count {
//                let distance = fabsf(Float(noteFrequencies[i]) - frequency)
//                if distance < minDistance {
//                    index = i
//                    minDistance = distance
//                }
//            }
//            let octave = Int(log2f(trackerFrequency / frequency))
//            result?.octave = octave
//            
//            let noteNameWithSharps =  "\(noteNamesWithSharps[index])\(octave)"
//            result?.noteNameWithSharps = noteNameWithSharps
//            let noteNameWithFlats = "\(noteNamesWithFlats[index])\(octave)"
//            result?.noteNameWithFlats = noteNameWithFlats
//
//            if debugLevel == .amplitudeAndNotes ||
//                debugLevel == .frequencyAndNotes ||
//                debugLevel == .notesOnly ||
//                debugLevel == .amplitudeFrequencyAndNotes {
//
//                print("Note name with sharps is:\t\(noteNameWithSharps)")
//                print("Note name with flats is:\t\(noteNameWithFlats)")
//                print("Octave is:\t\t\t\t\t\(octave)")
//
//            }
//            
//        } else {
//            
//            // Could not determine these values since amplitude below threshold
//            
//            if debugLevel == .amplitudeAndFrequency ||
//                debugLevel == .frequencyAndNotes ||
//                debugLevel == .frequencyOnly ||
//                debugLevel == .amplitudeFrequencyAndNotes {
//                print("Frequency is:\t\t\t\tNot available – amplitude under analysis threshold of \(analysisThresholdByAmplitude)")
//            }
//
//            if debugLevel == .amplitudeAndNotes ||
//                debugLevel == .frequencyAndNotes ||
//                debugLevel == .notesOnly ||
//                debugLevel == .amplitudeFrequencyAndNotes {
//
//                print("Note name with sharps is:\tNot available – amplitude under analysis threshold of \(analysisThresholdByAmplitude)")
//                print("Note name with flats is:\tNot available – amplitude under analysis threshold of \(analysisThresholdByAmplitude)")
//                print("Octave is:\t\t\t\t\tNot available – amplitude under analysis threshold of \(analysisThresholdByAmplitude)")
//
//            }
//
//            
//        }
//        
//        // Separate the results so they are more easily read
//        if debugLevel != .none {
//            print("--")
//        }
//                        
//    }
//    
//    // This is necessary to gain access to the microphone
//    func getMicrophoneAccessPermission() {
//        
//        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.audio) {
//        case .authorized: // The user has previously granted access to the camera.
//            print("User has previously granted microphone access.")
//            self.setupCaptureSession()
//            
//        case .notDetermined: // The user has not yet been asked for camera access.
//            AVCaptureDevice.requestAccess(for: AVMediaType.audio) { granted in
//                if granted {
//                    print("User granted microphone access.")
//                    self.setupCaptureSession()
//                } else {
//                    print("Error: User did not grant microphone access.")
//                }
//            }
//            
//        case .denied: // The user has previously denied access.
//            print("Error: User has previously denied access to the microphone.")
//            
//        case .restricted: // The user can't grant access due to restrictions.
//            print("Error: User does not have permission to grant access to the microphone.")
//        @unknown default:
//            fatalError()
//        }
//        
//    }
//    
//    // Setup microphone capture and start audio kit
//    func setupCaptureSession() {
//
//        // Allow for audio input
//        AKSettings.audioInputEnabled = true
//        
//        // Set audio kit sample rate to match microphone sampling rate
//        // NOTE: This is key to avoid a crash.
//        // SEE: https://github.com/AudioKit/AudioKit/issues/1851
//        AKSettings.sampleRate = AudioKit.engine.inputNode.inputFormat(forBus: 0).sampleRate
//        
//        // Initialize audio objects
//        mic = AKMicrophone()
//        tracker = AKFrequencyTracker(mic)
//        silence = AKBooster(tracker, gain: 0)
//        
//        // Try starting AudioKit
//        AudioKit.output = silence
//        do {
//            try AudioKit.start()
//            audioKitStarted = true
//        } catch {
//            AKLog("AudioKit did not start!")
//        }
//        
//        
//    }
//    
//}
