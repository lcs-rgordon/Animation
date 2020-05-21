//: [Previous](@previous) / [Next](@next)
//: # Introduction
//:
//: This is a playground that will let you draw shapes and other graphics easily.
/*:
 ## Canvas size
 
 Set the size of your desired canvas by adjusting the constants on lines 10 and 11.
 */
let preferredWidth = 500
let preferredHeight = 500
/*:
 ## Required code
 
 Lines 19 to 27 are required to make the playground run.
 
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
 ## Add your code
 
 Beginning on line 38, write a meaningful comment.
 
 You can remove the code on line 39 and begin writing your own code.
 
 [Documentation](http://russellgordon.ca/CanvasGraphics/Documentation/) is available.
 */

// Create a turtle that will draw upon the canvas
let turtle = Tortoise(drawingUpon: canvas)

// Draw a square
turtle.penDown()
for i in 1...4 {
    turtle.forward(steps: 100)
    turtle.left(by: 90)
    turtle.currentHeading()
}

// Move to middle of canvas and draw square
turtle.setPosition(to: Point(x: 250, y: 250))
turtle.currentPosition()
turtle.penDown()
for i in 1...4 {
    turtle.forward(steps: 100)
    turtle.left(by: 90)
    turtle.currentHeading()
}

// Move up a bit more
turtle.setPosition(to: Point(x: 300, y: 300))
turtle.currentPosition()
turtle.penDown()
for i in 1...4 {
    turtle.forward(steps: 100)
    turtle.left(by: 90)
    turtle.currentHeading()
}

// Move back a bit
turtle.setPosition(to: Point(x: 200, y: 200))
turtle.currentPosition()
turtle.penDown()
for i in 1...4 {
    turtle.forward(steps: 100)
    turtle.left(by: 90)
    turtle.currentHeading()
}

// Left corner of canvas
turtle.setPosition(to: Point(x: 100, y: 350))
turtle.currentPosition()
// Draw a sqaure backwards
for _ in 1...4 {
    turtle.backward(steps: 100)
    turtle.right(by: 90)
}

// Go home
turtle.goToHome()
turtle.currentPosition()
turtle.currentHeading()

// Move over and up a bit
turtle.setPosition(to: Point(x: 150, y: 50))

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
turtle.setPosition(to: Point(x: 250, y: 50))

// Turn left a bit
turtle.setHeading(to: 45)
turtle.currentHeading()
turtle.setPenSize(to: 1)
turtle.setPenColor(to: .red)
turtle.forward(steps: 45)
turtle.backward(steps: 45)

// Turn left a bit more
turtle.setHeading(to: 90)
turtle.currentHeading()
turtle.setPenSize(to: 2)
turtle.setPenColor(to: .blue)
turtle.forward(steps: 45)
turtle.backward(steps: 45)

// Turn right by 135
turtle.setHeading(to: -45)
turtle.currentHeading()
turtle.setPenSize(to: 3)
turtle.setPenColor(to: .green)
turtle.forward(steps: 45)
turtle.backward(steps: 45)

// Turn left by 45
turtle.setHeading(to: 0)
turtle.currentHeading()
turtle.setPenSize(to: 4)
turtle.setPenColor(to: .purple)
turtle.forward(steps: 45)
turtle.backward(steps: 45)

//// Draw canvas axes
//canvas.drawAxes()
//canvas.rotate(by: 45)
//canvas.drawAxes()







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
