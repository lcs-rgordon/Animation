//
//  Turtle.swift
//  CanvasGraphics
//
//  Created by Russell Gordon on 2020-05-21.
//  Copyright © 2020 Royal St. George's College. All rights reserved.
//

import Foundation

/// Allow an angle mesaure in degrees to be converted to radians.
extension Degrees {
    func asRadians() -> CGFloat {
        return self * CGFloat.pi / 180
    }
}

/// Abstraction layer to allow drawing on a Canvas instance with a "LOGO turtle" metaphor
open class Tortoise: CustomPlaygroundDisplayConvertible {
    
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
    
    /// Creates a tortoise object that you can use to drive drawing upon an instance of the Canvas class.
    /// - parameter drawingUpon: The canvas instance that the turtle should draw on.
    public init(drawingUpon: Canvas) {
        
        self.c = drawingUpon
        
        // No borders on shapes
        c.drawShapesWithBorders = false
        
    }
    
    // MARK: Conformance with adopted protocols
    
    /// Returns the bitmap image used for Xcode Playground quick looks; represents current state of the canvas at any given time.
    public var playgroundDescription : Any {
        return c.image as Any
    }
    
    // MARK: Change state

    /**
     Put the pen down. When the turtle moves, a line will be drawn.
     */
    open func penDown() {
        
        self.drawing = true
        
    }
    
    /**
     Lift the pen up. When the turtle moves, no line is drawn.
     */
    open func penUp() {
        
        self.drawing = false
        
    }

    /**
     Rotate the turtle to the right (clockwise).
     
     - Parameters:
         - angle: How far to rotate the turtle to the right, in degrees.
     */
    open func right(by angle: Degrees) {
        
        self.heading -= angle
        c.rotate(by: -angle)
        
    }
    
    /**
     Rotate the turtle to the left (counter-clockwise).
     
     - Parameters:
         - angle: How far to rotate the turtle to the left, in degrees.
     */
    open func left(by angle: Degrees) {
        
        self.right(by: -angle)

    }
    
