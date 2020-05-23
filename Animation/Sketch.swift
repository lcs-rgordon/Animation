import Foundation
import CanvasGraphics

class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas: Canvas
    
    // Tortoise to draw with
    let turtle: Tortoise
    let secondTurtle: Tortoise
    
    // L-systems
    let anotherKochConstruction: LindenmayerSystem
    let kochIsland: LindenmayerSystem
    
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Draw slowly
        //canvas.framesPerSecond = 1
        
        // Create turtles to draw with
        turtle = Tortoise(drawingUpon: canvas)
        secondTurtle = Tortoise(drawingUpon: canvas)
        
        // Create the systems
        anotherKochConstruction = LindenmayerSystem(axiom: "S-F",
                                                    length: 100,
                                                    angle: 90,
                                                    reduction: 3,
                                                    rules: ["F":"F+F-F-F+F"],
                                                    generations: 4,
                                                    pointToStartRenderingFrom: Point(x: 250, y: 100),
                                                    turtleToRenderWith: turtle)
        
        kochIsland = LindenmayerSystem(axiom: "SF-F-F-F",
                                       length: 50,
                                       angle: 90,
                                       reduction: 3.75,
                                       rules: ["F":"F-F+F+FF-F-F+F"],
                                       generations: 3,
                                       pointToStartRenderingFrom: Point(x: 0, y: 100),
                                       turtleToRenderWith: secondTurtle)
        
        // DEBUG:
        print("Rendering:")
        
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Update rendering of all systems for the current frame of the animation
        kochIsland.update(forFrame: canvas.frameCount)
        anotherKochConstruction.update(forFrame: canvas.frameCount)

    }
    
}
