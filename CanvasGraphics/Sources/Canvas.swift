import Cocoa
import Foundation

public typealias Degrees = CGFloat

/// Set to High (2x) or Ultra (4x) when generating output for printing, otherwise use Standard.
public enum Quality : Int {
    case Standard = 1
    case High = 2
    case Ultra = 4
}

open class Canvas : NSImageView, CustomPlaygroundDisplayConvertible {
    
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
    
    /// Keep track of how many frames have been animated using this particular canvas
    public var frameCount : Int = 0
    
    /// Default line width
    open var defaultLineWidth: Int = 1 {
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
    open var lineColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    /// Default border width for closed shapes
    open var defaultBorderWidth: Int = 1 {
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
    open var borderColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    /// Fill color, default is black
    open var fillColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    /// Text color, default is black
    open var textColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    /// Whether to draw shapes with borders
    open var drawShapesWithBorders: Bool = true
    
    /// Whether to draw shapes with fill
    open var drawShapesWithFill: Bool = true
    
    // Size of canvas
    public let width : Int
    public let height : Int
    
    // Scale factor for drawing
    public let scale : Int
    
    /// Draw in high performance mode. When true, canvas does not update after every draw call.
    open var highPerformance : Bool = false {
        didSet {
            if self.highPerformance {
                
                self.image = nil
                
            } else {
                
                self.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)
                
            }
        }
    }
    
    // Off screen drawing representation
    private var offscreenRep : NSBitmapImageRep
    public var offscreenRepresentation : NSBitmapImageRep {
        return self.offscreenRep
    }
    
    /// Creates a canvas object that can be drawn upon.
    /// - parameter width: Width of the canvas
    /// - parameter height: Height of the canvas
    /// - parameter qualty: When generating output for printing, use High or Ultra.
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
        self.offscreenRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: self.width * self.scale, pixelsHigh: self.height * self.scale, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: NSColorSpaceName.calibratedRGB, bytesPerRow: 4 * self.width * self.scale, bitsPerPixel: 32)!

        // Initialize the superclass
        super.init(frame: NSRect(x: 0, y: 0, width: self.width * self.scale, height: self.height * self.scale))
        
