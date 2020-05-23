//
//  LindenmayerSystem.swift
//  Animation
//
//  Created by Russell Gordon on 2020-05-22.
//  Copyright © 2020 Royal St. George's College. All rights reserved.
//

import Foundation
import CanvasGraphics

struct LindenmayerSystem {
    
    // Definition of system
    let axiom: String
    let length: Double
    let angle: Degrees
    let reduction: Double
    let rules: [Character:String]
    let generations: Int
    let pointToStartRenderingFrom: Point

    // Rendering state
    var word: String = ""
    var currentLength: Double = 0
    
    // Turtle to draw with
    let t: Tortoise

    init(axiom: String, length: Double, angle: Degrees, reduction: Double, rules: [Character:String], generations: Int, pointToStartRenderingFrom: Point, turtleToRenderWith: Tortoise) {
        
        self.axiom = axiom
        self.length = length
        self.angle = angle
        self.reduction = reduction
        self.rules = rules
        self.generations = generations
        self.pointToStartRenderingFrom = pointToStartRenderingFrom
        self.t = turtleToRenderWith
        
        // Set up the system state
        word = axiom
        currentLength = length
        
        // Re-write the word for each generation
        for generation in 1...generations {
            
            // Create an empty new word
            var newWord = ""
            
            // Inspect each character of the old word
            for character in word {
                
                // Iterate over all the rules
                var match = false
                for (key, value) in rules {
                    
                    // When a character matches, apply the rule
                    if key == character {
                        newWord.append(value)
                        match = true
                    }
                    
                }
                
                // If no match to rules, just copy the character to the new word
                if match == false {
                    newWord.append(character)
                }
                
            }
            
            // Replace the old word with the new word
            word = newWord
            print("After generation \(generation) the word is:")
            print(word)
            
            // Reduce the line length after generation 1
            if generation > 1 {
                currentLength /= reduction
            }
            
        }

    }
    
    // Render the next character of the system using the turtle provided
    func update(forFrame currentFrame: Int) {
        
        // Save current state of the canvas so that next L-system has "clean slate" to work with
        t.saveStateOfCanvas()
        
        // Required to bring canvas into same orientation and origin position as last run of draw() function for this turtle
        t.restoreStateOnCanvas()
        
        // Render the alphabet of the L-system
        if currentFrame < word.count {
            
            // Get an index for the current chracter in the axiom
            let index = word.index(word.startIndex, offsetBy: currentFrame)
            let character = word[index]
            
            // DEBUG: What character is being rendered?
            print(character, terminator: "")
            
            // Render based on this character
            switch character {
            case "S":
                t.penUp()
                t.setPosition(to: pointToStartRenderingFrom)
                t.penDown()
            case "F":
                t.forward(steps: currentLength)
            case "+":
                t.right(by: angle)
            case "-":
                t.left(by: angle)
            default:
                break
            }
            
        }
        
        // Save state of the canvas so that next L-system has "clean slate" to work with
        t.restoreStateOfCanvas()
        
    }
    
}
