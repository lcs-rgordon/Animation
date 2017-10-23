import Cocoa
import Foundation

/**
 Returns a random number in the given range.
 
 - parameter from: The lowest possible random value that may be returned.
 - parameter toButNotIncluding: The random number returned will never include this value.
 
 */
public func random(from : Int, toButNotIncluding : Int) -> Int {
    
    let max = UInt32(toButNotIncluding - from)
    
    return Int(arc4random_uniform(max)) + from
    
}

public typealias Degrees = CGFloat

/**
 Used to set scale factor for the canvas.
 
 Standard should generally be used. When quality level is set to High or Ultra, the time required to generate the canvas is *significantly* increased. Only use a quality level other than standard when generating image output for printing.
 
 */
public enum Quality : Int {
    case Standard = 1
    case High = 2
    case Ultra = 4
}

open class Color {
    
    // FIXME: Need more research into how to properly write a class that handles invalid property geting/setting
    //
    // If I want to write a class that "fixes" or rationalizes invalid values provided to it, when:
    //
    // 1. initializing a new object
    // 2. setting properties of the object
    //
    // ...what is the correct way to do this in Swift?
    //
    // The purpose of the Color class I have written is to take hue, saturation, brightness,
    // and alpha values range between 0-360, 0-100, 0-100, and 0-100 respectively.
    //
    // My thought was that property observers are the answer:
    //
    // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html
    //
    // but Apple's documentation explicitly states that property observers are not called when
    // a property is set from within an initializer:
    //
    // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID204
    //
    // NOTE
    //
    //  When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.
    //
    // As you can see, I am using private functions that are called from the initializer
    // and the property observer (so I am not duplicating logic to rationalize the passed values).
    //
    // However, this seems inelegant.
    //
    // All in all, after doing more reading about failable initializers:
    //
    // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203
    //
    // ... it really seems like perhaps I should NOT be trying to rationalize invalid values. Perhaps, instead, I should just fail to initialize an object if bad values are provided.
    //
    // Future self – something to think about.
    
    // Static properties for convenience for basic colors
    public static let black : Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    public static let white : Color = Color(hue: 0, saturation: 0, brightness: 100, alpha: 100)
    public static let red : Color = Color(hue: 0, saturation: 80, brightness: 90, alpha: 100)
    public static let orange : Color = Color(hue: 30, saturation: 80, brightness: 90, alpha: 100)
    public static let yellow : Color = Color(hue: 60, saturation: 80, brightness: 90, alpha: 100)
    public static let green : Color = Color(hue: 120, saturation: 80, brightness: 90, alpha: 100)
    public static let blue : Color = Color(hue: 240, saturation: 80, brightness: 90, alpha: 100)
    public static let purple : Color = Color(hue: 270, saturation: 80, brightness: 90, alpha: 100)
    
    var hue: Float = 0.0 {
        didSet {
            hue = self.rationalizeToSinglePositiveRotation(hue)
            self.translatedHue = CGFloat(self.hue / 360)
        }
    }
    
    var saturation: Float = 0.0 {
        didSet {
            saturation = self.rationalizePercentage(saturation)
            self.translatedSaturation = CGFloat(self.saturation / 100)
        }
    }
    
    var brightness: Float = 0.0 {
        didSet {
            brightness = self.rationalizePercentage(brightness)
            self.translatedBrightness = CGFloat(self.brightness / 100)
        }
    }
    
    var alpha: Float = 0.0 {
        didSet {
            alpha = self.rationalizePercentage(alpha)
            self.translatedAlpha = CGFloat(self.alpha / 100)
        }
    }
    
    var translatedHue : CGFloat = 0.0
    var translatedSaturation : CGFloat = 0.0
    var translatedBrightness : CGFloat = 0.0
    var translatedAlpha : CGFloat = 0.0
    