        // Set the grpahics context to the offscreen bitmap
        NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: offscreenRep)
        
        // Set the view's image
        self.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)

        // Make the background white
        self.fillColor = Color.white
        self.drawShapesWithBorders = false
        self.drawRectangle(bottomLeftX: 0, bottomLeftY: 0, width: self.width * self.scale, height: self.height * self.scale)
        self.fillColor = Color.black
        self.drawShapesWithBorders = true
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Update the view's image
        self.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)
        
    }
    
    // Draw text on the image
    open func drawText(message: String, size: Int = 24, x: Int = 0, y: Int = 0)  {
        
        // Set attributes of shape based on the canvas scale factor
        var size = size
        size *= scale
        var x = x
        x *= scale
        var y = y
        y *= scale
        
        // Convert the provided String object to an NSString object
        let string: NSString = NSString(string: message)
        
        // set the text color to dark gray
        let fieldColor : NSColor = NSColor(hue: textColor.translatedHue, saturation: textColor.translatedSaturation, brightness: textColor.translatedBrightness, alpha: textColor.translatedAlpha)
        
        // set the font to Helvetica Neue 24
        let fieldFont = NSFont(name: "Helvetica Neue", size: CGFloat(size))
        
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
            NSAttributedString.Key.font: fieldFont!
        ]
        
        // Draw the string
        string.draw(at: NSPoint(x: x, y: y), withAttributes: attributes)

        // Make the view update
        self.setNeedsDisplay()
        
    }
    
    // Draw a line on the image
    open func drawLine(fromX: Int, fromY: Int, toX: Int, toY: Int, lineWidth: Int = 0, capStyle : NSBezierPath.LineCapStyle = NSBezierPath.LineCapStyle.square) {
        
        // Set attributes of shape based on the canvas scale factor
        var fromX = fromX
        fromX *= scale
        var fromY = fromY
        fromY *= scale
        var toX = toX
        toX *= scale
        var toY = toY
        toY *= scale
        var lineWidth = lineWidth
        lineWidth *= scale
        
        // Make the new path with the specified cap style
        NSBezierPath.defaultLineCapStyle = capStyle
        let path = NSBezierPath()
        
        // Set width of border
        if lineWidth > 0 {
            path.lineWidth = CGFloat(lineWidth)
        } else {
            path.lineWidth = CGFloat(self.defaultLineWidth)
        }
        
        // Define the line
        path.move(to: NSPoint(x: fromX, y: fromY))
        path.line(to: NSPoint(x: toX, y: toY))
        
        // Set the line's color
        NSColor(hue: lineColor.translatedHue, saturation: lineColor.translatedSaturation, brightness: lineColor.translatedBrightness, alpha: lineColor.translatedAlpha).setStroke()
        
        // Draw the line
        path.stroke()
        
        // Make the view update
        self.setNeedsDisplay()

        
    }
    
    // Draw an ellipse on the image
    open func drawEllipse(centreX: Int, centreY: Int, width: Int, height: Int, borderWidth: Int = 0) {
        
        // Set attributes of shape based on the canvas scale factor
        var centreX = centreX
        centreX *= scale
        var centreY = centreY
        centreY *= scale
        var width = width
        width *= scale
        var height = height
        height *= scale
        var borderWidth = borderWidth
        borderWidth *= scale
        
        // Make the new path
        let path = NSBezierPath(ovalIn: NSRect(x: centreX - width/2, y: centreY - height/2, width: width, height: height))
        
        // Set width of border
        if borderWidth > 0 {
            path.lineWidth = CGFloat(borderWidth)
        } else {
            path.lineWidth = CGFloat(self.defaultBorderWidth * scale)
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
        
        // Make the view update
        self.setNeedsDisplay()
        
    }
    
    // Draw a rectangle on the image
    open func drawRectangle(bottomLeftX: Int, bottomLeftY: Int, width: Int, height: Int, borderWidth: Int = 1) {
        
        // Set attributes of shape based on the canvas scale factor
        var bottomLeftX = bottomLeftX
        bottomLeftX *= scale
        var bottomLeftY = bottomLeftY
        bottomLeftY *= scale
        var width = width
        width *= scale
        var height = height
        height *= scale
        var borderWidth = borderWidth
        borderWidth *= scale
        
        // Make the new path
        let path = NSBezierPath(rect: NSRect(x: bottomLeftX, y: bottomLeftY, width: width, height: height))
        
        // Set width of border
        if borderWidth > 1 * scale {
            path.lineWidth = CGFloat(borderWidth)
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
        
        // Make the view update
        self.setNeedsDisplay()
        
    }
    
    // Convenience method to draw rectangle from it's centre point
    open func drawRectangle(centreX: Int, centreY: Int, width: Int, height: Int, borderWidth: Int = 1) {
        
        // Call the original method but with points translated
        self.drawRectangle(bottomLeftX: centreX - width / 2, bottomLeftY: centreY - height / 2, width: width, height: height, borderWidth: borderWidth)
        
        // Make the view update
        self.setNeedsDisplay()
        
    }
    
    // Draw a rounded rectangle on the image
    open func drawRoundedRectangle(bottomLeftX: Int, bottomLeftY: Int, width: Int, height: Int, borderWidth: Int = 1, xRadius: Int = 10, yRadius : Int = 10) {
        
        // Set attributes of shape based on the canvas scale factor
        var bottomLeftX = bottomLeftX
        bottomLeftX *= scale
        var bottomLeftY = bottomLeftY
        bottomLeftY *= scale
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
        
        // Make the new path
        let path = NSBezierPath(roundedRect: NSRect(x: bottomLeftX, y: bottomLeftY, width: width, height: height), xRadius: CGFloat(xRadius), yRadius: CGFloat(yRadius))
        
        // Set width of border
        if borderWidth > 1 * scale {
            path.lineWidth = CGFloat(borderWidth)
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
        
        // Make the view update
        self.setNeedsDisplay()
        
    }
    
    // Convenience method to draw a roudned rectangle from it's centre point
    open func drawRoundedRectangle(centreX: Int, centreY: Int, width: Int, height: Int, borderWidth: Int = 1, xRadius : Int = 10, yRadius : Int = 10) {
        
        // Call the original method but with points translated
        self.drawRoundedRectangle(bottomLeftX: centreX - width / 2, bottomLeftY: centreY - height / 2, width: width, height: height, borderWidth: borderWidth, xRadius: xRadius, yRadius: yRadius)
        
        // Make the view update
        self.setNeedsDisplay()

    }
    
    /**
     Draws a closed polygon from the given vertices.
     
     - parameter vertices: An array of NSPoint instances defining the vertices of the figure.
     
     At least three vertices must be provided.
     
     */
    open func drawCustomShape(with vertices : [NSPoint]) {
        
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
        customPath.lineWidth = CGFloat(self.defaultLineWidth)
        
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
        
        // Make the view update
        self.setNeedsDisplay()
        
    }
    
    
    open func rotate(by provided : Degrees) {
        
        let xform = NSAffineTransform()
        xform.rotate(byDegrees: provided)
        xform.concat()
        
        // Make the view update
        self.setNeedsDisplay()

    }
    
    open func translate(byX: Int, byY: Int) {
        
        var byX = byX
        byX *= scale
        var byY = byY
        byY *= scale
        
        let xform = NSAffineTransform()
        xform.translateX(by: CGFloat(byX), yBy: CGFloat(byY))
        xform.concat()
        
        // Make the view update
        self.setNeedsDisplay()

    }
    
    open func saveState() {
        NSGraphicsContext.saveGraphicsState()
    }
    
    open func restoreState() {
        NSGraphicsContext.restoreGraphicsState()
    }
    
    /**
     Copies the contents of the canvas to the clipboard.
     
     You can then paste the image into any other program, for example, Preview, and then save to disk.
     
     */
    open func copyToClipboard() {
        
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
    
    open func drawAxes() {
        
        // Draw horizontal axis
        self.drawLine(fromX: self.width * -10, fromY: 0, toX: self.width * 10, toY: 0, lineWidth: 1, capStyle: NSBezierPath.LineCapStyle.square)
        
        // Draw vertical axis
        self.drawLine(fromX: 0, fromY: self.height * -10, toX: 0, toY: self.height * 10, lineWidth: 1, capStyle: NSBezierPath.LineCapStyle.square)
        
        // Draw labels
        self.drawText(message: "x", size: 12, x: 50, y: 5)
        self.drawText(message: "y", size: 12, x: 5, y: 50)
        
        // Make the view update
        self.setNeedsDisplay()
        
    }
    
}

