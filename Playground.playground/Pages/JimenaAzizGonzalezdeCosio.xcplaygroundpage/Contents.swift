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
// Where am I?
print(p.currentHeading)   // Direction
print(p.currentPosition())  // Location

    // Main House structure
p.goto(dx: -200, dy: 60)
p.turn(degrees: -90)
p.addLine(distance: 180)
p.turn(degrees:90)
p.addLine(distance: 400)
p.turn(degrees: 90)
p.addLine(distance: 180)
p.turn(degrees: 42)
p.addLine(distance: 165)
p.turn(degrees: -42)
p.addLine(distance: 10)
p.turn(degrees: -138)
p.addLine(distance: 165)
p.turn(degrees: -42)
p.addLine(distance: 10)

    // Turn pen upright
p.turn(degrees: -228)


// Where am I?
print(p.currentHeading)   // Direction
print(p.currentPosition())  // Location

    // Go back to origin
goToOrigin()

    //Chimney
p.goto(dx: 120, dy: -120)
p.turn(degrees: 48)
p.addLine(distance: 80)
p.turn(degrees: 15)
p.addLine(distance: 120)
p.turn(degrees: -15)
p.addLine(distance: 200)
p.turn(degrees: 90)
p.addLine(distance: 40)
p.turn(degrees: 90)
p.addLine(distance: 200)
p.turn(degrees: -15)
p.addLine(distance: 120)
p.turn(degrees: 15)
p.addLine(distance: 80)
p.turn(degrees: 180)

    // Where am I?
print(p.currentHeading)   // Direction
print(p.currentPosition())  // Location

    //Go back to origin
goToOrigin()

    //Rest of the roof
p.goto(dx:48, dy: 210)
p.turn(degrees: 45)
p.addLine(distance: 80)
p.turn(degrees: 90)
p.addLine(distance: 273)
p.turn(degrees: -135)
p.addLine(distance: 10)
p.turn(degrees: -45)
p.addLine(distance: 273)
p.turn(degrees: -90)
p.addLine(distance: 80)
p.turn(degrees: 135)

goToOrigin()

    //Fix roof
p.goto(dx: -200, dy: 60)
p.addLine(distance: 13)


//Move pen To 0,0
goToOrigin()


// Twin windows Function

func twinwindows() {
    p.addLine(distance: 80)
    p.turn(degrees: 90)
    p.addLine(distance: 40)
    p.turn(degrees: 90)
    p.addLine(distance: 80)
    p.turn(degrees: 90)
    p.addLine(distance:40)
    p.turn(degrees: -270)
    
    p.goto(dx: 5, dy:0)
    
    p.addLine(distance: 90)
    p.turn(degrees: 90)
    p.addLine(distance: 50)
    p.turn(degrees: 90)
    p.addLine(distance: 90)
    p.turn(degrees: 90)
    p.addLine(distance: 50)
}
       
    


//Draw twin windows
twinwindows()
goToOrigin()
p.goto(dx: 160, dy: 0)
p.turn(degrees: -270)
twinwindows()


//Func goToOrigin
func goToOrigin() {
    p.goto(dx: Double(p.currentPosition().x) * -1.0, dy: Double(p.currentPosition().y) * -1.0)
}
goToOrigin()


    //Draw fencing on the right
p.goto(dx: 200, dy: -120)
p.addLine(distance: 50)
p.turn(degrees: 90)
p.addLine(distance: 80)
p.turn(degrees: 90)
p.addLine(distance: 50)

goToOrigin()
p.goto(dx: 220, dy: -120)
p.turn(degrees: 270)
p.addLine(distance: 80)
p.goto(dx: 20, dy: 0)
p.turn(degrees: 180)
p.addLine(distance: 80)

goToOrigin()
p.goto(dx: 240, dy: -120)
p.addLine(distance: 40)
p.turn(degrees: 90)
p.addLine(distance: 60)
p.turn(degrees: 90)
p.addLine(distance: 40)
p.turn(degrees: -90)
p.drawTo(dx:160, dy: 0)
p.drawTo(dx: 0, dy: 80)
p.drawTo(dx: -160, dy: 0)
p.drawTo(dx: 0, dy: -80)
p.drawTo(dx: -10, dy: 0)
p.drawTo(dx: 0, dy: 80)
p.drawTo(dx: 10, dy: 0)
p.drawTo(dx: 20, dy: 0)

