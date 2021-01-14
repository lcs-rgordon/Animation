import Cocoa
import Foundation

public typealias Degrees = CGFloat

public typealias Point = NSPoint
public typealias Vector = Point

public extension Int {
    func asCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}

/// Set to High (2x) or Ultra (4x) when generating output for printing, otherwise use Standard.
public enum Quality : Int {
    case Standard = 1
    case High = 2
    case Ultra = 4
}

/// Used to specify how rectangles should be anchored
public enum AnchorPosition : Int {
    case bottomLeft  = 1
    case centre = 2
}

/// Carries out the heavy lifting to generate bitmap graphics
public class Canvas : NSImageView, CustomPlaygroundDisplayConvertible {
    
    /// Returns the bitmap image used for Xcode Playground quick looks; represents current state of the canvas at any given time.
    public var playgroundDescription : Any {
        return self.image as Any
    }
    
    /// Frame rate for animation on this canvas
    public var framesPerSecond : Int = 60 {
        didSet {
            // Ensure rational frame rate set
            if (framesPerSecond < 0) {
                framesPerSecond = 1
            }
        }
    }
    
    /// Keeps track of how many frames have been animated using this particular canvas
    public var frameCount : Int = 0
    
    /// Default line width for lines drawn using drawLine()
    public var defaultLineWidth: Int = 1 {
        didSet {
            // Ensure rational line width set
            if (defaultLineWidth < 0) {
                defaultLineWidth = 1
            }
            
            // Set the width based on the canvas scale factor
            defaultLineWidth *= scale
            
        }
    }
    
    /// Line color, default is black
    public var lineColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    /// Default border width for closed shapes
    public var defaultBorderWidth: Int = 1 {
        didSet {
            // Ensure rational border width set
            if (defaultBorderWidth < 0) {
                defaultBorderWidth = 1
            }
            
            // Set the width based on the canvas scale factor
            defaultBorderWidth *= scale
        }
    }
    
    /// Border color, default is black
    public var borderColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    /// Fill color, default is black
    public var fillColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    /// Text color, default is black
    public var textColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    /// Whether to draw shapes with borders
    public var drawShapesWithBorders: Bool = true
    
    /// Whether to draw shapes with fill
    public var drawShapesWithFill: Bool = true
    
    // Size of canvas
    public let width : Int
    public let height : Int
    
    // Scale factor for drawing
    public let scale : Int
    
