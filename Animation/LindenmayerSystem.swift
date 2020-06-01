//
//  LindenmayerSystem.swift
//  Animation
//
//  Created by Russell Gordon on 2020-05-22.
//  Copyright © 2020 Royal St. George's College. All rights reserved.
//

import Foundation
import CanvasGraphics

struct RuleSet {
    let odds: Int
    let successorText: String
}

struct LindenmayerSystem {
    
    // Definition of system
    let axiom: String
    let angle: Degrees
    let rules: [Character:[RuleSet]]
    var colors: [Character:Color]
    let generations: Int
         
    // System state
    var word: String = ""

    init(axiom: String,
         angle: Degrees,
         rules: [Character:[RuleSet]],
         colors: [Character:Color] = [:],
         generations: Int) {
        
        // Initialize instance properties
        self.axiom = axiom
        self.angle = angle
        self.rules = rules
        self.colors = colors
        self.generations = generations
        
    }
    
    mutating func regenerate() {
        
        // Set up the system state
        word = axiom
        
        // Re-write the word for each generation
        for generation in 1...generations {
            
            // Create an empty new word
            var newWord = ""
            
            // Inspect each character of the old word
            for character in word {
                
                // Iterate over all the rules
                var match = false
                for (predecessor, successorRuleSet) in rules {
                    
                    // When a character matches, apply the rule
                    if predecessor == character {
                        
                        // Determine total of odds in RuleSet
                        var total = 0
                        for successorRule in successorRuleSet {
                            total += successorRule.odds
                        }
                        
                        // Generate a random integer between 1 and the total odds
                        let randomValue = Int.random(in: 1...total)
                        
                        // Find the rule to apply
                        var runningTotal = 0
                        for successorRule in successorRuleSet {
                            runningTotal += successorRule.odds
                            
                            // See if this is the rule to apply
                            if randomValue <= runningTotal {
                                
                                // Re-write the word based on selected rule
                                newWord.append(successorRule.successorText)
                                match = true
                                break // end the loop looking for a rule to apply
                            }
                        }
                        
                    }
                    
                }
                
                // If no match to rules, just copy the character to the new word
                if match == false {
                    newWord.append(character)
                }
                
            }
            
            // Replace the old word with the new word
            word = newWord
            
//            // DEBUG: Uncomment below for debugging
//            print("After generation \(generation) the word is:")
//            print(word)
                        
        }
        
    }
    
}
