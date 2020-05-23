import Foundation
import CanvasGraphics

class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas: Canvas
    
    // Tortoise to draw with
    let turtle: Tortoise
    
    // L-system definition
    let axiom: String = "S-F"
    let length: Double = 100
    let angle: Degrees = 90
    let reduction: Double = 3
    let rules: [Character:String] = ["F":"F+F-F-F+F"]
    let generations: Int = 4
    let pointToStartRenderingFrom: Point = Point(x: 250, y: 100)
    
    // L-system interpreter state
    var word: String
    var currentLength: Double
    
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Draw slowly
        //canvas.framesPerSecond = 1
        
        // Create turtle to draw with
        turtle = Tortoise(drawingUpon: canvas)
                
        // Generation 0
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
                
        // DEBUG:
        print("Rendering:")
        
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Required to bring canvas into same orientation and origin position as last run of draw() function
        turtle.restoreStateOnCanvas()
        
        // Render the alphabet of the L-system
        if canvas.frameCount < word.count {
            
            // Get an index for the current chracter in the axiom
            let index = word.index(word.startIndex, offsetBy: canvas.frameCount)
            let character = word[index]
            
            // DEBUG: What character is being rendered?
            print(character, terminator: "")
            
            // Render based on this character
            switch character {
            case "S":
                turtle.penUp()
                turtle.setPosition(to: pointToStartRenderingFrom)
                turtle.penDown()
            case "F":
                turtle.forward(steps: currentLength)
            case "+":
                turtle.right(by: angle)
            case "-":
                turtle.left(by: angle)
            default:
                break
            }
            
        }
        
    }
    
}