    /**
     Move the turtle forward.
     
     - Parameters:
         - steps: How many steps forward the turtle should take.
     */
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
        if filling {
            self.verticesForCurrentFill.append(self.position)
        }
        
    }
    
    /**
     Move the turtle backward.
     
     - Parameters:
         - steps: How many steps backward the turtle should take.
     */
    open func backward(steps: Int) {
        
        self.forward(steps: -steps)
        
    }
    
    /**
     Point the turtle in a given direction. 0 = right, 90 = up, 180 = left, 270 = down.
     
     - Parameters:
         - to: What direction to point the turtle in; works the same way as a unit circle.
     */
    open func setHeading(to: Degrees) {
        
        let relativeHeading = to - self.currentHeading()
        self.heading = to
        c.rotate(by: relativeHeading)
        
    }
    
    /**
     Move the turtle to a given location, relative to the origin (bottom left of the screen).
     
     - Parameters:
         - to: The point to place the turtle at on the Cartesian plane.
     */
    open func setPosition(to: Point) {

        let tempHeading = self.heading
        self.setHeading(to: 0)

        let relativePosition = Point(x: to.x - self.position.x, y: to.y - self.position.y)
        if drawing {
            c.drawLine(from: Point(x: 0, y: 0), to: relativePosition)
        }
        self.position = to

        c.translate(to: relativePosition)
        self.setHeading(to: tempHeading)
        
        // If filling, keep track of current position
        if filling {
            self.verticesForCurrentFill.append(self.position)
        }

        
    }
    
    /**
     Set the horizontal position of the turtle.
     
     - Parameters:
         - to: The horizontal position, relative to 0 which is the left side of the canvas.
     */
    open func setX(to: CGFloat) {
        
        self.setPosition(to: Point(x: to, y: self.position.y))
        
    }
    
    /**
     Set the horizontal position of the turtle.
     
     - Parameters:
         - to: The horizontal position, relative to 0 which is the left side of the canvas.
     */
    open func setX(to: Double) {
        
        self.setPosition(to: Point(x: CGFloat(to), y: CGFloat(self.position.y)))
        
    }

    /**
     Set the horizontal position of the turtle.
     
     - Parameters:
         - to: The horizontal position, relative to 0 which is the left side of the canvas.
     */
    open func setX(to: Int) {
        
        self.setPosition(to: Point(x: Int(to), y: Int(self.position.y)))
        
    }

    /**
     Set the vertical position of the turtle.
     
     - Parameters:
         - to: The vertical position, relative to 0 which is the bottom side of the canvas.
     */
    open func setY(to: CGFloat) {
        
        self.setPosition(to: Point(x: self.position.x, y: to))

    }
    
    /**
     Set the vertical position of the turtle.
     
     - Parameters:
         - to: The vertical position, relative to 0 which is the bottom side of the canvas.
     */
    open func setY(to: Double) {
        
        self.setPosition(to: Point(x: CGFloat(self.position.x), y: CGFloat(to)))

    }

    /**
     Set the vertical position of the turtle.
     
     - Parameters:
         - to: The vertical position, relative to 0 which is the bottom side of the canvas.
     */
    open func setY(to: Int) {
        
        self.setPosition(to: Point(x: Int(self.position.x), y: Int(to)))
        
    }
    
    /**
     Set the turtle's pen color.
     
     - Parameters:
         - to: The desired color.
     */
    open func setPenColor(to: Color) {
        
        self.penColor = to
        c.lineColor = self.penColor
        
    }
    
    /**
     What color to fill closed polygons drawn by the turtle with.
     
     - Parameters:
         - to: The desired color.
     */
    open func setFillColor(to: Color) {
        
        self.fillColor = to
        c.fillColor = self.fillColor
        
    }
    
    /**
     What size of stroke the turtle should make
     
     - Parameters:
         - to: The desired stroke size, with 1 as the smallest possible value. Values lower than 1 will be ignored.
     */
    open func setPenSize(to: Int) {
        
        if to > 0 {
            self.penSize = to
            c.defaultLineWidth = self.penSize
        }
        
    }
    
    /**
     Move the turtle to the origin (bottom left corner of canvas).
     */
    open func goToHome() {
        
        self.setPosition(to: Point(x: 0, y: 0))
        self.setHeading(to: 0)
        
    }
    
    /**
     Start tracking turtle locations to mark the vertices of a closed polygon.
     */
    open func beginFill() {
        
        self.filling = true
        self.verticesForCurrentFill.append(self.position)
        
    }
    
    
    /**
     Stop tracking turtle locations to mark the vertices of a closed polygon. The shape will be filled at this point.
     */
    open func endFill() {
        
        c.translate(to: Point(x: -self.position.x, y: -self.position.y))
        c.drawCustomShape(with: verticesForCurrentFill)
        self.filling = false
        self.verticesForCurrentFill = []
        c.translate(to: Point(x: self.position.x, y: self.position.y))

    }
    
    
    /**
     Draw a triangle representing the turtle. The forward vertex of the triangle indicates the position of the turtle. The rear portion of the triangle indicates the heading of the turtle. For example, a triangle pointing to the right means the turtle has a heading of 0 degrees.
     */
    open func drawSelf() {
        
        c.lineColor = .black
        c.fillColor = .black
        c.defaultLineWidth = 1
        self.beginFill()
        self.penUp()
        self.setPosition(to: Point(x: self.position.x - 10, y: self.position.y + 5))
        self.setPosition(to: Point(x: self.position.x, y: self.position.y - 10))
        self.setPosition(to: Point(x: self.position.x + 10, y: self.position.y + 5))
        self.penDown()
        self.endFill()
        c.lineColor = self.currentPenColor()
        c.fillColor = self.currentFillColor()
        c.defaultLineWidth = self.currentPenSize()
        
    }
    
    /**
     When calling Tortoise methods within the a Processing-style `draw()` function, as with the `Sketch` class, be sure to invoke this method at the start of the `draw()` function to restore canvas state to where it left off after the last frame was animated.
     */
    open func restoreStateOnCanvas() {

        c.translate(to: self.currentPosition())
        c.rotate(by: self.currentHeading())
        
    }
    
    // MARK: Interrogate state

    /// The current heading of the turtle. 0 = right, 90 = up, 180 = left, 270 = down.
    open func currentHeading() -> Degrees {
        
        return self.heading
        
    }
    
    /// The current position of the turtle on the Cartesian plane, relative to the origin (bottom left corner of canvas).
    open func currentPosition() -> Point {
        
        return self.position
        
    }
    
    /// Whether the pen is currently down, or not.
    open func isPenDown() -> Bool {
        
        return self.drawing
        
    }
    
    /// The color the turtle is drawing with right now.
    open func currentPenColor() -> Color {
        
        return self.penColor
        
    }
    
    /// The pen size the turtle is drawing with right now.
    open func currentPenSize() -> Int {
        
        return self.penSize
        
    }
    
    /// The color closed polygons will be filled with.
    open func currentFillColor() -> Color {
        
        return self.fillColor
        
    }
    
    /// x-coordinate of the turtle's current position.
    public var xcor: CGFloat {
        
        return self.position.x
        
    }

    /// y-coordinate of the turtle's current position
    public var ycor: CGFloat {
        
        return self.position.y
        
    }
        
}
