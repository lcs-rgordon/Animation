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
//Where is the pen
print(p.currentHeading) //Direction
print(p.currentPosition()) //Location



//Tell the pen to actually draw the shape
//Drawing Outline, Starting from left corner

p.goto(dx: -220, dy: 0)
p.turn(degrees: 90)
p.addLine(distance: 80)
p.drawTo(dx: 80, dy: 100)
p.drawTo(dx: 80, dy: -100)
p.drawTo(dx: 0, dy: -70)
p.drawTo(dx: -60, dy: 0)
p.drawTo(dx: -20, dy: -10)
p.drawTo(dx: -80, dy: 0)
p.goto(dx: 40, dy: 130)
p.drawTo(dx: 40, dy: -50)
p.drawTo(dx: 0, dy: -80)
p.goto(dx: 20, dy: 10)
p.drawTo(dx: 0, dy: 80)
p.drawTo(dx: -20, dy: -10)
p.goto(dx: -40 , dy: 50 )
p.drawTo(dx: 20, dy: 10)
p.drawTo(dx: 40, dy: -50)

//Drawing the like backside of chapel

p.goto(dx: -20, dy: 90)
p.drawTo(dx: 20, dy: -10)
p.drawTo(dx: 70, dy: -50)

//Drawing the "hat"

p.drawTo(dx: 0, dy: 15)
p.drawTo(dx: -10, dy: 0)
p.drawTo(dx: 5, dy: 10)
p.drawTo(dx: 5, dy: -10)
p.goto(dx: -10, dy: 0)
p.drawTo(dx: 0, dy: -7)
p.goto(dx: 10, dy: -8)
p.drawTo(dx: 5, dy: 5)
p.drawTo(dx: 0, dy: 15)
p.drawTo(dx: -5, dy: -5)
p.goto(dx: -5, dy: 10)
p.drawTo(dx: 10, dy: -5)

//little roofs
print(p.currentHeading)
print(p.currentPosition())
(-45.0, 140.0)
p.goto(dx: 45.0, dy: -140.0)
print(p.currentHeading)
print(p.currentPosition())
p.goto(dx: -60, dy: 10)
p.drawTo(dx: 60, dy: 40)
p.drawTo(dx: 0, dy: 40)
p.drawTo(dx: -60, dy: -10)

//Little side roofs
p.goto(dx: 30, dy: 5)
p.drawTo(dx: 7, dy: 40)
p.drawTo(dx: 7, dy: -38)
p.drawTo(dx: 4, dy: 35)
p.drawTo(dx: 4, dy: -33)
p.drawTo(dx: 3, dy: 28)
p.drawTo(dx: 4, dy: -27)
print(p.currentHeading)
print(p.currentPosition())

(-1.0, 90.0)

p.goto(dx: 1.0, dy: -90.0)

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: -23, dy: 125)
p.drawTo(dx: -30, dy: -3)
p.drawTo(dx: 20, dy: -37)
p.goto(dx: 22, dy: 36)
p.drawTo(dx: -10, dy: -1)

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: 21.0, dy: -120.0)
p.goto(dx: -5, dy: 116)
p.drawTo(dx: -5, dy: -1)

//Door
print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: 10.0, dy: -115.0)
p.goto(dx: -70, dy: 10)
p.drawTo(dx: 0, dy: 35)
p.drawTo(dx: -20, dy: 0)
p.drawTo(dx: 0, dy: -35)

//Big Window

p.goto(dx: -110, dy: -10)
p.drawTo(dx: 0, dy: 80)
p.drawTo(dx: 20, dy: 20)
p.drawTo(dx: 20, dy: -20)
p.drawTo(dx: 0, dy: -80)

//Tree

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: 160.0, dy: 0.0)
print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: 40, dy: 40)

p.drawTo(dx: 0, dy: 40)
p.drawTo(dx: -40, dy: 0)
p.drawTo(dx: 40, dy: 40)
p.drawTo(dx: 40, dy: -40)
p.drawTo(dx: -40, dy: 0)

p.goto(dx: 0, dy: 40)
p.drawTo(dx: -30, dy: 0)
p.drawTo(dx: 30, dy: 30)
p.drawTo(dx: 30, dy: -30)
p.drawTo(dx: -30, dy: 0)