    public init(hue: Float, saturation: Float, brightness: Float, alpha: Float) {
        
        // Set with provided values, but translate to valid values first
        self.hue = rationalizeToSinglePositiveRotation(hue)
        self.saturation = rationalizePercentage(saturation)
        self.brightness = rationalizePercentage(brightness)
        self.alpha = rationalizePercentage(alpha)
        
        // Prepare values to provide to NSColor initializer
        self.translatedHue = CGFloat(self.hue / 360)
        self.translatedSaturation = CGFloat(self.saturation / 100)
        self.translatedBrightness = CGFloat(self.brightness / 100)
        self.translatedAlpha = CGFloat(self.alpha / 100)
        
    }
    
    // Allow integer inputs to be used to set color values as well
    public convenience init(hue: Int, saturation: Int, brightness: Int, alpha: Int) {
        
        self.init(hue: Float(hue), saturation: Float(saturation), brightness: Float(brightness), alpha: Float(alpha))
        
    }
    
    // Takes a given number of degrees and translates to range between 0 and 360
    fileprivate func rationalizeToSinglePositiveRotation(_ value : Float) -> Float {
        
        if value < 0 {
            return 0.0
        } else if value > 360 {
            return value.truncatingRemainder(dividingBy: 360)
        }
        
        return value
        
    }
    
    // Takes a given value and translates to a percentage between 0 and 100
    fileprivate func rationalizePercentage(_ value : Float) -> Float {
        
        if value < 0 {
            return 0.0
        } else if value > 100 {
            return value.truncatingRemainder(dividingBy: 100)
        }
        
        return value
        
    }
    
}

open class Canvas : CustomPlaygroundQuickLookable {
    
