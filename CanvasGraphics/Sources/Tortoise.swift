//
//  Turtle.swift
//  CanvasGraphics
//
//  Created by Russell Gordon on 2020-05-21.
//  Copyright © 2020 Russell Gordon. All rights reserved.
//

import Cocoa
import Foundation

/// Allow an angle mesaure in degrees to be converted to radians.
public extension Degrees {
    func asRadians() -> CGFloat {
        return self * CGFloat.pi / 180
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(formatForSVG value: CGFloat) {
        appendLiteral(String(format: "%.15f", value))
    }
}

struct TortoiseState {
    
    var drawing = true
    var heading: Degrees = 0
    var position: Point = Point(x: 0, y: 0)
    var penColor: Color = Color.black
    var fillColor: Color = Color.blue
    var filling: Bool = false
    var verticesForCurrentFill: [Point] = []
    var penSize: Int = 1

}

struct SVG {
    
    static var preamble = """
    <?xml version="1.0" standalone="no"?>
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
    "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">

    """

    static var title: String {
        
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        let now = formatter.string(from: Date())
        
        return """
        <title>Export from CanvasGraphics at \(now)</title>
        """
        
    }
    
    static var pathTagStart = """

    <path fill="none" style="stroke:rgb(0,0,0); stroke-width:1;stroke-linecap:round;stroke-opacity:1;" d="
    """
    
    static var pathTagEnd = """
    " />
    """
    
    static var svgTagEnd = """

    </svg>
    """
    
    static func svgTagStart(canvas: Canvas) -> String {
        return """
            <svg width="\(canvas.width)" height="\(canvas.height)" viewBox="0 0 \(canvas.width) \(canvas.height)" style="background-color:#ffffff" xmlns="http://www.w3.org/2000/svg" version="1.1">

            """
    }
    
}

/// Abstraction layer to allow drawing on a Canvas instance with a "LOGO turtle" metaphor
public class Tortoise: CustomPlaygroundDisplayConvertible {
    
    // Turtle state
    var state: TortoiseState = TortoiseState()
    
    // Stack for turtle state
    var states: [TortoiseState] = []
    
    // The canvas this turtle operates on
    let c: Canvas
    
    // SVG output for this tortoise
    var svg: String = ""
    
