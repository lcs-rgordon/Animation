//: [Previous](@previous) / [Next](@next)
/*:
## Canvas size
 
 Set the size of your desired canvas by adjusting the constants on lines 19 and 20.
 */
let preferredWidth = 1200
let preferredHeight = 900
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
// Draw Window
func drawWindow() {
    p.drawTo(dx: -30, dy: 0)
    p.drawTo(dx: 0, dy: -50)
    p.drawTo(dx: 30, dy: 0)
    p.drawTo(dx: 0, dy: 50)
}
// Roof
p.goto(dx: 200, dy: 200)
p.drawTo(dx: -300, dy: 0)
p.drawTo(dx: -20, dy: 10)
p.drawTo(dx: -200, dy: 0)
p.drawTo(dx: 60, dy: 200)
p.drawTo(dx: 400, dy: 0)
p.drawTo(dx: 60, dy: -210)

// Lower right overhang
p.drawTo(dx: 0, dy: -100)
p.goto(dx: 0, dy: -40)
p.drawTo(dx: -330, dy: 0)
p.drawTo(dx: 20, dy: 40)
p.drawTo(dx: 310, dy: 0)
p.drawTo(dx: 20, dy: -40)
p.drawTo(dx: -20, dy: 0)

// Bathroom wall
p.goto(dx: -300, dy: 40)
p.drawTo(dx: 0, dy: 100)
p.goto(dx: -20, dy: 10)
p.drawTo(dx: 0, dy: -130)
p.goto(dx: 0, dy: 20)
p.drawTo(dx: -200, dy: 0)
p.drawTo(dx: 0, dy: 110)
p.goto(dx: 160, dy: -20)
drawWindow()

// Top floor windows
p.goto(dx: 110, dy: -20)
drawWindow()
p.goto(dx: 50, dy: 0)
drawWindow()
p.goto(dx: 70, dy: 0)
drawWindow()
p.goto(dx: 50, dy: 0)
drawWindow()
p.goto(dx: 70, dy: 0)
drawWindow()

// Lower floor body
p.goto(dx: 10, dy: -110)
p.drawTo(dx: 0, dy: -140)
p.drawTo(dx: -520, dy: 0)
p.drawTo(dx: 0, dy: 180)

// Lower floor Windows
p.goto(dx: 510, dy: -180)
p.drawTo(dx: 0, dy: 120)
p.drawTo(dx: 10, dy: 20)
p.goto(dx: -40, dy: -10)
drawWindow()
p.goto(dx: -30, dy: 0)
drawWindow()
p.goto(dx: -70, dy: 0)
drawWindow()
p.goto(dx: -30, dy: 0)
drawWindow()
p.goto(dx: -70, dy: 0)
drawWindow()
p.goto(dx: -30, dy: 0)
drawWindow()
p.goto(dx: -100, dy: 0)
drawWindow()

// Lower floor drainage pipe
p.goto(dx: 60, dy: 0)
p.drawTo(dx: 0, dy: -100)
p.drawTo(dx: -20, dy: -30)
p.goto(dx: 20, dy: 130)
p.drawTo(dx: -5, dy: 10)
p.goto(dx: 115, dy: -140)

// Bushes
func drawBush(scaleFactor: Double) {
    p.drawTo(dx: 0 * scaleFactor, dy: 30 * scaleFactor)
    p.drawTo(dx: 10 * scaleFactor, dy: -5 * scaleFactor)
    p.goto(dx: -10 * scaleFactor, dy: 5 * scaleFactor)
    p.drawTo(dx: -10 * scaleFactor, dy: -5 * scaleFactor)
    p.goto(dx: 10 * scaleFactor, dy: 5 * scaleFactor)
    p.goto(dx: 0 * scaleFactor, dy: -10 * scaleFactor)
    p.drawTo(dx: 10 * scaleFactor, dy: -5 * scaleFactor)
    p.goto(dx: -10 * scaleFactor, dy: 5 * scaleFactor)
    p.drawTo(dx: -10 * scaleFactor, dy: -5 * scaleFactor)
    p.goto(dx: 10 * scaleFactor, dy: 5 * scaleFactor)
    p.goto(dx: -40 * scaleFactor, dy: -20 * scaleFactor)
}
for _ in 1 ... 8 {
    drawBush(scaleFactor: 1.0)
}
p.goto(dx: 480, dy: 0)
for _ in 1 ... 4 {
    drawBush(scaleFactor: 1.0)
}

// Draw tree
func drawTree(scaleFactor: Double) {
    
    p.drawTo(dx: 0 * scaleFactor, dy: 70 * scaleFactor)
    
    for _ in 1 ... 8 {
        
        p.drawTo(dx: 0 * scaleFactor, dy: 10 * scaleFactor)
        p.drawTo(dx: -20 * scaleFactor, dy: -10 * scaleFactor)
        p.goto(dx: 40 * scaleFactor, dy: 0 * scaleFactor)
        p.drawTo(dx: -20 * scaleFactor, dy: 10 * scaleFactor)
    }
    
}

// Backround right
p.goto(dx: 340, dy: 0)
drawTree(scaleFactor: 2.5)
p.goto(dx: -60, dy: -375)
drawTree(scaleFactor: 1.5)
p.goto(dx: 120, dy: -225)
drawTree(scaleFactor: 1.5)

// backround left
p.goto(dx: -860, dy: -225)
drawTree(scaleFactor: 2.5)
p.goto(dx: -60, dy: -375)
drawTree(scaleFactor: 1.5)
p.goto(dx: 120, dy: -225)
drawTree(scaleFactor: 1.5)
// Where am I?
print(p.currentHeading)
print(p.currentPosition())

// Turn off high-performance
canvas.highPerformance = false

// Copy to clipboard
canvas.copyToClipboard()