func DrawFence() {
    p.drawTo(dx: 0, dy: -80)
    p.drawTo(dx: 20, dy: 0)
    p.drawTo(dx: 0, dy: 80)
    p.drawTo(dx: 20, dy: 0)
}

for i in 1 ... 4 {
    DrawFence()
}


goToOrigin()
p.goto(dx: 220, dy: -120)
p.drawTo(dx: 80, dy: 0)
p.drawTo(dx: 0, dy: -20)
p.drawTo(dx: -60, dy: 0)



    //Rest of roof
goToOrigin()
p.goto(dx: -180, dy: 105)
p.drawTo(dx: 0, dy: 40)
p.drawTo(dx: -10, dy: 10)
p.drawTo(dx: 60, dy: 0)
p.drawTo(dx: 10, dy: 10)
p.drawTo(dx: -70, dy: 0)
p.drawTo(dx: 0, dy: -10)

goToOrigin()
p.goto(dx: 170, dy: 105)
p.drawTo(dx: 0, dy: 30)
p.drawTo(dx: 20, dy: 20)
p.drawTo(dx: 0, dy: 20)
p.drawTo(dx: -85, dy: 0)
p.drawTo(dx: 85, dy: 0)
p.drawTo(dx: 0, dy: -10)
p.drawTo(dx: -77, dy: 0)

    //Secondary House
goToOrigin()
p.goto(dx:-200, dy: -140)
p.drawTo(dx: 0, dy: 140)
p.drawTo(dx: -80, dy: 80)
p.drawTo(dx: -80, dy: -80)
p.drawTo(dx: 0, dy: -140)
p.drawTo(dx: 40, dy: 0)
p.drawTo(dx: 0, dy: -20)
p.drawTo(dx: 0, dy: 160)
p.drawTo(dx: -40, dy: 0)
p.drawTo(dx: 160, dy: 0)

goToOrigin()
p.goto(dx: -320, dy: -160)
p.drawTo(dx: 120, dy: 0)
p.drawTo(dx: 0, dy: 20)

p.goto(dx: -20, dy: -20)
p.drawTo(dx: 0, dy: 40)
p.drawTo(dx:-60, dy: 0)
p.drawTo(dx: 0, dy: -40)

p.goto(dx: -70, dy: 20)
p.drawTo(dx: 0, dy: 140)


    //Secondary House Window
goToOrigin()
p.goto(dx: -300, dy: -100)
p.drawTo(dx: 0, dy: 80)
p.drawTo(dx: 80, dy: 0)
p.drawTo(dx: 0, dy: -80)
p.drawTo(dx: -80, dy: 0)

p.goto(dx: 5, dy: 0)
p.drawTo(dx: 0, dy: 80)
p.goto(dx: -5, dy: -5)
p.drawTo(dx: 80, dy: 0)
p.goto(dx: -5, dy: 5)
p.drawTo(dx: 0, dy: -80)
p.goto(dx: 5, dy: 5)
p.drawTo(dx: -80, dy: 0)

p.goto(dx: 37, dy: -5)
p.drawTo(dx: 0, dy: 80)
p.goto(dx: 5, dy: 0)
p.drawTo(dx: 0, dy: -80)


    //Main House Door
goToOrigin()
p.goto(dx: -60, dy: -120)
p.drawTo(dx: 0, dy: 220)
p.drawTo(dx: -80, dy: 0)
p.drawTo(dx: 0, dy: -220)

p.goto(dx: 0, dy: 5)
p.drawTo(dx: 80, dy: 0)
p.goto(dx: -5, dy: 0)
p.drawTo(dx: 0, dy: 215)
p.goto(dx: 0, dy: -5)
p.drawTo(dx: -75, dy: 0)
p.goto(dx: 5, dy: 0)
p.drawTo(dx: 0, dy: -210)

    //Main House Door Window
goToOrigin()
p.goto(dx: -80, dy: 0)
p.drawTo(dx: -40, dy: 0)
p.drawTo(dx: 0, dy: 80)
p.drawTo(dx: 40, dy: 0)
p.drawTo(dx: 0, dy: -80)
p.drawTo(dx: 0, dy: 20)
p.drawTo(dx: -40, dy: 0)
p.drawTo(dx: 0, dy: 20)
p.drawTo(dx: 40, dy: 0)
p.drawTo(dx: 0, dy: 20)
p.drawTo(dx: -40, dy: 0)
p.goto(dx: 40, dy: -40)
p.drawTo(dx: 0, dy: 20)
goToOrigin()
p.goto(dx: -110, dy: 0)
p.drawTo(dx: 0, dy: 80)
p.goto(dx: 10, dy: 0)
p.drawTo(dx: 0, dy: -80)
p.goto(dx: 10, dy: 0)
p.drawTo(dx: 0, dy: 80)

