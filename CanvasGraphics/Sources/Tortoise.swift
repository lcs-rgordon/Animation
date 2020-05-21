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
    var heading: Degrees = 0
    var position: Point = Point(x: 0, y: 0)
    var penColor: Color = Color.black
    var penSize: Int = 1
    
    // The canvas this turtle operates on
    let c: Canvas
    
    public init(drawingUpon: Canvas) {
        
        self.c = drawingUpon
        
    }
    
    // MARK: Change state

    open func penDown() {
        
        self.drawing = true
        
    }
    
    open func penUp() {
        
        self.drawing = false
        
    }
    
    open func right(by angle: Degrees) {
        
        self.heading -= angle
        c.rotate(by: -angle)
        
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
    
    open func backward(steps: Int) {
        
        self.forward(steps: -steps)
        
    }
    
    open func setHeading(to: Degrees) {
        
        let relativeHeading = to - self.currentHeading()
        self.heading = to
        c.rotate(by: relativeHeading)
        
    }
    
    open func setPosition(to: Point) {

        let relativePosition = Point(x: to.x - self.position.x, y: to.y - self.position.y)
        self.position = to
        c.translate(to: relativePosition)
        
    }
    
    open func setX(to: CGFloat) {
        
        self.setPosition(to: Point(x: to, y: self.position.y))
        
    }
    
    open func setX(to: Double) {
        
        self.setPosition(to: Point(x: CGFloat(to), y: CGFloat(self.position.y)))
        
    }

    open func setX(to: Int) {
        
        self.setPosition(to: Point(x: Int(to), y: Int(self.position.y)))
        
    }

    open func setY(to: CGFloat) {
        
        self.setPosition(to: Point(x: self.position.x, y: to))

    }
    
    open func setY(to: Double) {
        
        self.setPosition(to: Point(x: CGFloat(self.position.x), y: CGFloat(to)))

    }

    open func setY(to: Int) {
        
        self.setPosition(to: Point(x: Int(self.position.x), y: Int(to)))
        
    }
    
    open func setPenColor(to: Color) {
        
        self.penColor = to
        c.lineColor = self.penColor
        
    }
    
    open func setPenSize(to: Int) {
        
        if to > 0 {
            self.penSize = to
            c.defaultLineWidth = self.penSize
        }
        
    }
    
    open func goToHome() {
        
        self.setPosition(to: Point(x: 0, y: 0))
        self.setHeading(to: 0)
        
    }

    
    // MARK: Interrogate state

    open func currentHeading() -> Degrees {
        
        return self.heading
        
    }
    
    open func currentPosition() -> Point {
        
        return self.position
        
    }
    
    open func isPenDown() -> Bool {
        
        return self.drawing
        
    }
    
    open func currentPenColor() -> Color {
        
        return self.penColor
        
    }
    
    open func currentPenSize() -> Int {
        
        return self.penSize
        
    }
    

        
}
