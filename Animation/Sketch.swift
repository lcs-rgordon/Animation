import Foundation
import CanvasGraphics

class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas: Canvas
    
    // L-systems
    let anotherKochConstruction: LindenmayerSystem
    let kochIsland: LindenmayerSystem
    let coniferousTree: LindenmayerSystem
    
    // Visualized L-systems
    let visualKochConstruction: VisualizedLindenmayerSystem
    let visualKochIsland: VisualizedLindenmayerSystem
    let visualConiferousTree: VisualizedLindenmayerSystem
    let secondVisualConiferousTree: VisualizedLindenmayerSystem

    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Draw slowly
        //canvas.framesPerSecond = 1
                
        anotherKochConstruction = LindenmayerSystem(axiom: "S-F",
                                                    angle: 90,
                                                    rules: ["F": [RuleSet(odds: 1, successorText: "F+F-F-F+F")] ],
                                                    colors: [:],
                                                    generations: 4)

        kochIsland = LindenmayerSystem(axiom: "SF-F-F-F",
                                       angle: 90,
                                       rules: ["F": [RuleSet(odds: 1, successorText: "F-F+F+FF-F-F+F")]],
                                       colors: [:],
                                       generations: 3)
        
        // Create a stochastic system
        coniferousTree = LindenmayerSystem(axiom: "SF",
                                           angle: 20,
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
                                           generations: 5)
                
        // Visualized systems
        visualKochConstruction = VisualizedLindenmayerSystem(system: anotherKochConstruction,
                                                               length: 100,
                                                               initialDirection: 0,
                                                               reduction: 3,
                                                               pointToStartRenderingFrom: Point(x: 250, y: 100),
                                                               drawnOn: canvas)
        
        visualKochIsland = VisualizedLindenmayerSystem(system: kochIsland,
                                                       length: 50,
                                                       initialDirection: 0,
                                                       reduction: 3.75,
                                                       pointToStartRenderingFrom: Point(x: 0, y: 100),
                                                       drawnOn: canvas)
        
        visualConiferousTree = VisualizedLindenmayerSystem(system: coniferousTree,
                                                           length: 20,
                                                           initialDirection: 270,
                                                           reduction: 1.25,
                                                           pointToStartRenderingFrom: Point(x: 150, y: 400),
                                                           drawnOn: canvas)

        secondVisualConiferousTree = VisualizedLindenmayerSystem(system: coniferousTree,
                                                                   length: 10,
                                                                   initialDirection: 270,
                                                                   reduction: 1.25,
                                                                   pointToStartRenderingFrom: Point(x: 300, y: 450),
                                                                   drawnOn: canvas)

        // DEBUG:
        print("Rendering:")
        
        // Render the tree fully                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
        visualConiferousTree.renderFullSystem()
        secondVisualConiferousTree.renderFullSystem()
//        visualKochConstruction.renderFullSystem()
//        visualKochIsland.renderFullSystem()
        
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
//        // Update rendering of all systems for the current frame of the animation
//        kochIsland.update(forFrame: canvas.frameCount)
//        visualKochConstruction.update(forFrame: canvas.frameCount)
//        visualGordonSystem.update(forFrame: canvas.frameCount)
//        coniferousTree.update(forFrame: canvas.frameCount)

    }
    
}