p.goto(dx: 0, dy: 30)
p.drawTo(dx: -20, dy: 0)
p.drawTo(dx: 20, dy: 20)
p.drawTo(dx: 20, dy: -20)
p.drawTo(dx: -20, dy: 0)


//Tree #2

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: -40.0, dy: -150.0)

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: 120, dy: 20)
p.drawTo(dx: 0, dy: 40)

p.drawTo(dx: -40, dy: 0)
p.drawTo(dx: 40, dy: 40)
p.drawTo(dx: 40, dy: -40)
p.drawTo(dx: -40, dy: 0)
p.goto(dx: 0, dy: 40)
p.drawTo(dx: -30, dy: 0)
p.drawTo(dx: 30, dy: 30)
p.drawTo(dx: 30, dy: -30)
p.drawTo(dx: -30, dy: 0)

p.goto(dx: 0, dy: 30)

p.drawTo(dx: -20, dy: 0)
p.drawTo(dx: 20, dy: 20)
p.drawTo(dx: 20, dy: -20)
p.drawTo(dx: -20, dy: 0)



print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: -120.0, dy: -130.0)
p.goto(dx: -280, dy: 60)

for i in 1 ... 8 {
p.drawTo(dx: 0, dy: 10)      // A bit more trunk
p.drawTo(dx: -20, dy: -10)   // Left branch
p.goto(dx: 40, dy: 0)       // Over to end of right branch
p.drawTo(dx: -20, dy: 10)    // Right branch
}

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: 280.0, dy: -140.0)

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: -280, dy: 20)
p.drawTo(dx: 0, dy: 40)

//Road lines

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: 280.0, dy: -60.0)

p.drawTo(dx: -30, dy: 30)
p.goto(dx: -190, dy: 0)
p.drawTo(dx: -120, dy: 0)

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: 340.0, dy: -30.0)
p.drawTo(dx: 100, dy: -60)
p.goto(dx: -440, dy: 20)
p.drawTo(dx: 240, dy: 0)
p.drawTo(dx: 40, dy: -20)
p.drawTo(dx: 40, dy: -40)
p.drawTo(dx: 20, dy: -40)

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: 0.0, dy: 140.0)

//Window lines

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: -180, dy: 0)

p.drawTo(dx: 0, dy: 100)
p.goto(dx: 20, dy: -20)
p.drawTo(dx: -40, dy: 0)
p.goto(dx: 0, dy: -20)
p.drawTo(dx: 40, dy: 0)
p.goto(dx: 0, dy: -20)
p.drawTo(dx: -40, dy: 0)
p.goto(dx: 0, dy: -20)
p.drawTo(dx: 40, dy: 0)

//Road lines contd
print(p.currentHeading)
print(p.currentPosition())
p.goto(dx: 160.0, dy: -20.0)

//were currently at 0,0
p.goto(dx: 100, dy: -60)
p.drawTo(dx: 80, dy: -40)
p.drawTo(dx: 160, dy: -20)

//Tree formed from messed up road line

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: -340.0, dy: 120.0)

p.goto(dx: 0, dy: -140)
p.drawTo(dx: -40, dy: 0)
p.drawTo(dx: 20, dy: 40)

p.goto(dx: 0, dy: -40)

p.drawTo(dx: -30, dy: -40)
p.drawTo(dx: 60, dy: 0)

p.drawTo(dx: -30, dy: 40)
p.goto(dx: 0, dy: -40)
p.drawTo(dx: -40, dy: -40)
p.drawTo(dx: 80, dy: 0)
p.drawTo(dx: -40, dy: 40)

p.goto(dx: 0, dy: -40)

p.drawTo(dx: 0, dy: -40)

//road contd, contd

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: 20.0, dy: 260.0)
p.goto(dx: -20, dy: -100)
p.drawTo(dx: 160, dy: -100)
p.drawTo(dx: 200, dy: -10)

//Attempt at Grass

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: -340.0, dy: 210.0)
p.goto(dx: -320, dy: -80)
for i in 1 ... 12 {
p.drawTo(dx: 0, dy: 10)
p.goto(dx: 10, dy: -10)
p.drawTo(dx: 0, dy: 20)
p.goto(dx: 10, dy: -20)

}

