//: [Previous](@previous) / [Next](@next)
/*:
## Canvas size
 
 Set the size of your desired canvas by adjusting the constants on lines 19 and 20.
 */
let preferredWidth = 1200
let preferredHeight = 1500
/*:
 ## Required code
 
 Lines 28 to 36 are required to make the playground run.
 
 Please do not remove.
 */
import Cocoa
import PlaygroundSupport
import CanvasGraphics

// Create canvas
let canvas = Canvas(width: preferredWidth, height: preferredHeight)

// Create a turtle that will draw upon the canvas
let turtle = Tortoise(drawingUpon: canvas)

// Create a pen to draw on the canvas
let p = Pen(drawingUpon: canvas)

// Show the canvas in the playground's live view
PlaygroundPage.current.liveView = canvas
/*:
 ## Add your code
 
 Beginning on line 48, write a meaningful comment.
 
 You can remove the code on line 49 and begin writing your own code.
 
 [Documentation](http://russellgordon.ca/CanvasGraphics/Documentation/) is available.

 */
// High-performance
canvas.highPerformance = true

//Move origin to middle
canvas.translate(to: Point(x: canvas.width / 2,
                           y: canvas.height / 2))

//Draw a grid
canvas.drawAxes(withScale: true,
                by: 20,
                color: Color.black)
func goToOrigin() {
    p.goto(dx: Double(p.currentPosition().x) * -1.0, dy: Double(p.currentPosition().y) * -1.0)
}


p.goto(dx: 180, dy: -30)
p.addLine(distance: 40)
p.turn(degrees: 90)
p.addLine(distance: 130)
p.turn(degrees: 90)
p.addLine(distance: 40)
p.turn(degrees: 90)
p.addLine(distance: 130)
p.goto(dx: 80, dy: 0)
p.turn(degrees: 90)
p.addLine(distance: 40)
p.turn(degrees: 90)
p.addLine(distance: 130)
p.turn(degrees: 90)
p.addLine(distance: 40)
p.turn(degrees: 90)
p.addLine(distance: 130)

    
// Draw section 2
p.goto(dx: -260, dy: 30)
p.goto(dx: -20, dy: -40)
p.turn(degrees: 180)
p.addLine(distance: 140)
p.turn(degrees: 90)
p.addLine(distance: 80)
p.turn(degrees: 90)
p.addLine(distance: 140)
p.turn(degrees: 90)
p.addLine(distance: 80)
goToOrigin()
p.goto(dx: -20, dy: 80)
p.addLine(distance: -80)
p.goto(dx: 40, dy: 0)
p.turn(degrees: -90)
p.addLine(distance: 120)
goToOrigin()
p.goto(dx: -80, dy: 100)
p.addLine(distance: 20)
p.goto(dx: 40, dy: 0)
p.addLine(distance: -20)
p.goto(dx: -20, dy: 0)
p.addLine(distance: 20)

p.goto(dx: -100, dy: -120)
p.turn(degrees: 180)
p.addLine(distance: 140)
p.turn(degrees: 90)
p.addLine(distance: 80)
p.turn(degrees: 90)
p.addLine(distance: 140)
p.turn(degrees: 90)
p.addLine(distance: 80)
goToOrigin()
p.goto(dx: -160, dy: 80)
p.addLine(distance: -80)
p.goto(dx: 40, dy: 0)
p.turn(degrees: -90)
p.addLine(distance: 120)
goToOrigin()
p.goto(dx: -220, dy: 100)
p.addLine(distance: 20)
p.goto(dx: 40, dy: 0)
p.addLine(distance: -20)
p.goto(dx: -20, dy: 0)
p.addLine(distance: 20)

p.goto(dx: -100, dy: -120)
p.turn(degrees: 180)
p.addLine(distance: 140)
p.turn(degrees: 90)
p.addLine(distance: 80)
p.turn(degrees: 90)
p.addLine(distance: 140)
p.turn(degrees: 90)
p.addLine(distance: 80)
goToOrigin()
p.goto(dx: -300, dy: 80)
p.addLine(distance: -80)
p.goto(dx: 40, dy: 0)
p.turn(degrees: -90)
p.addLine(distance: 120)
goToOrigin()
p.goto(dx: -360, dy: 100)
p.addLine(distance: 20)
p.goto(dx: 40, dy: 0)
p.addLine(distance: -20)
p.goto(dx: -20, dy: 0)
p.addLine(distance: 20)


// Draw Section 3
goToOrigin()
p.goto(dx: 20, dy: -40)
p.turn(degrees: 90)
p.addLine(distance: 35)
p.turn(degrees: 90)
p.addLine(distance: 140)
p.turn(degrees: 90)
p.addLine(distance: 35)
p.turn(degrees: 90)
p.addLine(distance: 140)
p.goto(dx: 0, dy: 10)
p.turn(degrees: 90)

//Draw wood pillar next to door
for i in 1 ... 13 {
    p.addLine(distance: 35)
    p.goto(dx: -35, dy: 10)
}


goToOrigin()
p.goto(dx: 55, dy: -40)
p.addLine(distance: 65)
p.turn(degrees: 90)
p.addLine(distance: 92)
p.turn(degrees: 90)
p.addLine(distance: 65)
goToOrigin()
p.goto(dx: 85, dy: -40)
p.turn(degrees: 90)
p.addLine(distance: -90)


//Draw Roof Section 1
goToOrigin()
p.turn(degrees: 180)
p.goto(dx: 0, dy: 120)
p.turn(degrees: 90)
p.addLine(distance: 500)
goToOrigin()
p.goto(dx: 0, dy: 120)
p.turn(degrees: 285)
p.addLine(distance: 200)
p.turn(degrees: 75)
p.addLine(distance: 420)
goToOrigin()
p.goto(dx: -460, dy: -60)
p.turn(degrees: -90)
p.addLine(distance: 180)
p.goto(dx: 0, dy: -220)
p.turn(degrees: 270)
p.addLine(distance: 925)
goToOrigin()
p.goto(dx: -460, dy: -100)
p.turn(degrees: 90)
p.addLine(distance: 40)


//Draw Roof section 2
goToOrigin()
p.goto(dx: 0, dy: 125)
p.turn(degrees: -45)
p.addLine(distance: 420)
p.turn(degrees: -90)
p.addLine(distance: 240)
goToOrigin()
p.goto(dx: 0, dy: 120)
p.turn(degrees: 45)
p.addLine(distance: 500)


//Draw Tree
goToOrigin()
p.goto(dx: 360, dy: -100)
p.turn(degrees: 90)
p.addLine(distance: -100)
goToOrigin()
p.goto(dx: 360, dy: -100)
for i in 1 ... 8 {
    p.drawTo(dx: 0, dy: 10)
    p.drawTo(dx: -20, dy: -10)
    p.goto(dx: 40, dy: 0)
    p.drawTo(dx: -20, dy: 10)
}


//Draw the Sun
goToOrigin()
p.goto(dx: -300, dy: 460)
p.addArc(radius: 140, angle: 360)





// Where am I?
print(p.currentHeading)  // Direction
print(p.currentPosition()) // Location



// Turn off high-performance
canvas.highPerformance = false

// Copy to clipboard
canvas.copyToClipboard()

