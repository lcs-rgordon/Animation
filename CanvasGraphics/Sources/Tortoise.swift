//
//  Turtle.swift
//  CanvasGraphics
//
//  Created by Russell Gordon on 2020-05-21.
//  Copyright © 2020 Royal St. George's College. All rights reserved.
//

import Foundation

extension Degrees {
    func asRadians() -> CGFloat {
        return self * CGFloat.pi / 180
    }
}

open class Tortoise {
    
    // Turtle state
    var drawing = true
    var heading: Degrees = 0
    var position: Point = Point(x: 0, y: 0)
    var penColor: Color = Color.black
    var fillColor: Color = Color.blue
    var filling: Bool = false
    var verticesForCurrentFill: [Point] = []
    var penSize: Int = 1
    
    // The canvas this turtle operates on
    let c: Canvas
    
    public init(drawingUpon: Canvas) {
        
        self.c = drawingUpon
        
        // No borders on shapes
        c.drawShapesWithBorders = false
        
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
        
        // Draw based on movement
        if drawing {
            c.drawLine(from: Point(x: 0, y: 0), to: Point(x: steps, y: 0))
        }
        c.translate(to: Point(x: steps, y: 0))
        
        // Update position relative to original origin
        self.position = Point(x: self.position.x + cos(self.heading.asRadians()) * CGFloat(steps),
                              y: self.position.y + sin(self.heading.asRadians()) * CGFloat(steps))
        
        // If filling, keep track of current position
        self.verticesForCurrentFill.append(self.position)
        
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
    
    open func setFillColor(to: Color) {
        
        self.fillColor = to
        c.fillColor = self.fillColor
        
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
    
    open func beginFill() {
        
        self.filling = true
        self.verticesForCurrentFill.append(self.position)
        
    }
    
    open func endFill() {
        
        c.translate(to: Point(x: -self.position.x, y: -self.position.y))
        c.drawCustomShape(with: verticesForCurrentFill)
        self.filling = false
        self.verticesForCurrentFill = []
        c.translate(to: Point(x: self.position.x, y: self.position.y))

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
    
    open func currentFillColor() -> Color {
        
        return self.fillColor
        
    }
        
}