//Main House Big window
goToOrigin()
p.goto(dx: 30, dy: 130)
p.drawTo(dx: -80, dy: 0)
p.drawTo(dx: 0, dy: 60)
p.drawTo(dx: 80, dy: 0)
p.drawTo(dx: 0, dy: -60)
p.goto(dx: 0, dy: 5)
p.drawTo(dx: -80, dy: 0)
p.goto(dx: 5, dy: 0)
p.drawTo(dx: 0, dy: 55)
p.goto(dx: 0, dy: -5)
p.drawTo(dx: 75, dy: 0)
p.goto(dx: -5, dy: 0)
p.drawTo(dx: 0, dy: -50)
p.goto(dx: -50, dy: 0)
p.drawTo(dx: 0, dy: 50)
p.goto(dx: 5, dy: 0)
p.drawTo(dx: 0, dy: -50)
p.goto(dx: 20, dy: 0)
p.drawTo(dx: 0, dy: 50)
p.goto(dx: 5, dy: 0)
p.drawTo(dx: 0, dy: -50)

    
goToOrigin()
//Tree Func
func tree() {
    p.drawTo(dx: 0, dy: 60)
    p.drawTo(dx: -40, dy: 30)
    p.drawTo(dx: 40, dy: -30)
    p.drawTo(dx: 50, dy: 35)
    p.drawTo(dx: -20, dy: -15)
    p.drawTo(dx: -15, dy: 10)
    p.drawTo(dx: 15, dy: -10)
    p.drawTo(dx: 18, dy: -5)
    p.goto(dx: -60, dy: 0)
    p.drawTo(dx: -25, dy: -9)
}

//Trees
goToOrigin()
p.goto(dx: 250, dy: 200)
tree()

goToOrigin()
p.goto(dx: -200, dy: 300)
tree()

goToOrigin()
p.goto(dx: 120, dy: -350)
tree()

//Grass Func
func grass() {
    p.drawTo(dx: 0, dy: 80)
    p.goto(dx: 3, dy: -80)
    p.drawTo(dx: 0, dy: 60)
    p.goto(dx: 3, dy: -60)
    p.drawTo(dx: 0, dy: 90)
    p.goto(dx: 3, dy: -90)
    p.drawTo(dx: 0, dy: 70)
    p.goto(dx: 3, dy: -70)
    p.drawTo(dx: 0, dy: 85)
    p.drawTo(dx: 3, dy: -85)
}

//Grass
goToOrigin()
p.goto(dx: -470, dy: -420)
for i in 1 ... 70 {
    grass()
    
}
goToOrigin()
p.goto(dx: -470, dy: -480)
for i in 1 ... 70 {
    grass()
}

goToOrigin()
p.goto(dx: -470, dy: -540)
for i in 1 ... 70 {
    grass()
}

goToOrigin()
p.goto(dx: -470, dy: -600)
for i in 1 ... 70 {
    grass()
}

//Moon
goToOrigin()
p.goto(dx: -345, dy: 415)
p.addArc(radius: 55, angle: 360)
p.goto(dx: 25, dy: 75)
p.addArc(radius: 5, angle: 360)
p.goto(dx: 5, dy: -8)
p.addArc(radius: 2, angle: 360)
p.goto(dx: -22, dy: -5)
p.addArc(radius: 9, angle: 360)

goToOrigin()
p.goto(dx: -280, dy: 425)

//Big Star Func
func bigstar() {
    p.drawTo(dx: 30, dy: 0)
    p.goto(dx: -15, dy: 0)
    p.drawTo(dx: 0, dy: 20)
    p.goto(dx: 0, dy: -20)
    p.drawTo(dx: 0, dy: -20)
    p.goto(dx: 0, dy: 20)
    p.drawTo(dx: 8, dy: 8)
    p.goto(dx: -8, dy: -8)
    p.drawTo(dx: -8, dy: 8)
    p.goto(dx: 8, dy: -8)
    p.drawTo(dx: -8, dy: -8)
    p.goto(dx: 8, dy: 8)
    p.drawTo(dx: 8, dy: -8)
    p.goto(dx: -8, dy: 8)
}


