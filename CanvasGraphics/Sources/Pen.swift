//
//  Pen.swift
//  CanvasGraphics
//
//  Created by Russell Gordon on 2021-10-01.
//

import Foundation

public class Pen: Tortoise {
    
    // MARK: Properties
    
    /// Sets the thickness of the pen's stroke.
    public var thickness: Int {
        get {
            super.lineWidth
        }
        set {
            super.lineWidth = newValue
        }
    }
    
    /// Sets the color of the pen's stroke.
    public var penColor: Color {
        get {
            super.currentPenColor()
        }
        set {
            super.setPenColor(to: newValue)
        }
    }
    
    /// Sets the fill for closed shapes defined by the path of the pen.
    public var fillColor: Color {
        get {
            super.currentFillColor()
        }
        set {
            super.setFillColor(to: newValue)
        }
    }
    
    /// The current heading of the pen.
    /// 0 degrees: right, 90 degrees: up, 180 degrees: left, 270 degrees: down
    public var currentHeading: Degrees {
        get {
            super.currentHeading()
        }
        set {
            super.setHeading(to: newValue)
        }
    }
    
    /// The current position of the pen on the Cartesian plane.
    public var position: Point {
        get {
            super.currentPosition()
        }
        set {
            super.setPosition(to: newValue)
        }
    }
    
    // MARK: Initializers
    public override init(drawingUpon canvas: Canvas) {
        
        // Superclass
        super.init(drawingUpon: canvas)
        
        // Set pen thickness and colour
        if super.c.scale == 1 {
            self.lineWidth = 3
        }
        self.penColor = .blue
        self.currentHeading = 0
        
    }
    
    // MARK: Methods
    
    /// Draws a line in the direction of the current heading of the pen.
    ///  - parameter distance: The length of the line to be drawn.
    public func addLine(distance: Int) {
        
        forward(steps: Double(distance))
        
    }
    
    /// Draws a line in the direction of the current heading of the pen.
    ///  - parameter distance: The length of the line to be drawn.
    public func addLine(distance: Double) {
        
        addLine(distance: distance)
        
    }

    /// Moves the pen, without drawing a line, in the direction of the current heading.
    ///  - parameter distance: The length of the line to be drawn.
    public func move(distance: Int) {
        
        move(distance: Double(distance))
        
    }
    
    /// Moves the pen, without drawing a line, in the direction of the current heading.
    ///  - parameter distance: The length of the line to be drawn.
    public func move(distance: Double) {
        
        // Save pen state
        let penState = super.isPenDown()
        
        // Lift pen if it was down
        if super.isPenDown() {
            super.penUp()
        }
        
        // Move forward
        forward(steps: distance)
        
        // Restore pen state
        if penState == true {
            super.penDown()
        }
        
    }
    
    /**
     Move the turtle forward.
     
     - Parameters:
         - steps: How many steps forward the turtle should take.
     */
    private func forward(steps: Double) {
        
        // Draw based on movement
        if self.state.drawing {
            c.drawLine(from: Point(x: 0, y: 0), to: Point(x: steps, y: 0), capStyle: .round)
        }
        c.translate(to: Point(x: steps, y: 0))
        
        // Update position relative to original origin
        self.state.position = Point(x: self.state.position.x + cos(self.state.heading.asRadians()) * CGFloat(steps),
                              y: self.state.position.y + sin(self.state.heading.asRadians()) * CGFloat(steps))
        
        // Update for SVG output
        if self.state.drawing {
            self.svg.append("L \(formatForSVG: self.state.position.x) \(formatForSVG: self.state.position.y) ")
        }
        
        // If filling, keep track of current position
        if self.state.filling {
            self.state.verticesForCurrentFill.append(self.state.position)
        }
        
    }
    
    /**
     Move the turtle backward.
     
     - Parameters:
         - steps: How many steps backward the turtle should take.
     */
    private func backward(steps: Double) {
        
        forward(steps: -steps)
        
    }
        
