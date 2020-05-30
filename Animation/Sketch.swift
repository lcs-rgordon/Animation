import Foundation
import CanvasGraphics

class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas: Canvas
    
    // Tortoise to draw with
    let turtle: Tortoise
    let secondTurtle: Tortoise
    let thirdTurtle: Tortoise

    // L-systems
    let anotherKochConstruction: LindenmayerSystem
    let kochIsland: LindenmayerSystem
    let coniferousTree: LindenmayerSystem
    
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Draw slowly
        //canvas.framesPerSecond = 1
        
        // Create turtles to draw with
        turtle = Tortoise(drawingUpon: canvas)
        secondTurtle = Tortoise(drawingUpon: canvas)
        thirdTurtle = Tortoise(drawingUpon: canvas)

        // Create two deterministic systems
        anotherKochConstruction = LindenmayerSystem(axiom: "S-F",
                                                    length: 100,
                                                    initialDirection: 0,
                                                    angle: 90,
                                                    reduction: 3,
                                                    rules: ["F": [RuleSet(odds: 1, successorText: "F+F-F-F+F")] ],
                                                    generations: 4,
                                                    pointToStartRenderingFrom: Point(x: 250, y: 100),
                                                    turtleToRenderWith: turtle)
        
        kochIsland = LindenmayerSystem(axiom: "SF-F-F-F",
                                       length: 50,
                                       initialDirection: 0,
                                       angle: 90,
                                       reduction: 3.75,
                                       rules: ["F": [RuleSet(odds: 1, successorText: "F-F+F+FF-F-F+F")]],
                                       generations: 3,
                                       pointToStartRenderingFrom: Point(x: 0, y: 100),
                                       turtleToRenderWith: secondTurtle)
        
        // Create a stochastic system
        coniferousTree = LindenmayerSystem(axiom: "SF",
                                          length: 20,
                                          initialDirection: 270,
                                          angle: 21,
                                          reduction: 1.25,
                                          rules: ["F": [
                                                       RuleSet(odds: 1, successorText: "3F[++1F[X]][+2F][-4F][--5F[X]]6F"),
                                                       RuleSet(odds: 1, successorText: "3F[+1F][+2F][-4F]5F"),
                                                       RuleSet(odds: 1, successorText: "3F[+1F][-2F][--6F]4F"),
                                                       ],
                                                  "X": [
                                                       RuleSet(odds: 1, successorText: "X")
                                                       ]
                                                 ],
                                          colors: ["1": Color(hue: 120, saturation: 100, brightness: 61, alpha: 100),
                                                   "2": Color(hue: 134, saturation: 97, brightness: 46, alpha: 100),
                                                   "3": Color(hue: 145, saturation: 87, brightness: 8, alpha: 100),
                                                   "4": Color(hue: 135, saturation: 84, brightness: 41, alpha: 100),
                                                   "5": Color(hue: 116, saturation: 26, brightness: 100, alpha: 100),
                                                   "6": Color(hue: 161, saturation: 71, brightness: 53, alpha: 100)
                                                  ],
                                          generations: 5,
                                          pointToStartRenderingFrom: Point(x: 150, y: 400),
                                          turtleToRenderWith: thirdTurtle)
        
        // DEBUG:
        print("Rendering:")
        
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Update rendering of all systems for the current frame of the animation
        kochIsland.update(forFrame: canvas.frameCount)
        anotherKochConstruction.update(forFrame: canvas.frameCount)
        coniferousTree.update(forFrame: canvas.frameCount)

    }
    
}
