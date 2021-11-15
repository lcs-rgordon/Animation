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
//Where am I
print(p.currentHeading) //Direction
print(p.currentPosition())//Location

//Teach computer to go to 0,0
func goToOrigin() {
    p.goto(dx: Double(p.currentPosition().x) * -1.0, dy: Double(p.currentPosition().y) * -1.0)
}

//Teach computer to reset the pen heading
func resetHeading() {
    let remainder = p.currentHeading.remainder(dividingBy: 360.0)
    p.turn(degrees: remainder * -1)
}




//Tell computer how to draw square window
func drawBigSquare() {
    for i in 1 ... 4 {
        p.addLine(distance: 40)
        p.turn(degrees: 90)
    }
}

//Make Square Windows
p.turn(degrees: 180)
drawBigSquare()

p.goto(dx: -40, dy: 0)
drawBigSquare()
p.goto(dx: 0, dy: -40)
drawBigSquare()
p.goto(dx: 40, dy: 0)
drawBigSquare()

//Teach computer to make rectangle
func drawRectangle() {
    for i in 1 ... 2 {
        p.addLine(distance: 80)
        p.turn(degrees: 90)
        p.addLine(distance: 20)
        p.turn(degrees: 90)
    }
}

//Make rectangles
p.goto(dx: 0, dy: 70)
for i in 1 ... 4 {
    drawRectangle()
    p.goto(dx: 0, dy: 20)
}
p.goto(dx: 80, dy: -20)
for i in 1 ... 4 {
    drawRectangle()
    p.goto(dx: 0, dy: -20)
}

//Teach computer to make small squares
func drawSmallSquare() {
    for i in 1 ... 4 {
        p.addLine(distance: 20)
        p.turn(degrees: 90)
    }
}

p.turn(degrees: -4500)

//Make small squares
p.goto(dx: -180, dy: 0)
for i in 1 ... 4 {
    drawSmallSquare()
    p.goto(dx: 0, dy: 20)
}

//Make window top
goToOrigin()
for i in 1 ... 2 {
    p.turn(degrees: 90)
    p.addLine(distance: 10)
    p.turn(degrees: 90)
    p.addLine(distance: 80)
}
p.goto(dx: -40, dy: 0)
p.turn(degrees: 90)
p.addLine(distance: 10)
goToOrigin()

//Make side
p.goto(dx: 80, dy: 90)
print(p.currentPosition())
resetHeading()
p.addLine(distance: 50)
p.turn(degrees: -90)
p.addLine(distance: 170)
p.turn(degrees: -90)
p.addLine(distance: 130)
p.goto(dx: 130, dy: 90)
p.addLine(distance: 50)
goToOrigin()


//Teach computer to make bricks
p.turn(degrees: 180)
p.goto(dx: 0, dy: 10)
for i in 1 ... 7 {
    for i in 1 ... 13 {
        for i in 1 ... 2 {
            p.addLine(distance: 10)
            p.turn(degrees: -90)
            p.addLine(distance: 4)
            p.turn(degrees: -90)
        }
        p.goto(dx: 10, dy: 0)
    }
    p.goto(dx: -1, dy: -9)
    p.turn(degrees: 180)
    for i in 1 ... 7 {
        for i in 1 ... 2 {
            p.addLine(distance: 7)
            p.turn(degrees: -90)
            p.addLine(distance: 4)
            p.turn(degrees: -90)
        }
        p.goto(dx: -7, dy: 0)
        for i in 1 ... 2 {
            p.addLine(distance: 10)
            p.turn(degrees: -90)
            p.addLine(distance: 4)
            p.turn(degrees: -90)
        }
        p.goto(dx: -10, dy: 0)
    }
    p.drawTo(dx: -10, dy: 0)
    p.goto(dx: 0, dy: -4)
    p.turn(degrees: 180)
}
goToOrigin()
resetHeading()

//Fill out sides
p.goto(dx: -100, dy: 10)
p.drawTo(dx: 0, dy: -90)
p.addLine(distance: 20)
p.goto(dx: 0, dy: 50)
p.turn(degrees: 180)
p.addLine(distance: 20)

//Add Sloped Roof
p.goto(dx: -30, dy: 120)
p.turn(degrees: -180)
p.drawTo(dx: 290, dy: 0)
p.drawTo(dx: -30, dy: 100)
p.drawTo(dx: -230, dy: 0)
p.drawTo(dx: -30, dy: -100)

//Add Sloped Roof Details
p.goto(dx: 25, dy: 0)
for i in 1 ... 2 {
    p.drawTo(dx: 25, dy: 100)
    p.goto(dx: 25, dy: 0)
    p.drawTo(dx: -25, dy: -100)
    p.goto(dx: 25, dy: 0)
}
p.goto(dx: 10, dy: 100)
p.drawTo(dx: -10, dy: -100)
p.goto(dx: 20, dy: 100)
p.drawTo(dx: 10, dy: -100)

p.goto(dx: 30, dy: 0)
for i in 1 ... 2 {
    p.drawTo(dx: -25, dy: 100)
    p.goto(dx: 25, dy: 0)
    p.drawTo(dx: 25, dy: -100)
    p.goto(dx: 25, dy: 0)
}

//Add ground details
goToOrigin()
p.goto(dx: 0, dy: -160)
p.turn (degrees: 90)



//Tidy up the pen
goToOrigin()
resetHeading()
//Where is the pen
print(p.currentHeading)
print(p.currentPosition())


// Turn off high-performance
canvas.highPerformance = false

// Copy to clipboard
canvas.copyToClipboard()