p.goto(dx: -240, dy: -40)



for i in 1 ... 14 {
p.drawTo(dx: 0, dy: 10)
p.goto(dx: 10, dy: -10)
p.drawTo(dx: 0, dy: 20)
p.goto(dx: 10, dy: -20)

}


//Tree in grassy area

p.goto(dx: -160, dy: -180)

for i in 1 ... 9 {
p.drawTo(dx: 0, dy: 10)      // A bit more trunk
p.drawTo(dx: -20, dy: -10)   // Left branch
p.goto(dx: 40, dy: 0)       // Over to end of right branch
p.drawTo(dx: -20, dy: 10)    // Right branch
}

p.goto(dx: 0, dy: -90)
p.drawTo(dx: 0, dy: -40)


p.goto(dx: 300, dy: -20)

for i in 1 ... 9 {
p.drawTo(dx: 0, dy: 10)      // A bit more trunk
p.drawTo(dx: -20, dy: -10)   // Left branch
p.goto(dx: 40, dy: 0)       // Over to end of right branch
p.drawTo(dx: -20, dy: 10)    // Right branch
}
p.goto(dx: 0, dy: -90)
p.drawTo(dx: 0, dy: -40)


p.goto(dx: 140, dy: 400)

for i in 1 ... 9 {
p.drawTo(dx: 0, dy: 10)      // A bit more trunk
p.drawTo(dx: -20, dy: -10)   // Left branch
p.goto(dx: 40, dy: 0)       // Over to end of right branch
p.drawTo(dx: -20, dy: 10)    // Right branch
}

p.goto(dx: 0, dy: -90)
p.drawTo(dx: 0, dy: -40)

//grass contd.

p.goto(dx: -80, dy: -40)

for i in 1 ... 8 {
p.drawTo(dx: 0, dy: 10)
p.goto(dx: 10, dy: -10)
p.drawTo(dx: 0, dy: 20)
p.goto(dx: 10, dy: -20)

}

p.goto(dx: -240, dy: 40)



for i in 1 ... 8 {
p.drawTo(dx: 0, dy: 10)
p.goto(dx: 10, dy: -10)
p.drawTo(dx: 0, dy: 20)
p.goto(dx: 10, dy: -20)

}

p.goto(dx: -140, dy: -200)

for i in 1 ... 11 {
p.drawTo(dx: 0, dy: 10)
p.goto(dx: 10, dy: -10)
p.drawTo(dx: 0, dy: 20)
p.goto(dx: 10, dy: -20)

}

// back to origin
p.goto(dx: -320, dy: 240)
p.turn(degrees: -90)

// Horizon

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: -360, dy: 200)

p.drawTo(dx: 720, dy: 0)

//sunset

p.goto(dx: -440, dy: 0)

p.turn(degrees: 90)
p.addArc(radius: 80, angle: -180)

// Adding more grass

print(p.currentHeading)
print(p.currentPosition())

p.goto(dx: -80.0, dy: -200.0)

p.goto(dx: -220, dy: -200)
for i in 1 ... 5 {
p.drawTo(dx: 0, dy: 10)
p.goto(dx: 10, dy: -10)
p.drawTo(dx: 0, dy: 20)
p.goto(dx: 10, dy: -20)

}

p.goto(dx: 80, dy: -140)

for i in 1 ... 5 {
p.drawTo(dx: 0, dy: 10)
p.goto(dx: 10, dy: -10)
p.drawTo(dx: 0, dy: 20)
p.goto(dx: 10, dy: -20)

}

p.goto(dx: -300, dy: -100)

for i in 1 ... 10 {
p.drawTo(dx: 0, dy: 10)
p.goto(dx: 10, dy: -10)
p.drawTo(dx: 0, dy: 20)
p.goto(dx: 10, dy: -20)

}

p.goto(dx: 230, dy: 80)

for i in 1 ... 5 {
p.drawTo(dx: 0, dy: 10)
p.goto(dx: 10, dy: -10)
p.drawTo(dx: 0, dy: 20)
p.goto(dx: 10, dy: -20)

}

// Turn off high-performance
canvas.highPerformance = false

// Copy to clipboard
canvas.copyToClipboard()

