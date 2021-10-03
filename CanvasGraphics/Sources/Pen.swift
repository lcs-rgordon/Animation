//
//  Pen.swift
//  CanvasGraphics
//
//  Created by Russell Gordon on 2021-10-01.
//

import Foundation

public class Pen: Tortoise {
    
    // MARK: Properties
    
    // Pen thickness
    public var thickness: Int {
        get {
            super.lineWidth
        }
        set {
            super.lineWidth = newValue
        }
    }
    
    // Pen color
    public var penColor: Color {
        get {
            super.currentPenColor()
        }
        set {
            super.setPenColor(to: newValue)
        }
    }
    
    // Fill color
    public var fillColor: Color {
        get {
            super.currentFillColor()
        }
        set {
            super.setFillColor(to: newValue)
        }
    }
    
    // Heading
    public var currentHeading: Degrees {
        get {
            super.currentHeading()
        }
        set {
            super.setHeading(to: newValue)
        }
    }
    
    // Position
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
        self.thickness = 3
        self.penColor = .blue
        self.currentHeading = 0
        
    }
    
    // MARK: Methods
    public func addLine(distance: Int) {
        
        super.forward(steps: distance)
        
    }
    
    public func move(distance: Int) {
        
        // Save pen state
        let penState = super.isPenDown()
        
        // Lift pen if it was down
        if super.isPenDown() {
            super.penUp()
        }
        
        // Move forward
        super.forward(steps: distance)
        
        // Restore pen state
        if penState == true {
            super.penDown()
        }
        
    }
    
    public func goToOrigin() {
        
        super.goToHome()
        
    }
    
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

    public func drawTo(dx: Double, dy: Double) {

        if dy == 0 {
            position.x += dx
        } else if dx == 0 {
            position.y += dy
        } else {
            // Work out the angle described by the horizontal and vertical change
            let theta = abs(atan(dy / dx) * 180 / Double.pi)
            print("theta is \(theta)")
            
            // Rotate by the angle
            var terminalArmRotation = 0.0
            if dx > 0 && dy > 0 {
                terminalArmRotation = theta
                print("quadrant 1")
            } else if dx < 0 && dy > 0 {
                terminalArmRotation = 180 - theta
                print("quadrant 2")
            } else if dx < 0 && dy < 0 {
                terminalArmRotation = 180 + theta
                print("quadrant 3")
            } else if dx > 0 && dy < 0 {
                terminalArmRotation = 360 - theta
                print("quadrant 4")
            }
            print("terminalArmRotation is \(terminalArmRotation)")
            print("curentHeading is \(currentHeading)")
            
            // Save present heading
            let savedHeading = currentHeading
            super.setHeading(to: 0)
            
            // Do the rotation
            super.left(by: Degrees(terminalArmRotation))
            
            // Work out the distance described by horizontal and vertical change
            let hypotenuse = sqrt(dx * dx + dy * dy)

            // Draw the line
            super.forward(steps: Int(round(hypotenuse)))

            // Restore original heading
            super.setHeading(to: savedHeading)

        }
        
    }
    
    public func turn(degrees: Double) {
        if degrees > 0 {
            super.left(by: degrees)
        } else {
            super.right(by: degrees * -1)
        }
    }
    

    // TODO: Complete this
    public func drawCircle(radius: Double) {
        
    }
    
    public func addArc(radius: Double, angle: Double) {
        
        // Get current position
        let currentX = position.x
        print("currentX is: \(currentX)")
        let currentY = position.y
        print("currentX is: \(currentY)")

        if angle < 0 {

            // Figure out centre point of circle
            let toCenterInRadians = (90 - Double(currentHeading)) * (.pi / 180)
            let dx = radius * cos(toCenterInRadians)
            let dy = -radius * sin(toCenterInRadians)
            let centerX = currentX + dx
            print("centerX is: \(centerX)")
            let centerY = currentY + dy
            print("centerY is: \(centerY)")
            let startAngle = 90 + Double(currentHeading) + angle
            print("startAngle is: \(startAngle)")
            let endAngle = 90 + Double(currentHeading)
            print("endAngle is: \(endAngle)")
            
            // Save present heading
            let savedHeading = currentHeading
            super.setHeading(to: 0)

            // Draw the arc
            super.c.arc(withCenter: CGPoint(x: dx, y: dy),
                        radius: CGFloat(radius),
                        startAngle: CGFloat(startAngle),
                        endAngle: CGFloat(endAngle), clockwise: false)
            
            // Restore original heading
            super.setHeading(to: savedHeading)

            // Go to middle of circle
            penUp()
            position.x += dx
            position.y += dy
            penDown()
            
            // Rotate so we can back up to get to end of the arc
            print("currentHeading is: \(currentHeading)")
            currentHeading += angle - 90
            print("currentHeading is now: \(currentHeading)")
            
            // Back up so that we are at the edge of the arc
            penUp()
            backward(steps: Int(round(radius)))
            penDown()
            
            // Correct rotation so we are pointing the right way
            currentHeading += 90

        } else {
            
            // Figure out centre point of circle
            let toCenterInRadians = (90 + Double(currentHeading)) * (.pi / 180)
            let dx = radius * cos(toCenterInRadians)
            let dy = radius * sin(toCenterInRadians)
            let centerX = currentX + dx
            print("centerX is: \(centerX)")
            let centerY = currentY + dy
            print("centerY is: \(centerY)")
            let startAngle = -90 + Double(currentHeading) + angle
            print("startAngle is: \(startAngle)")
            let endAngle = -90 + Double(currentHeading)
            print("endAngle is: \(endAngle)")

            // Save present heading
            let savedHeading = currentHeading
            super.setHeading(to: 0)
            
            // Draw the arc
            super.c.arc(withCenter: Point(x: dx, y: dy),
                        radius: CGFloat(radius),
                        startAngle: CGFloat(startAngle),
                        endAngle: CGFloat(endAngle),
                        clockwise: true)
            
            // Restore original heading
            super.setHeading(to: savedHeading)
            
            // Go to middle of circle
            penUp()
            position.x += dx
            position.y += dy
            penDown()
            
            // Rotate so we can back up to get to end of the arc
            print("currentHeading is: \(currentHeading)")
            currentHeading += angle + 90
            print("currentHeading is now: \(currentHeading)")
            
            // Back up so that we are at the edge of the arc
            penUp()
            backward(steps: Int(round(radius)))
            penDown()
            
            // Correct rotation so we are pointing the right way
            currentHeading -= 90

        }
    }
    
    // Draws a circle at a particular point
    public func plotPoint(xy: Point, size: Double) {
        
        super.c.drawShapesWithFill = true
        fillColor = penColor
        super.c.drawEllipse(at: xy, width: Int(round(size)) * 2, height: Int(round(size)) * 2)
        goto(dx: xy.x, dy: xy.y)
    }
    
    // TODO: Complete this
    public func drawBetween(x1: Double, y1: Double, x2: Double, y2: Double) {
        penUp()
        position.x = x1
        position.y = y1
        penDown()
        super.c.drawLine(from: Point(x: x1, y: y1), to: Point(x: x2, y: y2))
        goto(dx: x2 - x1, dy: y2 - y1)
    }
    
}
