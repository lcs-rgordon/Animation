//
//  Turtle.swift
//  CanvasGraphics
//
//  Created by Russell Gordon on 2020-05-21.
//  Copyright © 2020 Royal St. George's College. All rights reserved.
//

import Foundation

open class Tortoise {
    
    // Turtle state
    var drawing = true
    
    // The canvas this turtle operates on
    let c: Canvas
    
    
    public init(drawingUpon: Canvas) {
        
        self.c = drawingUpon
        
    }
    
    open func penDown() {
        
        self.drawing = true
        
    }
    
    open func penUp() {
        
        self.drawing = false
        
    }
    
    open func isPenDown() -> Bool {
        
        return self.drawing
        
    }
    
    open func right(by angle: Degrees) {
        
        c.rotate(by: angle)
        
    }
    
    open func left(by angle: Degrees) {
        
        self.right(by: -angle)
        
    }
    
    open func forward(steps: Int) {
        
        if drawing {
            c.drawLine(from: Point(x: 0, y: 0), to: Point(x: steps, y: 0))
        }
        c.translate(to: Point(x: steps, y: 0))
        
    }
        
}
