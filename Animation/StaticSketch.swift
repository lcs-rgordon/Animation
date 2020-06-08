//
//  StaticSketch.swift
//  Animation
//
//  Created by Russell Gordon on 2020-06-08.
//  Copyright © 2020 Russell Gordon. All rights reserved.
//

import Foundation
import CanvasGraphics

// NOTE: This sketch only draws in the init() function, so it is static.
class StaticSketch: NSObject, Sketchable {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    var canvas: Canvas
    
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 300, height: 600)
        
        // Draw a face
        canvas.fillColor = .white
        canvas.defaultBorderWidth = 5
        canvas.drawEllipse(at: Point(x: 150, y: 300), width: 200, height: 200)

        // Draw eyes
        canvas.drawEllipse(at: Point(x: 125, y: 325), width: 10, height: 20)
        canvas.drawEllipse(at: Point(x: 175, y: 325), width: 10, height: 20)

        // Draw mouth
        canvas.drawEllipse(at: Point(x: 150, y: 270), width: 100, height: 30)

        // Turn mouth into a smile by covering up top half of mouth
        canvas.drawShapesWithBorders = false
        canvas.drawRectangle(at: Point(x: 150, y: 275), width: 125, height: 25, anchoredBy: .centre)
                
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        
    }
    
}