    /// Draw in high performance mode. When true, canvas image does not get updated after every draw call. This should generally be kept at the default value of `false`.
    public var highPerformance : Bool = false {
        didSet {
            if self.highPerformance {
                
                self.image = nil
                
            } else {
                
                // Update preview for playground
                if onBigSur { NSGraphicsContext.saveGraphicsState() }
                NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: self.offscreenRepresentation)
                self.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)
                if onBigSur { NSGraphicsContext.restoreGraphicsState() }
                
            }
        }
    }
    
    // Off screen drawing representation
    private var offscreenRep : NSBitmapImageRep
    public var offscreenRepresentation : NSBitmapImageRep {
        return self.offscreenRep
    }
    
    // Big Sur?
    private var onBigSur: Bool {
        return ProcessInfo.processInfo.operatingSystemVersion.majorVersion == 11
    }
    
    /// Creates a canvas object that can be drawn upon.
    /// - parameter width: Width of the canvas
    /// - parameter height: Height of the canvas
    /// - parameter quality: When generating output for printing, use High or Ultra.
    public init(width: Int = 300, height: Int = 200, quality : Quality = Quality.Standard) {
        
        // Set the canvas scale factor
        self.scale = quality.rawValue
        
        // Set the width and height of the canvas
        self.width = width
        self.height = height
        
        // Set the default line and border widths
        self.defaultLineWidth = 1 * self.scale
        self.defaultBorderWidth = 1 * self.scale
        
        // Define the offscreen bitmap we will draw to
        // For now it is a non-retina bitmap (see setDrawingScale() below)
        // Cannot determine screen capabilities until this class is initialized
        self.offscreenRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: self.width * self.scale, pixelsHigh: self.height * self.scale, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: NSColorSpaceName.calibratedRGB, bytesPerRow: 4 * self.width * self.scale, bitsPerPixel: 32)!
        
        // Initialize the superclass
        super.init(frame: NSRect(x: 0, y: 0, width: self.width * self.scale, height: self.height * self.scale))
        
        // Set drawing scale and graphics context
        setDrawingScaleAndGraphicsContext()
        
        // Make the background white
        self.fillColor = Color.white
        self.drawShapesWithBorders = false
        self.drawRectangle(at: Point(x: 0, y: 0), width: self.width * self.scale, height: self.height * self.scale)
        self.fillColor = Color.black
        self.drawShapesWithBorders = true
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Based on: https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/HighResolutionOSX/CapturingScreenContents/CapturingScreenContents.html#//apple_ref/doc/uid/TP40012302-CH10-SW30
    func drawToBitmapOf(width : CGFloat, height : CGFloat, withDisplayScale displayScale: CGFloat) {
        
        // Define the offscreen bitmap we will draw to
        self.offscreenRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: self.width * self.scale * Int(displayScale), pixelsHigh: self.height * self.scale * Int(displayScale), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: NSColorSpaceName.calibratedRGB, bytesPerRow: 4 * self.width * self.scale * Int(displayScale), bitsPerPixel: 32)!
        
        // Setting the user size communicates the dpi
        // Essentially compresses down the bitmap into a smaller frame if this is
        // a Retina display (see DEBUG statements below to understand)
        // DEBUG
//        print("offscreen rep size is: \(self.offscreenRep.size)")
        self.offscreenRep.size = NSMakeSize(width, height)
        // DEBUG
//        print("offscreen rep size is: \(self.offscreenRep.size)")

        // Create the bitmap context
        NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: offscreenRep)
        
        // Set the blend mode
        // See: https://www.trailingclosure.com/blendmode-cheat-sheet/
        // NOTE: Not setting a compositingOperation is the same as .normal
