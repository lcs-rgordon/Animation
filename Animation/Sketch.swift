import Foundation
import CanvasGraphics

class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas : Canvas
    
    // Tortoise to draw with
    let turtle : Tortoise
    
    // L-system state
    let axiom : String
    var word : String
    let length : Int = 10
    let angle : Degrees = 60
        
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Draw slowly
        canvas.framesPerSecond = 1
        
        // Create turtle to draw with
        turtle = Tortoise(drawingUpon: canvas)
        
        // Move to middle of screen
        turtle.penUp()
        turtle.setPosition(to: Point(x: 250, y: 250))
        turtle.penDown()
        
        // Define the axiom
        axiom = "UFFF[+B][-B]"
        
        // Generation 0
        word = axiom
        
        // Re-write the word for two generations
        for generation in 1...2 {
            
            // Create an empty new word
            var newWord = ""
            
            // Write the new word based on the production rules
            for character in word {
                
                switch character {
                case "F":
                    newWord.append("F")
                case "B":
                    newWord.append("FF[+B][-B]")
                default:
                    newWord.append(character)
                }
            }
            
            // Replace the old word with the new word
            word = newWord
            print("After generation \(generation) the word is:")
            print(word)
            
        }
        
        // DEBUG:
        print("Rendering:")
                
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Required to bring canvas into same orientation and origin position as last run of draw() function
        turtle.restoreStateOnCanvas()

        // Render the alphabet of the axiom
        if canvas.frameCount < word.count {
            
            // Get an index for the current chracter in the axiom
            let index = word.index(word.startIndex, offsetBy: canvas.frameCount)
            let character = word[index]
            
            // DEBUG: What character is being rendered?
            print(character, terminator: "")
            
            // Render based on this character
            switch character {
            case "F", "B":
                turtle.forward(steps: length)
            case "+":
                turtle.right(by: angle)
            case "-":
                turtle.left(by: angle)
            case "[":
                turtle.saveState()
            case "]":
                turtle.restoreState()
            case "U":
                turtle.left(by: 90)
            default:
                break
            }
            
        }
        
    }
    
}
