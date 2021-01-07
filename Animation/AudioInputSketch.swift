////
////  TurtleBasedSketch.swift
////  Animation
////
////  Created by Russell Gordon on 2020-06-08.
////  Copyright © 2020 Russell Gordon. All rights reserved.
////
//
//import Foundation
//import CanvasGraphics
//
//// NOTE: This sketch reacts to audio input. Try talking loudly, or even shouting,
////       while the sketch draws. 🙂
//class AudioInputSketch: NSObject, Sketchable {
//    
//    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
//    //       Therefore, the line immediately below must always be present.
//    var canvas: Canvas
//    
//    // Tortoise to draw with
//    let turtle: Tortoise
//    
//    // Audio analyser
//    let analyser: AudioAnalyser
//    
//    // Which direction to turn the turtle
//    var turnRight = true
//        
//    // This function runs once
//    override init() {
//        
//        // Create canvas object – specify size
//        canvas = Canvas(width: 500, height: 500)
//        
//        // Create turtle to draw with
//        turtle = Tortoise(drawingUpon: canvas)
//        
//        // Create an audio analysis object
//        analyser = AudioAnalyser(listeningFor: canvas,
//                                 analysisThresholdByAmplitude: 0.001,
//                                 debugLevel: .amplitudeFrequencyAndNotes,
//                                 analysisThresholdByFrequency: 7_000,
//                                 filterByFrequency: true)
//        
//        // Move to middle of screen
//        turtle.penUp()
//        turtle.setPosition(to: Point(x: 250, y: 250))
//        turtle.penDown()
//        
//    }
//    
//    // This function runs repeatedly, forever, to create the animated effect
//    func draw() {
//        
//        // How much to turn the turtle by
//        var angle: Degrees = 1
//
//        // Update the analysis of input from the microphone
//        // NOTE: Until the user grants permission to access the mic, there
//        //       will be no analysis results, so we must check to verify that
//        //       the result of the microphone analysis is not nil
//        if let result = analyser.update() {
//
//            // Adjust how the turtle will turn
//             angle = Degrees(map(value: result.amplitude,
//                                 fromLower: 0,
//                                 fromUpper: 0.2,
//                                 toLower: 1,
//                                 toUpper: 5))
//             
//             // Change direction when a loud sound occurs
//             if angle > 2.5 {
//                 
//                 if turnRight == true {
//                     turnRight = false
//                 } else {
//                     turnRight = true
//                 }
//                 
//             }
//        }
//       
//        // Required to bring canvas into same orientation and origin position as last run of draw() function
//        turtle.restoreStateOnCanvas()
//        
//        // Move the turtle forward and turn it a bit
//        turtle.forward(steps: 1)
//        if turnRight {
//            turtle.right(by: angle)
//        } else {
//            turtle.left(by: angle)
//        }
//        
//    }
//    
//}