    /// Creates a tortoise object that you can use to drive drawing upon an instance of the Canvas class.
    /// - parameter drawingUpon: The canvas instance that the turtle should draw on.
    public init(drawingUpon: Canvas) {
        
        self.c = drawingUpon
        
        // No borders on shapes
        c.drawShapesWithBorders = false
        
        // Initialize SVG output
        self.svg.append(SVG.preamble)
        self.svg.append(SVG.svgTagStart(canvas: c))
        self.svg.append(SVG.title)
        if self.state.drawing { self.svg.append(SVG.pathTagStart) }
        
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
    public func penDown() {
        
        if self.state.drawing {
            self.svg.append(SVG.pathTagEnd)
        }
        self.state.drawing = true
        self.svg.append(SVG.pathTagStart)
        self.svg.append("M \(self.state.position.x) \(self.state.position.y) ")
        
    }
    
    /**
     Lift the pen up. When the turtle moves, no line is drawn.
     */
    public func penUp() {
        
        self.state.drawing = false
        if !self.svg.hasSuffix(">") {
            self.svg.append(SVG.pathTagEnd)
        }
        
    }

    /**
     Rotate the turtle to the right (clockwise).
     
     - Parameters:
         - angle: How far to rotate the turtle to the right, in degrees.
     */
    public func right(by angle: Degrees) {
        
        self.state.heading -= angle
        c.rotate(by: -angle)
        
    }
    
    /**
     Rotate the turtle to the left (counter-clockwise).
     
     - Parameters:
         - angle: How far to rotate the turtle to the left, in degrees.
     */
    public func left(by angle: Degrees) {
        
        right(by: -angle)

    }
    
    /**
     Move the turtle forward.
     
     - Parameters:
         - steps: How many steps forward the turtle should take.
     */
    public func forward(steps: Int) {
        
        // Draw based on movement
        if self.state.drawing {
            c.drawLine(from: Point(x: 0, y: 0), to: Point(x: steps, y: 0))
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
    public func backward(steps: Int) {
        
        forward(steps: -steps)
        
    }
    
    /**
     Point the turtle in a given direction. 0 = right, 90 = up, 180 = left, 270 = down.
     
     - Parameters:
         - to: What direction to point the turtle in; works the same way as a unit circle.
     */
    public func setHeading(to: Degrees) {
        
        let relativeHeading = to - currentHeading()
        self.state.heading = to
        c.rotate(by: relativeHeading)
        
    }
    
    /**
     Move the turtle to a given location, relative to the origin (bottom left of the screen).
     
     - Parameters:
         - to: The point to place the turtle at on the Cartesian plane.
     */
    public func setPosition(to: Point) {

        let tempHeading = self.state.heading
        setHeading(to: 0)

        let relativePosition = Point(x: to.x - self.state.position.x, y: to.y - self.state.position.y)
        if self.state.drawing {
            // Draw line on canvas
            c.drawLine(from: Point(x: 0, y: 0), to: relativePosition)

            // If a path was just opened, we must give a starting point for the path per SVG spec
            if self.svg.hasSuffix("d=\"") { self.svg.append("M \(self.state.position.x) \(self.state.position.x) ") }

            // We are drawing, so add a line to the next point for SVG output
            self.svg.append("L \(to.x) \(to.y) ")
        } else {
            self.svg.append("M \(to.x) \(to.y) ")
        }
        self.state.position = to

        c.translate(to: relativePosition)
        setHeading(to: tempHeading)
        
        // If filling, keep track of current position
        if self.state.filling {
            self.state.verticesForCurrentFill.append(self.state.position)
        }

        
    }
    
    /**
     Set the horizontal position of the turtle.
     
     - Parameters:
         - to: The horizontal position, relative to 0 which is the left side of the canvas.
     */
    public func setX(to: CGFloat) {
        
        setPosition(to: Point(x: to, y: self.state.position.y))
        
    }
    
    /**
     Set the horizontal position of the turtle.
     
     - Parameters:
         - to: The horizontal position, relative to 0 which is the left side of the canvas.
     */
    public func setX(to: Double) {
        
        setPosition(to: Point(x: CGFloat(to), y: CGFloat(self.state.position.y)))
        
    }

    /**
     Set the horizontal position of the turtle.
     
     - Parameters:
         - to: The horizontal position, relative to 0 which is the left side of the canvas.
     */
    public func setX(to: Int) {
        
        setPosition(to: Point(x: Int(to), y: Int(self.state.position.y)))
        
    }

    /**
     Set the vertical position of the turtle.
     
     - Parameters:
         - to: The vertical position, relative to 0 which is the bottom side of the canvas.
     */
    public func setY(to: CGFloat) {
        
        setPosition(to: Point(x: self.state.position.x, y: to))

    }
    
    /**
     Set the vertical position of the turtle.
     
     - Parameters:
         - to: The vertical position, relative to 0 which is the bottom side of the canvas.
     */
    public func setY(to: Double) {
        
        setPosition(to: Point(x: CGFloat(self.state.position.x), y: CGFloat(to)))

    }

    /**
     Set the vertical position of the turtle.
     
     - Parameters:
         - to: The vertical position, relative to 0 which is the bottom side of the canvas.
     */
    public func setY(to: Int) {
        
        setPosition(to: Point(x: Int(self.state.position.x), y: Int(to)))
        
    }
    
    /**
     Set the turtle's pen color.
     
     - Parameters:
         - to: The desired color.
     */
    public func setPenColor(to: Color) {
        
        self.state.penColor = to
        c.lineColor = self.state.penColor
        
    }
    
    /**
     What color to fill closed polygons drawn by the turtle with.
     
     - Parameters:
         - to: The desired color.
     */
    public func setFillColor(to: Color) {
        
        self.state.fillColor = to
        c.fillColor = self.state.fillColor
        
    }
    
    /**
     What size of stroke the turtle should make
     
     - Parameters:
         - to: The desired stroke size, with 1 as the smallest possible value. Values lower than 1 will be ignored.
     */
    public func setPenSize(to: Int) {
        
        if to > 0 {
            self.state.penSize = to
            c.defaultLineWidth = self.state.penSize
        }
        
    }
    
    /**
     Move the turtle to the origin (bottom left corner of canvas).
     */
    public func goToHome() {
        
        setPosition(to: Point(x: 0, y: 0))
        setHeading(to: 0)
        
    }
    
    /**
     Start tracking turtle locations to mark the vertices of a closed polygon.
     */
//    #warning("TODO: rgordon, 2020-12-01 - Consider how fill might be added for SVG output.")
    public func beginFill() {
        
        self.state.filling = true
        self.state.verticesForCurrentFill.append(self.state.position)
        
    }
    
    
    /**
     Stop tracking turtle locations to mark the vertices of a closed polygon. The shape will be filled at this point.
     */
    public func endFill() {
        
        c.translate(to: Point(x: -self.state.position.x, y: -self.state.position.y))
        c.drawCustomShape(with: self.state.verticesForCurrentFill)
        self.state.filling = false
        self.state.verticesForCurrentFill = []
        c.translate(to: Point(x: self.state.position.x, y: self.state.position.y))

    }
    
    
    /**
     Draw a triangle representing the turtle. The forward vertex of the triangle indicates the position of the turtle. The rear portion of the triangle indicates the heading of the turtle. For example, a triangle pointing to the right means the turtle has a heading of 0 degrees.
     */
    public func drawSelf() {
        
        c.lineColor = .black
        c.fillColor = .black
        c.defaultLineWidth = 1
        beginFill()
        penUp()
        setPosition(to: Point(x: self.state.position.x - 10, y: self.state.position.y + 5))
        setPosition(to: Point(x: self.state.position.x, y: self.state.position.y - 10))
        setPosition(to: Point(x: self.state.position.x + 10, y: self.state.position.y + 5))
        penDown()
        endFill()
        c.lineColor = currentPenColor()
        c.fillColor = currentFillColor()
        c.defaultLineWidth = currentPenSize()
        
    }
    
    /**
     When calling Tortoise methods within the a Processing-style `draw()` function, as with the `Sketch` class, be sure to invoke this method at the start of the `draw()` function to restore canvas state to where it left off after the last frame was animated.
     */
    public func restoreStateOnCanvas() {

        c.translate(to: currentPosition())
        c.rotate(by: currentHeading())
        
    }
    
    /**
     Save the current state of the tortoise (position, orientation, et cetera).
     */
    public func saveState() {
        
        states.append(state)
        
    }

    /**
     Restore a previous state of the tortoise (position, orientation, et cetera).
     */
    public func restoreState() {
        
        state = states.last!
        restoreStateOnCanvas()
        states.removeLast()
        
    }

    
    // MARK: Interrogate state

    /// The current heading of the turtle. 0 = right, 90 = up, 180 = left, 270 = down.
    public func currentHeading() -> Degrees {
        
        return self.state.heading
        
    }
    
    /// The current position of the turtle on the Cartesian plane, relative to the origin (bottom left corner of canvas).
    public func currentPosition() -> Point {
        
        return self.state.position
        
    }
    
    /// Whether the pen is currently down, or not.
    public func isPenDown() -> Bool {
        
        return self.state.drawing
        
    }
    
    /// The color the turtle is drawing with right now.
    public func currentPenColor() -> Color {
        
        return self.state.penColor
        
    }
    
    /// The pen size the turtle is drawing with right now.
    public func currentPenSize() -> Int {
        
        return self.state.penSize
        
    }
    
    /// The color closed polygons will be filled with.
    public func currentFillColor() -> Color {
        
        return self.state.fillColor
        
    }
    
    /// x-coordinate of the turtle's current position.
    public var xcor: CGFloat {
        
        return self.state.position.x
        
    }

    /// y-coordinate of the turtle's current position
    public var ycor: CGFloat {
        
        return self.state.position.y
        
    }
    
    // MARK: Finalize SVG output
    public func copySVGToClipboard() {
        
        // Close off the SVG output
        if self.state.drawing {
            self.svg.append(SVG.pathTagEnd)
        }
        if !self.svg.contains("</svg>") {
            self.svg.append(SVG.svgTagEnd)
        }
                
        // Now actually copy the string to the clipboard
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(self.svg, forType: .string)
        
    }
        
}