    /// Move the pen back to the origin.
    public func goToOrigin() {
        
        goto(dx: Double(currentPosition().x) * -1.0, dy: Double(currentPosition().y) * -1.0)
        
    }
        
    /**
     Move the pen relative to it's current position, without drawing a line.
     
     For example, if the current position is (100, 50) and dx is 25 while dy is 0, the new position will be (125, 50).
          
     - Parameters:
         - dx: Desired horizontal change in position. Postiive values move the pen to the right; negative values move the pen to the left.
         - dy: Desired vertical change in position. Postiive values move the pen up; negative values move the pen down.
     */
    public func goto(dx: Double, dy: Double) {

        
        // Save pen state
        let penState = super.isPenDown()
        
        // Lift pen if it was down
        if super.isPenDown() {
            super.penUp()
        }
        
        // Move
        position.x += dx
        position.y += dy
        
        // Restore pen state
        if penState == true {
            super.penDown()
        }

        
    }

    /**
     Move the pen relative to it's current position, while drawing a line.
     
     For example, if the current position is (100, 50) and dx is 25 while dy is 100, the new position will be (125, 150), resulting in a diagonal line.
          
     - Parameters:
         - dx: Desired horizontal change in position. Postiive values move the pen to the right; negative values move the pen to the left.
         - dy: Desired vertical change in position. Postiive values move the pen up; negative values move the pen down.
     */
    public func drawTo(dx: Double, dy: Double) {

        if dy == 0 {
            position.x += dx
        } else if dx == 0 {
            position.y += dy
        } else {
            // Work out the angle described by the horizontal and vertical change
            let theta = abs(atan(dy / dx) * 180 / Double.pi)
            
            // Rotate by the angle
            var terminalArmRotation = 0.0
            if dx > 0 && dy > 0 {
                terminalArmRotation = theta
            } else if dx < 0 && dy > 0 {
                terminalArmRotation = 180 - theta
            } else if dx < 0 && dy < 0 {
                terminalArmRotation = 180 + theta
            } else if dx > 0 && dy < 0 {
                terminalArmRotation = 360 - theta
            }
            
            // Save present heading
            let savedHeading = currentHeading
            super.setHeading(to: 0)
            
            // Do the rotation
            super.left(by: Degrees(terminalArmRotation))
            
            // Work out the distance described by horizontal and vertical change
            let hypotenuse = sqrt(dx * dx + dy * dy)

            // Draw the line
            forward(steps: hypotenuse)

            // Restore original heading
            super.setHeading(to: savedHeading)

        }
        
    }
    
    /**
     Turn the pen to a new heading.
     
     - Parameters:
         - degrees: Desired rotation. Positive values turn the pen to the left (counter-clockwise) while negative values turn the pen to the right (clockwise).
     */
    public func turn(degrees: Double) {
        if degrees > 0 {
            super.left(by: degrees)
        } else {
            super.right(by: degrees * -1)
        }
    }
    

    /**
     Draw a circle centred at the pen's current position.
     
     - Parameters:
         - radius: Radius of the circle to be drawn.
     */
    public func drawCircle(radius: Double) {

        super.c.arc(withCenter: position, radius: radius, startAngle: 0, endAngle: 360, clockwise: false)
        
    }
    
