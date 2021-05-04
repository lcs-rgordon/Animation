//
//  LindemayerSystemSketch.swift
//  Animation
//
//  Created by Russell Gordon on 2021-05-04.
//

import Foundation
import CanvasGraphics

// NOTE: This is a completely empty sketch; it can be used as a template.
class LindenmayerSystemSketch: NSObject, Sketchable {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    var canvas: Canvas
    
    // Tortoise to draw with
    let turtle: Tortoise
    
    // MARK: L-system state
    
    // What the system will draw, without any re-writes based upon production rules
    let axiom: String
    
    // What the system will draw, after re-writes based upon production rules
    var word: String
    
    // How many times to re-write the word, based upon production rules
    let generations: Int
    
    // The rules the define how the word is re-written with each new generation
    let rules: [Character: String]
    
    // MARK: L-system rendering instructions
    
    // The length of the line segments used when drawing the system, at generation 0
    var length: Double
    
    // The factor by which to reduce the initial line segment length after each generation / word re-write
    let reduction: Double
    
    // The angle by which the turtle will turn left or right; in degrees.
    let angle: Degrees
    
    // Where the turtle begins drawing on the canvas
    let initialPosition: Point
    
    // The initial direction of the turtle
    let initialHeading: Degrees
    
    // This function runs once
    override init() {
        
        // MARK: Canvas and turtle setup
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Draw slowly
        canvas.framesPerSecond = 1
        
        // Create turtle to draw with
        turtle = Tortoise(drawingUpon: canvas)
        
        // MARK: Initialize L-system state
        
        // What the system will draw, without any re-writes based upon production rules
        axiom = "FFF[+B][-B]"
        
        // DEBUG: What's the word?
        print("Axiom is:")
        print("\(axiom)")

        // Generation 0 – we begin with the word the same as the axiom
        word = axiom
        
        // How many times to re-write the word, based upon production rules
        generations = 0
        
        // The rules the define how the word is re-written with each new generation
        rules = [
            "F" : "F",
            "B" : "FF[+B][-B]"
        ]
        
        // Only write a new word if there are more than 0 generations
        if generations > 0 {
            
            // Re-write the word
            for generation in 1...generations {
                
                // Create an empty new word
                var newWord = ""
                
                // Replace each character in the word, based on the production rules
                for character in word {
                    
                    // When a value exists for the key, use it, otherwise, replace with the key
                    // e.g.: If "B", replace with "FF[+B][-B]"
                    // e.g.: If "U", there is no value for "U" in the dictionary, so replace with "U"
                    newWord.append(rules[character] ?? String(character))
                    
                }
                                
                // Replace the old word with the new word
                word = newWord
                print("After generation \(generation) the word is:")
                print(word)
                
            }
            
        }
        
        // MARK: Initialize L-system rendering instructions
        
        // The length of the line segments used when drawing the system, at generation 0
        length = 80
        
        // The factor by which to reduce the initial line segment length after each generation / word re-write
        reduction = 2
        
        // The angle by which the turtle will turn left or right; in degrees.
        angle = 60
        
        // Where the turtle begins drawing on the canvas
        initialPosition = Point(x: 250, y: 100)
        
        // The initial direction of the turtle
        initialHeading = 90
        
        // MARK: Prepare for rendering L-system
        
        // Set the length based on number of generations
        if generations > 0 {
            for _ in 1...generations {
                length /= reduction
            }
        }
        
        // Move to designated starting position
        turtle.penUp()
        turtle.setPosition(to: initialPosition)
        turtle.setHeading(to: initialHeading)
        turtle.penDown()
        
        // DEBUG:
        print("\nNow rendering...\n")
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Required to bring canvas into same orientation and origin position as last run of draw() function
        if canvas.frameCount > 0 {
            turtle.restoreStateOnCanvas()
        }
            
        // Only run rendering logic until the end of the number of characters in the word
        if canvas.frameCount < word.count {
            
            // Get an index for the current chracter in the word
            let index = word.index(word.startIndex, offsetBy: canvas.frameCount)
            let character = word[index]
            
            // DEBUG: What character is being rendered?
            print(character)
            
            // Render based on this character
            switch character {
            case "F", "B":
                // Move turtle forward (rounding off to nearest integer)
                turtle.forward(steps: Int(round(length)))
                print("Forward\n")
            case "+":
                // Turn to the left
                turtle.left(by: angle)
                print("Turn left\n")
            case "-":
                // Turn to the right
                turtle.right(by: angle)
                print("Turn right\n")
            case "[":
                // Save position and heading
                turtle.saveState()
                print("Save current state (position and heading)\n")
            case "]":
                // Restore position and heading
                turtle.restoreState()
                print("Restore most recently saved state from stack (position and heading)\n")
            default:
                break
            }
            
            // Render turtle so that it's clear what's happening
            turtle.drawSelf()
            
        }
                
        
    }
    
}
