//: [Previous](@previous) / [Next](@next)
//: # Tortoise Examples
//:
//: The `CanvasGraphics` framework also allows you to draw using a "LOGO turtle" metaphor.
//:
//: [Documentation for the Tortoise abstraction](http://russellgordon.ca/CanvasGraphics/Documentation/Classes/Tortoise.html) is available.
/*:
 ## Canvas size
 
 Set the size of your desired canvas by adjusting the constants on lines 10 and 11.
 */
let preferredWidth = 500
let preferredHeight = 500
/*:
 ## Required code
 
 Lines 21 to 29 are required to make the playground run.
 
 Please do not remove.
 */
import Cocoa
import PlaygroundSupport
import CanvasGraphics

// Create canvas
let canvas = Canvas(width: preferredWidth, height: preferredHeight)

// Show the canvas in the playground's live view
PlaygroundPage.current.liveView = canvas

/*:
## Tortoise class

To use the Tortoise abstraction, just create an instance of the Tortoise class, and provide it with a canvas object that is should draw upon.
*/

// Create a turtle that will draw upon the canvas
let turtle = Tortoise(drawingUpon: canvas)

// Draw a square
turtle.penUp()
turtle.setPenColor(to: .black)
turtle.setPenSize(to: 1)
turtle.goToHome()
turtle.penDown()
for _ in 1...4 {
    turtle.forward(steps: 100)
    turtle.left(by: 90)
    turtle.currentHeading()
    turtle.currentPosition()
}

// Move to middle of canvas and draw square
turtle.penUp()
turtle.setPosition(to: Point(x: 250, y: 250))
turtle.penDown()
turtle.currentPosition()
turtle.penDown()
for _ in 1...4 {
    turtle.forward(steps: 100)
    turtle.left(by: 90)
    turtle.currentHeading()
    turtle.currentPosition()
}

// Move up a bit more
turtle.penUp()
turtle.setPosition(to: Point(x: 300, y: 300))
turtle.penDown()
turtle.currentPosition()
turtle.penDown()
for _ in 1...4 {
    turtle.forward(steps: 100)
    turtle.left(by: 90)
    turtle.currentHeading()
}

// Move back a bit
turtle.penUp()
turtle.setPosition(to: Point(x: 200, y: 200))
turtle.penDown()
turtle.currentPosition()
turtle.penDown()
for _ in 1...4 {
    turtle.forward(steps: 100)
    turtle.left(by: 90)
    turtle.currentHeading()
}

// Left corner of canvas
turtle.penUp()
turtle.setPosition(to: Point(x: 100, y: 350))
turtle.penDown()
turtle.currentPosition()
// Draw a sqaure backwards
for _ in 1...4 {
    turtle.backward(steps: 100)
    turtle.right(by: 90)
}

// Go home
turtle.penUp()
turtle.goToHome()
turtle.penDown()
turtle.currentPosition()
turtle.currentHeading()

// Move over and up a bit
turtle.penUp()
turtle.setPosition(to: Point(x: 150, y: 50))
turtle.penDown()

// Turn left a bit
turtle.left(by: 45)
turtle.currentHeading()
turtle.setPenColor(to: .red)
turtle.setPenSize(to: 1)
turtle.forward(steps: 45)
turtle.backward(steps: 45)

// Turn left a bit more
turtle.left(by: 45)
turtle.currentHeading()
turtle.setPenSize(to: 2)
turtle.setPenColor(to: .blue)
turtle.forward(steps: 45)
turtle.backward(steps: 45)

// Turn right by 135
turtle.right(by: 135)
turtle.currentHeading()
turtle.setPenSize(to: 3)
turtle.setPenColor(to: .green)
turtle.forward(steps: 45)
turtle.backward(steps: 45)

// Turn left by 45
turtle.left(by: 45)
turtle.currentHeading()
turtle.setPenSize(to: 4)
turtle.setPenColor(to: .purple)
turtle.forward(steps: 45)
turtle.backward(steps: 45)

// Move over and repeat using absolute headings
turtle.penUp()
turtle.setPosition(to: Point(x: 250, y: 50))
turtle.penDown()

// Turn left a bit
turtle.setHeading(to: 45)
turtle.currentHeading()
turtle.setPenSize(to: 1)
turtle.setPenColor(to: .red)
turtle.forward(steps: 45)
turtle.currentPosition()
turtle.backward(steps: 45)

// Turn left a bit more
turtle.setHeading(to: 90)
turtle.currentHeading()
turtle.setPenSize(to: 2)
turtle.setPenColor(to: .blue)
turtle.forward(steps: 45)
turtle.currentPosition()
turtle.backward(steps: 45)

// Turn right by 135
turtle.setHeading(to: -45)
turtle.currentHeading()
turtle.setPenSize(to: 3)
turtle.setPenColor(to: .green)
turtle.forward(steps: 45)
turtle.currentPosition()
turtle.backward(steps: 45)

// Turn left by 45
turtle.setHeading(to: 0)
turtle.currentHeading()
turtle.setPenSize(to: 4)
turtle.setPenColor(to: .purple)
turtle.forward(steps: 45)
turtle.currentPosition()
turtle.backward(steps: 45)

// Turtle sun!
turtle.setPenSize(to: 1)
turtle.penUp()
turtle.setPosition(to: Point(x: 400, y: 150))
turtle.penUp()
turtle.backward(steps: 100)
turtle.penDown()

turtle.setPenColor(to: .red)
turtle.setFillColor(to: .yellow)
turtle.beginFill()
for _ in 1...36 {
    turtle.forward(steps: 100)
    turtle.left(by: 170)
}
turtle.endFill()

// Draw a black triangle with a yellow fill
turtle.penUp()
turtle.setPosition(to: Point(x: 50, y: 225))
turtle.penDown()
turtle.setPenColor(to: .black)
turtle.setFillColor(to: .yellow)
turtle.setPenSize(to: 4)
turtle.currentHeading()
turtle.currentPosition()
turtle.beginFill()
for _ in 1...3 {
    turtle.forward(steps: 100)
    turtle.right(by: 120)
}
turtle.endFill()

// Draw turtle at current position
turtle.penUp()
turtle.setPosition(to: Point(x: 50, y: 275))
turtle.setHeading(to: 135)
turtle.drawSelf()

// Test turtle drawing of self
turtle.penUp()
turtle.setPosition(to: Point(x: 100, y: 475))

// Draw self at original orientation
turtle.drawSelf()
turtle.penDown()

// Draw turtle at varying orientations
for i in 1...8 {
    turtle.setPenColor(to: Color(hue: 45.0 * Float(i), saturation: 80, brightness: 90, alpha: 100))
    turtle.setPenSize(to: i)
    turtle.setPosition(to: Point(x: turtle.xcor + 50, y: turtle.ycor))
    turtle.currentPosition()
    turtle.left(by: 45)
    turtle.drawSelf()
}


/*:
 ## Show the Assistant Editor
 Don't see any results?
 
 Remember to show the Assistant Editor (1), and then switch to Live View (2):
 
 ![timeline](timeline.png "Timeline")

 ## Use source control
 To keep your work organized, receive feedback, and earn a high grade in this course, regular use of source control is a must.
 
 Please commit and push your work often.
 
 ![source_control](source-control.png "Source Control")
 */
