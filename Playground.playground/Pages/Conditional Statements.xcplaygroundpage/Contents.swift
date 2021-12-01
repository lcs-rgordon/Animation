//: [Previous](@previous) / [Next](@next)
/*:
 ## Canvas size
 
 Set the size of your desired canvas by adjusting the constants on lines 7 and 8.
 */
let preferredWidth = 400
let preferredHeight = 600
/*:
 ## Required code
 
 Lines 16 to 30 are required to make the playground run.
 
 Please do not remove.
 */
import Cocoa
import PlaygroundSupport
import CanvasGraphics

// Create canvas
let canvas = Canvas(width: preferredWidth, height: preferredHeight)

// Create a turtle that can draw upon the canvas
let turtle = Tortoise(drawingUpon: canvas)

// Create a pen that can draw upon the canvas
let p = Pen(drawingUpon: canvas)

// Show the canvas in the playground's live view
PlaygroundPage.current.liveView = canvas

/*:
 ## Optional code
 
 Below are two generally helpful configurations.
 
 If you do not wish to work in all four quadrants of the Cartesian plane, comment out the code on line 44.
 
 If you do not wish to see a grid, comment out the code on line 48.
 
 */

// Move the origin from the bottom-left corner of the canvas to it's centre point



/*:
 ## Add your code
 
 Beginning on line 61, you can add your own code.
 
 [Documentation](http://russellgordon.ca/CanvasGraphics/Documentation/) is available.
 
 */

// Create a light blue colour constant
let lightBlue = Color(hue: 195, saturation: 68, brightness: 84, alpha: 100)

// Set the fill color for shapes that follow
canvas.fillColor = lightBlue

// Draw a rectangle to create the background
canvas.drawRectangle(at: Point(x: 0, y: 0), width: 400, height: 600)

// Set the colour for text that follows this command
canvas.textColor = .white

// Draw "hello" in big letters, tightly spaced
canvas.drawText(message: "hello", at: Point(x: 200, y: 200), size: 45, kerning: -5)

// Draw "goodbye" in smaller letters, spread out
canvas.drawText(message: "goodbye", at: Point(x: 225, y: 100), size: 25, kerning: 4)

// Show a grid
canvas.drawAxes(withScale: true, by: 50, color: .white)









/*:
 ## Show the Live View
 Don't see any results?
 
 Remember to show the Live View (1 then 2):
 
 ![timeline](timeline.png "Timeline")
 
 ## Use source control
 To keep your work organized, receive feedback, and earn a high grade in this course, regular use of source control is a must.
 
 Please commit and push your work often.
 
 ![source_control](source-control.png "Source Control")
 */
