//
//  VisualizedLindenmayerSystem.swift
//  Animation
//
//  Created by Russell Gordon on 2020-05-30.
//  Copyright © 2020 Royal St. George's College. All rights reserved.
//

import Foundation
import CanvasGraphics

struct VisualizedLindenmayerSystem {
    
    // The system to visualize
    let system: LindenmayerSystem
    
    // How to visualize the system
    let length: Double
    let initialDirection: Degrees
    let reduction: Double
    let pointToStartRenderingFrom: Point
        
    // Turtle to draw with
    let t: Tortoise
    
    // Rendering state
    var currentLength: Double = 0

    init(system: LindenmayerSystem,
         length: Double,
         initialDirection: Degrees,
         reduction: Double,
         pointToStartRenderingFrom: Point,
         drawnOn canvas: Canvas) {
        
        // Initialize instance properties
        self.system = system
        self.length = length
        self.currentLength = self.length
        self.initialDirection = initialDirection
        self.reduction = reduction
        self.pointToStartRenderingFrom = pointToStartRenderingFrom
        self.t = Tortoise(drawingUpon: canvas)
            
        // Reduce the line length after generation 1
        for _ in 1...system.generations - 1 {
            currentLength /= reduction
        }
        
    }
    
    // Render the next character of the system using the turtle provided
    func update(forFrame currentFrame: Int) {
        
        // Save current state of the canvas so that next L-system has "clean slate" to work with
        t.saveStateOfCanvas()
        
        // Required to bring canvas into same orientation and origin position as last run of draw() function for this turtle
        t.restoreStateOnCanvas()
        
        // Render the alphabet of the L-system
        if currentFrame < system.word.count {
            
            // Get an index for the current chracter in the axiom
            let index = system.word.index(system.word.startIndex, offsetBy: currentFrame)
            let character = system.word[index]
            
            // Render the character
            self.render(command: character)
            
        }
        
        // Save state of the canvas so that next L-system has "clean slate" to work with
        t.restoreStateOfCanvas()
        
    }
    
    func renderFullSystem() {
                
        for character in system.word {
            
            // Save current state of the canvas so that next L-system has "clean slate" to work with
            t.saveStateOfCanvas()
            
            // Required to bring canvas into same orientation and origin position as last run of draw() function for this turtle
            t.restoreStateOnCanvas()
            
            self.render(command: character)
            
            // Save state of the canvas so that next L-system has "clean slate" to work with
            t.restoreStateOfCanvas()
            
        }
                
    }
    
    // Render a specific character, or command, in the L-system
    private func render(command: Character) {
        
        // Render based on this character
        print(command, terminator: "")
        switch command {
        case "S":
            t.penUp()
            t.setPosition(to: pointToStartRenderingFrom)
            t.left(by: initialDirection)
            t.penDown()
        case "F", "X":
            t.forward(steps: currentLength)
        case "+":
            t.right(by: system.angle)
        case "-":
            t.left(by: system.angle)
        case "[":
            t.saveState()
        case "]":
            t.restoreState()
        case "1","2","3","4","5","6","7","8","9":
            if let providedColor = system.colors[command] {
                t.setPenColor(to: providedColor)
            }
        default:
            break
        }
        
    }
    
}
                                                                                                                                                                    
