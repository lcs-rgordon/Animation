//
//  TurtleBasedSketch.swift
//  Animation
//
//  Created by Russell Gordon on 2020-06-08.
//  Copyright © 2020 Russell Gordon. All rights reserved.
//

import Foundation
import CanvasGraphics

class TurtleSketch: NSObject, Sketchable {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    var canvas: Canvas
    
    // Tortoise to draw with
    let turtle: Tortoise
        
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Create turtle to draw with
        turtle = Tortoise(drawingUpon: canvas)
        
        // Move to middle of screen
        turtle.penUp()
        turtle.setPosition(to: Point(x: 250, y: 250))
        turtle.penDown()

    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Required to bring canvas into same orientation and origin position as last run of draw() function
        turtle.restoreStateOnCanvas()

        // Move the turtle forward and turn it a bit
        turtle.forward(steps: 5)
        turtle.right(by: 1)
        
    }
    
}