    /// A custom playground Quick Look for this instance.
    ///
    /// If this type has value semantics, the `PlaygroundQuickLook` instance
    /// should be unaffected by subsequent mutations.
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return .image(self.privateImageView)
    }
    
    public var imageView : NSImageView {
        self.highPerformance = false
        return self.privateImageView
    }
    
    // Frame rate for animation on this canvas
    var framesPerSecond : Int = 60 {
        didSet {
            // Ensure rational frame rate set
            if (framesPerSecond < 0) {
                framesPerSecond = 1
            }
        }
    }
    
    // Keep track of how many frames have been animated using this particular canvas
    var frameCount : Int = 0
    
    // Image view that will display our image
    var privateImageView: NSImageView = NSImageView()
    
    // default line width
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
    
    // Line color, default is black
    open var lineColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    // Border width for closed shapes
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
    
    // Border color, default is black
    open var borderColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    // Fill color, default is black
    open var fillColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    // Text color, default is black
    open var textColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    // Whether to draw shapes with borders
    open var drawShapesWithBorders: Bool = true
    
    // Whether to draw shapes with fill
    open var drawShapesWithFill: Bool = true
    
    // Size of canvas
    open let width : Int
    open let height : Int
    
    // Current location of mouse on canvas
    open var mouseX : Float = 0.0
    open var mouseY : Float = 0.0
    
    // Scale factor for drawing
    open let scale : Int
    
    /**
     Draw in high performance mode.
     
     When set to true, the canvas will not update after every draw call.
     
     */
    open var highPerformance : Bool = false {
        didSet {
            if self.highPerformance {
                
                self.privateImageView.image = nil
                
            } else {
                
                self.privateImageView.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)
                
            }
        }
    }
    
    // Off screen drawing representation
    private var offscreenRep : NSBitmapImageRep
    public var offscreenRepresentation : NSBitmapImageRep {
        return self.offscreenRep
    }
    
    // Initialization of object based on this class
    public init(width: Int, height: Int, quality : Quality = Quality.Standard) {
        
        // Set the canvas scale factor
        self.scale = quality.rawValue
        
        // Set the width and height of the canvas
        self.width = width
        self.height = height
        
        // Set the default line and border widths
        self.defaultLineWidth = 1 * self.scale
        self.defaultBorderWidth = 1 * self.scale
        
        // Create the frame that defines boundaries of the image view to be used
        let frameRect = NSRect(x: 0, y: 0, width: self.width * self.scale, height: self.height * self.scale)
        
        // Create the image view based on dimensions of frame created
        self.privateImageView = NSImageView(frame: frameRect)
        
        // Define the offscreen bitmap we will draw to
        offscreenRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: self.width * self.scale, pixelsHigh: self.height * self.scale, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: NSColorSpaceName.calibratedRGB, bytesPerRow: 4 * self.width * self.scale, bitsPerPixel: 32)!
        
        // Set the grpahics context to the offscreen bitmap
        NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: offscreenRep)
        
        // Make the background white
        self.fillColor = Color.white
        self.drawShapesWithBorders = false
        self.drawRectangle(bottomLeftX: 0, bottomLeftY: 0, width: self.width * self.scale, height: self.height * self.scale)
        self.fillColor = Color.black
        self.drawShapesWithBorders = true
        
        // Default to low performance mode (shows output after every draw call, better for debugging and student learning)
        self.privateImageView.image = NSImage(cgImage: offscreenRep.cgImage!, size: offscreenRep.size)
        
        
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
        let attributes: [NSAttributedStringKey : AnyObject] = [
            NSAttributedStringKey.foregroundColor: fieldColor,
            NSAttributedStringKey.paragraphStyle: paraStyle,
            NSAttributedStringKey.obliqueness: skew as AnyObject,
            NSAttributedStringKey.font: fieldFont!
        ]
        
        // Draw the string
        string.draw(at: NSPoint(x: x, y: y), withAttributes: attributes)
        
    }
    
    // Draw a line on the image
    open func drawLine(fromX: Int, fromY: Int, toX: Int, toY: Int, lineWidth: Int = 0, capStyle : NSBezierPath.LineCapStyle = NSBezierPath.LineCapStyle.squareLineCapStyle) {
        
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
        
    }
    
    // Convenience method to draw rectangle from it's centre point
    open func drawRectangle(centreX: Int, centreY: Int, width: Int, height: Int, borderWidth: Int = 1) {
        
        // Call the original method but with points translated
        self.drawRectangle(bottomLeftX: centreX - width / 2, bottomLeftY: centreY - height / 2, width: width, height: height, borderWidth: borderWidth)
        
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
        
    }
    
    // Convenience method to draw a roudned rectangle from it's centre point
    open func drawRoundedRectangle(centreX: Int, centreY: Int, width: Int, height: Int, borderWidth: Int = 1, xRadius : Int = 10, yRadius : Int = 10) {
        
        // Call the original method but with points translated
        self.drawRoundedRectangle(bottomLeftX: centreX - width / 2, bottomLeftY: centreY - height / 2, width: width, height: height, borderWidth: borderWidth, xRadius: xRadius, yRadius: yRadius)
        
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
        
    }
    
    
    open func rotate(by provided : Degrees) {
        
        let xform = NSAffineTransform()
        xform.rotate(byDegrees: provided)
        xform.concat()
        
    }
    
    open func translate(byX: Int, byY: Int) {
        
        var byX = byX
        byX *= scale
        var byY = byY
        byY *= scale
        
        let xform = NSAffineTransform()
        xform.translateX(by: CGFloat(byX), yBy: CGFloat(byY))
        xform.concat()
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
        pasteBoard.writeObjects([self.privateImageView.image!])
        
        // Restore prior high performance state
        self.highPerformance = priorHighPerformanceState
        
    }
    
    open func drawAxes() {
        
        // Draw horizontal axis
        self.drawLine(fromX: self.width * -10, fromY: 0, toX: self.width * 10, toY: 0, lineWidth: 1, capStyle: NSBezierPath.LineCapStyle.squareLineCapStyle)
        
        // Draw vertical axis
        self.drawLine(fromX: 0, fromY: self.height * -10, toX: 0, toY: self.height * 10, lineWidth: 1, capStyle: NSBezierPath.LineCapStyle.squareLineCapStyle)
        
        // Draw labels
        self.drawText(message: "x", size: 12, x: 50, y: 5)
        self.drawText(message: "y", size: 12, x: 5, y: 50)
        
    }
    
}