//        NSGraphicsContext.current!.compositingOperation = NSCompositingOperation.hardLight
        
    }
    
    // Determines whether the display is Retina calibre or not and sizes bitmap we draw to
    // as needed
    func setDrawingScaleAndGraphicsContext() {
        
        // Bounds are in points
        let bounds : NSRect = self.bounds
        
        // Figure out the scale of pixels to points
        let displayScale : CGFloat = self.convertToBacking(NSSize(width: 1, height: 1)).width

        // DEBUG
//        print("Display scale is: \(displayScale)")
        
        // DEBUG
//        print("Width is: \(bounds.size.width)")
//        print("Height is: \(bounds.size.height)")
        
        // Supply the user size (in points)
        drawToBitmapOf(width: bounds.size.width, height: bounds.size.height, withDisplayScale: displayScale)
        
        // Draw the bitmap image to the view bounds
        self.offscreenRep.draw(in: bounds)
        
        // Update the view's image
        self.image = NSImage(cgImage: self.offscreenRep.cgImage!, size: self.offscreenRep.size)

    }
    
    // This is called when the view needs to be updated
    public override func draw(_ dirtyRect: NSRect) {

        super.draw(dirtyRect)

    }
    
    // This is called after the view is created
    override public func viewDidMoveToSuperview() {
        
    }
    
    /**
     Draw text beginning at the point specified.
     
     - Parameters:
         - message: The text to be drawn on screen.
         - at: Text will be drawn starting at this location.
         - size: The size of the text, specified in points.
         - kerning: The spacing between letters of the text. 0.0 is neutral, negative values draw letters together, positive values move letters further apart.
     
     */
    public func drawText(message: String, at: Point, size: Int = 24, kerning : Float = 0.0)  {
                
        // Set attributes of shape based on the canvas scale factor
        var size = size
        size *= scale
        var x = at.x
        x *= scale.asCGFloat()
        var y = at.y
        y *= scale.asCGFloat()
        
        // Convert the provided String object to an NSString object
        let string: NSString = NSString(string: message)
        
        // set the text color to dark gray
        let fieldColor : NSColor = NSColor(hue: textColor.translatedHue, saturation: textColor.translatedSaturation, brightness: textColor.translatedBrightness, alpha: textColor.translatedAlpha)
        
        // set the font to Helvetica Bold
        let fieldFont = NSFont(name: "Helvetica Bold", size: size.asCGFloat())
        
        // set the line spacing to 1
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 1.0
        
        // set the Obliqueness (tilt of text) to 0.0
        let skew = 0.0
        
        // create dictionary with attributes of the string to be drawn
        let attributes: [NSAttributedString.Key : AnyObject] = [
            NSAttributedString.Key.foregroundColor: fieldColor,
            NSAttributedString.Key.paragraphStyle: paraStyle,
            NSAttributedString.Key.obliqueness: skew as AnyObject,
            NSAttributedString.Key.font: fieldFont!,
            NSAttributedString.Key.kern: NSNumber(value: kerning) as AnyObject
        ]
        
        // Draw the string
        string.draw(at: NSPoint(x: x, y: y), withAttributes: attributes)
        
        if onBigSur {
            // Update for playground preview
            if !highPerformance {
                NSGraphicsContext.saveGraphicsState()
                NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: self.offscreenRepresentation)
                self.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)
                NSGraphicsContext.restoreGraphicsState()
            }
        }

    }
    
    /**
     Draw a line segment between the provided points.
     
     - Parameters:
         - from: Starting position of the line segment.
         - to: Ending position of the line segment.
         - lineWidth: Width of the line segment.
         - capStyle: The shape of line segment endpoints (square, rounded, et cetera).
         - dashed: Whether to make the line dashed or not.
     */
    public func drawLine(from: Point, to: Point, lineWidth: Int = 0, capStyle : NSBezierPath.LineCapStyle = NSBezierPath.LineCapStyle.square, dashed: Bool = false) {
        
        // Set attributes of shape based on the canvas scale factor
        var fromX = from.x
        fromX *= scale.asCGFloat()
        var fromY = from.y
        fromY *= scale.asCGFloat()
        var toX = to.x
        toX *= scale.asCGFloat()
        var toY = to.y
        toY *= scale.asCGFloat()
        var lineWidth = lineWidth
        lineWidth *= scale
        
        // Make the new path with the specified cap style
        NSBezierPath.defaultLineCapStyle = capStyle
        let path = NSBezierPath()
        
        // Set width of border
        if lineWidth > 0 {
            path.lineWidth = lineWidth.asCGFloat()
        } else {
            path.lineWidth = self.defaultLineWidth.asCGFloat()
        }

        // Optionally make the line dashed
        if dashed {
            let dashes: [CGFloat] = [4, 2]
            path.setLineDash(dashes, count: 2, phase: 0)
        }
        
        // Define the line
        path.move(to: NSPoint(x: fromX, y: fromY))
        path.line(to: NSPoint(x: toX, y: toY))
        
        // Set the line's color
        NSColor(hue: lineColor.translatedHue, saturation: lineColor.translatedSaturation, brightness: lineColor.translatedBrightness, alpha: lineColor.translatedAlpha).setStroke()
        
        // Draw the line
        path.stroke()
        
        if onBigSur {
            // Update for playground preview
            if !highPerformance {
                NSGraphicsContext.saveGraphicsState()
                NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: self.offscreenRepresentation)
                self.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)
                NSGraphicsContext.restoreGraphicsState()
            }
        }

    }
    
    /**
     Draw a bezier curve between the provided points.
     
     - Parameters:
     - from: Starting position of the curve
     - to: Ending position of the curve
     - showControlPoints: Optionally display the co-ordinates of key points and the "handles" for the curve.
     - lineWidth: Position of the control point
     - capStyle: The shape of line segment endpoints (square, rounded, et cetera).
     
     */
    public func drawCurve(from: Point, to: Point, control1: Point, control2: Point, showControlPoints: Bool = false, lineWidth: Int = 0, capStyle : NSBezierPath.LineCapStyle = NSBezierPath.LineCapStyle.square) {
        
        // Set attributes of shape based on the canvas scale factor
        var fromX = from.x
        fromX *= scale.asCGFloat()
        var fromY = from.y
        fromY *= scale.asCGFloat()
        var toX = to.x
        toX *= scale.asCGFloat()
        var toY = to.y
        toY *= scale.asCGFloat()
        var control1X = control1.x
        control1X *= scale.asCGFloat()
        var control1Y = control1.y
        control1Y *= scale.asCGFloat()
        var control2X = control2.x
        control2X *= scale.asCGFloat()
        var control2Y = control2.y
        control2Y *= scale.asCGFloat()
        
        var lineWidth = lineWidth
        lineWidth *= scale
        
        // Make the new path with the specified cap style
        NSBezierPath.defaultLineCapStyle = capStyle
        let path = NSBezierPath()
        
        // Set width of border
        if lineWidth > 0 {
            path.lineWidth = lineWidth.asCGFloat()
        } else {
            path.lineWidth = self.defaultLineWidth.asCGFloat()
        }
        
        // Define the start of the curve
        path.move(to: NSPoint(x: fromX, y: fromY))
        
        // Draw the co-ordinates and "handles" of the curve
        if showControlPoints {
            
            // From
            self.drawText(message: "(\(fromX), \(fromY))",
                          at: Point(x: fromX - 30, y: fromY + 5), size: 10)
            
            // To
            self.drawText(message: "(\(toX), \(toY))",
                          at: Point(x: toX - 30, y: toY + 5), size: 10)
            
            // Control 1
            self.drawText(message: "(\(control1X), \(control1Y))",
                          at: Point(x: control1X - 30, y: control1Y + 5), size: 10)
            
            // Control 2
            self.drawText(message: "(\(control2X), \(control2Y))",
                          at: Point(x: control2X - 30, y: control2Y + 5), size: 10)
            
            // First handle
            self.drawLine(from: Point(x: control1X, y: control1Y),
                          to: Point(x: fromX, y: fromY),
                          lineWidth: 1,
                          dashed: true)
            
            // Second handle
            self.drawLine(from: Point(x: toX, y: toY),
                          to: Point(x: control2X, y: control2Y),
                          lineWidth: 1,
                          dashed: true)
            
        }
        
        // Create the curve
        path.curve(to: NSPoint(x: toX, y: toY),
                   controlPoint1: NSPoint(x: control1X, y: control1Y),
                   controlPoint2: NSPoint(x: control2X, y: control2Y))
        
        // Set the line's color
        NSColor(hue: lineColor.translatedHue, saturation: lineColor.translatedSaturation, brightness: lineColor.translatedBrightness, alpha: lineColor.translatedAlpha).setStroke()
        
        // Draw the line
        path.stroke()
        
        if onBigSur {
            // Update for playground preview
            if !highPerformance {
                NSGraphicsContext.saveGraphicsState()
                NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: self.offscreenRepresentation)
                self.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)
                NSGraphicsContext.restoreGraphicsState()
            }
        }

    }
    
    /**
     Draw an ellipse centred at the point specified.
     
     - Parameters:
         - at: Point over which the ellipse will be drawn.
         - width: How wide the ellipse will be across its horizontal axis.
         - height: How tall the ellipse will be across its vertical axis.
         - borderWidth: How thick the stroke of the border should be.
     */
    public func drawEllipse(at: Point, width: Int, height: Int, borderWidth: Int = 0) {
        
        // Set attributes of shape based on the canvas scale factor
        var centreX = at.x
        centreX *= scale.asCGFloat()
        var centreY = at.y
        centreY *= scale.asCGFloat()
        var width = width
        width *= scale
        var height = height
        height *= scale
        var borderWidth = borderWidth
        borderWidth *= scale
        
        // Make the new path
        let path = NSBezierPath(ovalIn: NSRect(x: centreX - width.asCGFloat() / 2, y: centreY - height.asCGFloat() / 2, width: width.asCGFloat(), height: height.asCGFloat()))
        
        // Set width of border
        if borderWidth > 0 {
            path.lineWidth = borderWidth.asCGFloat()
        } else {
            path.lineWidth = CGFloat(self.defaultBorderWidth)
        }
        
        // Set ellipse border color
        NSColor(hue: borderColor.translatedHue, saturation: borderColor.translatedSaturation, brightness: borderColor.translatedBrightness, alpha: borderColor.translatedAlpha).setStroke()
        
        // Draw the ellipse border
        if (self.drawShapesWithBorders == true) {
            path.stroke()
        }
        
        // Set ellipse fill color
        NSColor(hue: fillColor.translatedHue, saturation: fillColor.translatedSaturation, brightness: fillColor.translatedBrightness, alpha: fillColor.translatedAlpha).setFill()
        
        // Fill the ellipse
        if (self.drawShapesWithFill == true) {
            path.fill()
        }
        
        if onBigSur {
            // Update for playground preview
            if !highPerformance {
                NSGraphicsContext.saveGraphicsState()
                NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: self.offscreenRepresentation)
                self.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)
                NSGraphicsContext.restoreGraphicsState()
            }
        }

    }
    
    /**
     Draw a rectangle at the specified point and anchor position.
     
     - Parameters:
        - at: Point at which the rectangle will be drawn.
        - anchoredBy: Draw the rectangle from a point at the rectangle's bottom left corner, or, the rectangle's centre.
        - width: How wide the rectangle will be across its horizontal axis.
        - height: How tall the rectangle will be across its vertical axis.
        - borderWidth: How thick the stroke of the border should be.
     */
    public func drawRectangle(at: Point, width: Int, height: Int, anchoredBy : AnchorPosition = AnchorPosition.bottomLeft, borderWidth: Int = 1) {
        
        // Set attributes of shape based on the canvas scale factor
        var bottomLeftX = at.x
        bottomLeftX *= scale.asCGFloat()
        var bottomLeftY = at.y
        bottomLeftY *= scale.asCGFloat()
        var width = width
        width *= scale
        var height = height
        height *= scale
        var borderWidth = borderWidth
        borderWidth *= scale
        
        // Adjust when anchored at centre point
        if anchoredBy == .centre {
            bottomLeftX = at.x * scale.asCGFloat() - width.asCGFloat() / 2
            bottomLeftY = at.y * scale.asCGFloat() - height.asCGFloat() / 2
        }
        
        // Make the new path
        let path = NSBezierPath(rect: NSRect(x: bottomLeftX, y: bottomLeftY, width: width.asCGFloat(), height: height.asCGFloat()))
        
        // Set width of border
        if borderWidth > 1 * scale {
            path.lineWidth = borderWidth.asCGFloat()
        } else {
            path.lineWidth = CGFloat(self.defaultBorderWidth * scale)
        }
        
        // Set rectangle border color
        NSColor(hue: borderColor.translatedHue, saturation: borderColor.translatedSaturation, brightness: borderColor.translatedBrightness, alpha: borderColor.translatedAlpha).setStroke()
        
        // Draw the rectangle border
        if (self.drawShapesWithBorders == true) {
            path.stroke()
        }
        
        // Set rectangle fill color
        NSColor(hue: fillColor.translatedHue, saturation: fillColor.translatedSaturation, brightness: fillColor.translatedBrightness, alpha: fillColor.translatedAlpha).setFill()
        
        // Fill the rectangle
        if (self.drawShapesWithFill == true) {
            path.fill()
        }
        
        if onBigSur {
            // Update for playground preview
            if !highPerformance {
                NSGraphicsContext.saveGraphicsState()
                NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: self.offscreenRepresentation)
                self.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)
                NSGraphicsContext.restoreGraphicsState()
            }
        }

    }
    
    /**
     Draw a rounded rectangle at the specified point and anchor position.
     
     For the `xRadius` and `yRadius` parameters, imagine a circle at each corner of the rectangle.
     
     An `xRadius` and `yRadius` of 25 each means that the last 25 points of a typical rectangle have been replaced with the rounded edge of a circle with a radius of 25 points.
     
     When the `xRadius` and `yRadius` values are different, you can imagine that the corners of a typical rectangle have been replaced by the rounded edge of an ellipse rather than a circle.
     
     For example:
     
     `canvas.drawRoundedRectangle(at: Point(x: 50, y: 50),`
     `                            width: 100,`
     `                            height: 75,`
     `                            anchoredBy: .bottomLeft,`
     `                            borderWidth: 2,`
     `                            xRadius: 20,`
     `                            yRadius: 30)`
     
     ... will produce:
     
     ![drawCustomShape](http://russellgordon.ca/CanvasGraphics/drawRoundedRectangle_example.png)

     - Parameters:
        - at: Point at which the rectangle will be drawn.
        - anchoredBy: Draw the rectangle from a point at the rectangle's bottom left corner, or, the rectangle's centre.
        - width: How wide the rectangle will be across its horizontal axis.
        - height: How tall the rectangle will be across its vertical axis.
        - borderWidth: How thick the stroke of the border should be.
        - xRadius: Horizontal size of the rounded corner.
        - yRadius: Vertical size of the rounded corner.
     */
    public func drawRoundedRectangle(at: Point, width: Int, height: Int, anchoredBy : AnchorPosition = AnchorPosition.bottomLeft, borderWidth: Int = 1, xRadius: Int = 10, yRadius: Int = 10) {
        
        // Set attributes of shape based on the canvas scale factor
        var bottomLeftX = at.x
        bottomLeftX *= scale.asCGFloat()
        var bottomLeftY = at.y
        bottomLeftY *= scale.asCGFloat()
        var width = width
        width *= scale
        var height = height
        height *= scale
        var borderWidth = borderWidth
        borderWidth *= scale
        var xRadius = xRadius
        xRadius *= scale
        var yRadius = yRadius
        yRadius *= scale
        
        // Adjust when anchored at centre point
        if anchoredBy == .centre {
            bottomLeftX = at.x - width.asCGFloat() / 2
            bottomLeftY = at.y - height.asCGFloat() / 2
        }
        
        // Make the new path
        let path = NSBezierPath(roundedRect: NSRect(x: bottomLeftX, y: bottomLeftY, width: width.asCGFloat(), height: height.asCGFloat()), xRadius: xRadius.asCGFloat(), yRadius: yRadius.asCGFloat())
        
        // Set width of border
        if borderWidth > 1 * scale {
            path.lineWidth = borderWidth.asCGFloat()
        } else {
            path.lineWidth = CGFloat(self.defaultBorderWidth * scale)
        }
        
        // Set rectangle border color
        NSColor(hue: borderColor.translatedHue, saturation: borderColor.translatedSaturation, brightness: borderColor.translatedBrightness, alpha: borderColor.translatedAlpha).setStroke()
        
        // Draw the rectangle border
        if (self.drawShapesWithBorders == true) {
            path.stroke()
        }
        
        // Set rectangle fill color
        NSColor(hue: fillColor.translatedHue, saturation: fillColor.translatedSaturation, brightness: fillColor.translatedBrightness, alpha: fillColor.translatedAlpha).setFill()
        
        // Fill the rectangle
        if (self.drawShapesWithFill == true) {
            path.fill()
        }
        
        if onBigSur {
            // Update for playground preview
            if !highPerformance {
                NSGraphicsContext.saveGraphicsState()
                NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: self.offscreenRepresentation)
                self.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)
                NSGraphicsContext.restoreGraphicsState()
            }
        }

    }
    
    /**
     Draws a closed polygon from the given vertices.
     
     - parameter vertices: An array of Point instances defining the vertices of the figure.
     
     At least three vertices must be provided.
     
     For example:
     
     `var myPoints : [Point] = []`
     
     `myPoints.append(Point(x: 50, y: 50))`
     
     `myPoints.append(Point(x: 100, y: 50))`
     
     `myPoints.append(Point(x: 75, y: 100))`
     
     `canvas.drawCustomShape(with: myPoints)`
     
     ... will produce:
     
     ![drawCustomShape](http://russellgordon.ca/CanvasGraphics/drawCustomShape_example.png)

     */
    public func drawCustomShape(with vertices : [Point]) {
        
        // Ensure there are at least three vertices provided
        if vertices.count < 3 {
            return
        }
        
        // Reset the custom path
        let customPath = NSBezierPath()
        
        // Start the custom path at given co-ordinates
        customPath.move(to: NSPoint(x: CGFloat(vertices.first!.x) * CGFloat(scale), y: CGFloat(vertices.first!.y) * CGFloat(scale)))
        
        // Draw a line to each additional vertex
        for vertex in vertices.dropFirst() {
            customPath.line(to: NSPoint(x: CGFloat(vertex.x) * CGFloat(scale), y: CGFloat(vertex.y) * CGFloat(scale)))
        }
        
        // Draw a line back to the original vertex
        customPath.line(to: NSPoint(x: CGFloat(vertices.first!.x) * CGFloat(scale), y: CGFloat(vertices.first!.y) * CGFloat(scale)))
        customPath.close()
        
        // Set the width
        customPath.lineWidth = CGFloat(self.defaultBorderWidth) * CGFloat(scale) * 0.5
        
        // Set shape's border color
        NSColor(hue: borderColor.translatedHue, saturation: borderColor.translatedSaturation, brightness: borderColor.translatedBrightness, alpha: borderColor.translatedAlpha).setStroke()
        
        // Draw the shape's border
        if (self.drawShapesWithBorders == true) {
            customPath.stroke()
        }
        
        // Set shape's fill color
        NSColor(hue: fillColor.translatedHue, saturation: fillColor.translatedSaturation, brightness: fillColor.translatedBrightness, alpha: fillColor.translatedAlpha).setFill()
        
        // Fill the custom shape
        if (self.drawShapesWithFill == true) {
            customPath.fill()
        }
        
        if onBigSur {
            // Update for playground preview
            if !highPerformance {
                NSGraphicsContext.saveGraphicsState()
                NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: self.offscreenRepresentation)
                self.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)
                NSGraphicsContext.restoreGraphicsState()
            }
        }

    }
    
    /**
     Rotate the canvas around the origin.
     
     - parameter by: A value in degrees by which to rotate the canvas.
     
     Positive value rotate the canvas clockwise, negative values rotate the canvas counter-clockwise.
     
     Use `drawAxes()` after invoking this method to understand how the canvas is changed by rotation.
     
     */
    public func rotate(by provided : Degrees) {
        
        let xform = NSAffineTransform()
        xform.rotate(byDegrees: provided)
        xform.concat()
        
    }
    
    /**
     Translate the origin of the canvas to a new location.
     
     - parameter to: The point that you wish to move the origin to.
     
     Translating to (50, 100) would move the origin 50 steps "to the right" along the horizontal axis, and 100 steps "up" along the vertical axis.
     
     Note that "to the right" and "up" are relative, since the canvas may be rotated.
     */
    public func translate(to: Point) {
        
        var byX = to.x
        byX *= scale.asCGFloat()
        var byY = to.y
        byY *= scale.asCGFloat()
        
        let xform = NSAffineTransform()
        xform.translateX(by: byX, yBy: byY)
        xform.concat()
        
    }
    
    /**
     Save the current state of the canvas (location of origin, rotation of canvas).
     
     Works the same way as [pushMatrix()](https://processing.org/reference/pushMatrix_.html) in Processing.
     
     From the Processing documentation:
     
     "Pushes the current transformation matrix onto the matrix stack. Understanding pushMatrix() and popMatrix() requires understanding the concept of a matrix stack. The pushMatrix() function saves the current coordinate system to the stack and popMatrix() restores the prior coordinate system. pushMatrix() and popMatrix() are used in conjuction with the other transformation functions and may be embedded to control the scope of the transformations."
     */
    public func saveState() {
        NSGraphicsContext.saveGraphicsState()
    }
    
    /**
     Restore a prior state of the canvas (location of origin, rotation of canvas).
     
     Works the same way as [popMatrix()](https://processing.org/reference/popMatrix_.html) in Processing.
     
     From the Processing documentation:
     
     "Pops the current transformation matrix off the matrix stack. Understanding pushing and popping requires understanding the concept of a matrix stack. The pushMatrix() function saves the current coordinate system to the stack and popMatrix() restores the prior coordinate system. pushMatrix() and popMatrix() are used in conjuction with the other transformation functions and may be embedded to control the scope of the transformations."
     
     */
    public func restoreState() {
        NSGraphicsContext.restoreGraphicsState()
    }
    
    /**
     Copies the contents of the canvas to the clipboard.
     
     You can then paste the image into any other program, for example, Preview, and from there, save to disk, print, share with others, et cetera.
     */
    public func copyToClipboard() {
        
        // Clear the pasteboard
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        
        // Save the current high performance state
        let priorHighPerformanceState = self.highPerformance
        
        // If in high performance mode, temporarily disable
        if self.highPerformance {
            self.highPerformance = false
        }
        
        // Copy contents of image to clipboard
        pasteBoard.writeObjects([self.image!])
        
        // Restore prior high performance state
        self.highPerformance = priorHighPerformanceState
        
    }
    
    /// Draws horizontal and vertical axes based on the current location of the origin and rotation of the canvas.
    ///
    /// For example:
    ///
    /// ![axes](http://russellgordon.ca/CanvasGraphics/drawAxes_example.png)
    public func drawAxes(withScale: Bool = false, by: Int = 50) {
        
        // Draw horizontal axis
        self.drawLine(from: Point(x: self.width * -10, y: 0), to: Point(x: self.width * 10, y: 0), capStyle: NSBezierPath.LineCapStyle.square)
        
        // Draw vertical axis
        self.drawLine(from: Point(x: 0, y: self.height * -10), to: Point(x: 0, y: self.height * 10), capStyle: NSBezierPath.LineCapStyle.square)
        
        // Determine horizontal start and end points
        let horizontalStart = self.width / by * -1
        let horizontalEnd = horizontalStart * -1

        // Determine vertical start and end points
        let verticalStart = self.height / by * -1
        let verticalEnd = verticalStart * -1

        // Draw labels
        self.drawText(message: "x", at: Point(x: horizontalEnd * by - 10, y: 5), size: 12)
        self.drawText(message: "y", at: Point(x: 5, y: verticalEnd * by - 20), size: 12)
        
        // Save line color
        if withScale {
            
            let priorLineColor = self.lineColor
            self.lineColor = Color(hue: 0, saturation: 100, brightness: 0, alpha: 18)
            
            // Draw horizontal scale and grid
            for x in stride(from: horizontalStart * by, through: horizontalEnd * by, by: by) {
                
                // Scale
                if x != 0 {
                    self.drawText(message: "\(x)", at: Point(x: x + 5, y: 5), size: 9)
                }
                
                // Grid
                self.drawLine(from: Point(x: x, y: self.height * -1), to: Point(x: x, y: self.height), dashed: true)
            }

            // Draw vertical scale and grid
            for y in stride(from: verticalStart * by, through: verticalEnd * by, by: by) {
                
                // Scale
                if y != 0 && y != verticalEnd * by {
                    self.drawText(message: "\(y)", at: Point(x: 5, y: y - 15), size: 9)
                }
                
                // Grid
                self.drawLine(from: Point(x: self.width * -1, y: y), to: Point(x: self.width, y: y), dashed: true)
            }
            
            // Restore line color
            self.lineColor = priorLineColor

        }
        
    }
    
}