    /**
     Draws an arc from the pen's current position and along the pen's current heading.
     
     - Parameters:
         - radius: Radius of an imaginary circle, if a full circle were drawn.
         - angle: How much of a complete circle to draw; when this is 90 a quarter circle is drawn, 180 results in a half-circle, and so on.
     */
    public func addArc(radius: Double, angle: Double) {
        
        // Get current position
//        let currentX = position.x
//        let currentY = position.y

        if angle < 0 {

            // Figure out centre point of circle
            let toCenterInRadians = (90 - Double(currentHeading)) * (.pi / 180)
            let dx = radius * cos(toCenterInRadians)
            let dy = -radius * sin(toCenterInRadians)
//            let centerX = currentX + dx
//            let centerY = currentY + dy
            let startAngle = 90 + Double(currentHeading) + angle
            let endAngle = 90 + Double(currentHeading)
            
            // Save present heading
            let savedHeading = currentHeading
            super.setHeading(to: 0)

            // Draw the arc
            super.c.arc(withCenter: CGPoint(x: dx, y: dy),
                        radius: CGFloat(radius),
                        startAngle: CGFloat(startAngle),
                        endAngle: CGFloat(endAngle),
                        clockwise: false,
                        capStyle: .round)
            
            // Restore original heading
            super.setHeading(to: savedHeading)

            // Go to middle of circle
            penUp()
            position.x += dx
            position.y += dy
            penDown()
            
            // Rotate so we can back up to get to end of the arc
            currentHeading += angle - 90
            
            // Back up so that we are at the edge of the arc
            penUp()
            backward(steps: radius)
            penDown()
            
            // Correct rotation so we are pointing the right way
            currentHeading += 90

        } else {
            
            // Figure out centre point of circle
            let toCenterInRadians = (90 + Double(currentHeading)) * (.pi / 180)
            let dx = radius * cos(toCenterInRadians)
            let dy = radius * sin(toCenterInRadians)
//            let centerX = currentX + dx
//            let centerY = currentY + dy
            let startAngle = -90 + Double(currentHeading) + angle
            let endAngle = -90 + Double(currentHeading)

            // Save present heading
            let savedHeading = currentHeading
            super.setHeading(to: 0)
            
            // Draw the arc
            super.c.arc(withCenter: Point(x: dx, y: dy),
                        radius: CGFloat(radius),
                        startAngle: CGFloat(startAngle),
                        endAngle: CGFloat(endAngle),
                        clockwise: true,
                        capStyle: .round)

            // Restore original heading
            super.setHeading(to: savedHeading)
            
            // Go to middle of circle
            penUp()
            position.x += dx
            position.y += dy
            penDown()
            
            // Rotate so we can back up to get to end of the arc
            currentHeading += angle + 90
            
            // Back up so that we are at the edge of the arc
            penUp()
            backward(steps: radius)
            penDown()
            
            // Correct rotation so we are pointing the right way
            currentHeading -= 90

        }
    }
    
    /**
     Draws a circle at a given absolute point on the Cartesian plane, irrespective of the pen's current position, then moves the pen to the centre of the newly drawn circle.
     
     - Parameters:
         - xy: The centre of the circle that is to be drawn.
         - size: The radius of the circle to be drawn.
     */
    public func plotPoint(xy: Point, size: Double) {
        
        // Save current fill state on the canvas
        let currentFillState = super.c.drawShapesWithFill
        let currentFillColor = super.c.fillColor
        
        // Fill this circle with the current pen's color
        super.c.drawShapesWithFill = true
        fillColor = penColor
        
        // Move the pen back to the origin
        goToOrigin()
        
        // Draw the circle
        super.c.drawEllipse(at: xy, width: Int(round(size)) * 2, height: Int(round(size)) * 2)
        
        // Move the pen to the middle of the circle drawn
        goto(dx: xy.x, dy: xy.y)
        
        // Restore fill state on canvas
        super.c.drawShapesWithFill = currentFillState
        super.c.fillColor = currentFillColor
        
    }
    
    /**
     Draws a line between two given points, then moves the pen to the end of the line just drawn.
     */
    public func drawBetween(x1: Double, y1: Double, x2: Double, y2: Double) {
        penUp()
        position.x = x1
        position.y = y1
        penDown()
        super.c.drawLine(from: Point(x: x1, y: y1), to: Point(x: x2, y: y2))
        goto(dx: x2 - x1, dy: y2 - y1)
    }
    
}