// Small Star Func
func smallstar() {
    p.drawTo(dx: 20, dy: 0)
    p.goto(dx: -10, dy: 0)
    p.drawTo(dx: 0, dy: 10)
    p.goto(dx: 0, dy: -10)
    p.drawTo(dx: 0, dy: -15)
    p.goto(dx: 0, dy: 15)
    p.drawTo(dx: 4, dy: 4)
    p.goto(dx: -4, dy: -4)
    p.drawTo(dx: -4, dy: 4)
    p.goto(dx: 4, dy: -4)
    p.drawTo(dx: -4, dy: -4)
    p.goto(dx: 4, dy: 4)
    p.drawTo(dx: 4, dy: -4)
    p.goto(dx: -4, dy: 4)
}

//Stars
goToOrigin()
p.goto(dx: 300, dy: 430)
bigstar()
p.goto(dx: -40, dy: 15)
smallstar()
p.goto(dx: -83, dy: -22)
bigstar()
p.goto(dx: -120, dy: 50)
bigstar()
p.goto(dx: 60, dy: 30)
smallstar()
p.goto(dx: 100, dy: 40)
bigstar()
p.goto(dx: 70, dy:-80)
smallstar()
p.goto(dx: 45, dy: -42)
smallstar()
p.goto(dx: -400, dy: 0)
bigstar()
p.goto(dx: -30, dy: 50)
smallstar()
p.goto(dx: 100, dy: 90)
smallstar()
p.goto(dx: -200, dy: -70)
bigstar()
p.goto(dx: -50, dy: 60)
smallstar()
p.goto(dx: -200, dy: 20)
smallstar()
p.goto(dx: 50, dy:40)
bigstar()
p.goto(dx: 35, dy: 25)
smallstar()
p.goto(dx: -200, dy: 40)
bigstar()
p.goto(dx: 20, dy: 20)
smallstar()
p.goto(dx: -200, dy: -100)
bigstar()
goToOrigin()
p.goto(dx: -400, dy: 385)
bigstar()
p.goto(dx: 100, dy: 70)
bigstar()
p.goto(dx: 60, dy: 40)
smallstar()
p.goto(dx: 70, dy: -50)
smallstar()

//Brick effect
goToOrigin()
p.goto(dx: 20, dy: -100)
p.drawTo(dx: 100, dy: 0)
p.goto(dx: 0, dy: 20)
p.drawTo(dx: -100, dy: 0)
p.goto(dx: 0, dy: 20)
p.drawTo(dx: 100, dy: 0)
p.goto(dx: 0, dy: 20)
p.drawTo(dx: -100, dy: 0)
p.goto(dx: 5, dy: 20)
p.drawTo(dx: 90, dy: 0)
p.goto(dx: -5, dy: 20)
p.drawTo(dx: -80, dy: 0)
p.goto(dx: 3, dy: 20)
p.drawTo(dx: 70, dy: 0)
p.goto(dx: -3, dy: 20)
p.drawTo(dx: -60, dy: 0)
p.goto(dx: 2, dy: 20)
p.drawTo(dx: 50, dy: 0)
p.goto(dx: -3, dy: 20)
for i in 1 ... 5 {
    p.drawTo(dx: -40, dy: 0)
    p.goto(dx: 0, dy: 20)
    p.drawTo(dx: 40, dy: 0)
    p.goto(dx: 0, dy: 20)
    
}

p.goto(dx: -30, dy: 0)
for i in 1 ... 10 {
    p.drawTo(dx: 0, dy: -20)
    p.goto(dx: 0, dy: -20)
}

p.goto(dx: 10, dy: 380)
for i in 1 ... 10 {
    p.drawTo(dx: 0, dy: -20)
    p.goto(dx: 0, dy: -20)
}

p.goto(dx: 10, dy: 420)
for i in 1 ... 10 {
    p.drawTo(dx: 0, dy: -20)
    p.goto(dx: 0, dy: -20)
}

p.goto(dx: -40, dy: 0)
for i in 1 ... 4 {
    p.drawTo(dx: 0, dy: 20)
    p.goto(dx: 0, dy: 20)
}

p.goto(dx: 60, dy: -160)
for i in 1 ... 4 {
    p.drawTo(dx: 0, dy: 20)
    p.goto(dx: 0, dy: 20)
}


// Turn off high-performance
canvas.highPerformance = false

// Copy to clipboard
canvas.copyToClipboard()

