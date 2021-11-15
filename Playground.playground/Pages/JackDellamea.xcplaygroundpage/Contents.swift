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
//creating variables
func LadderBase() {
    p.addLine(distance: 205)
    p.addArc(radius: 15, angle: 90)
    p.addLine(distance: 10)
    p.addArc(radius: 15, angle: 90)
    p.addLine(distance: 205)
}
func LadderCurvedRung() {
    p.addLine(distance: 10)
    p.addArc(radius: 10, angle: -90)
    p.addLine(distance: 20)
    p.addArc(radius: 10, angle: -90)
    p.addLine(distance: 10)
}
func SwingSide() {
p.addLine(distance: 120)
p.addArc(radius: 20, angle: -180)
p.addLine(distance: 120)
        }
func Swing() {
    p.addLine(distance: 105)
    p.addArc(radius: 20, angle: 180)
    p.addLine(distance: 110)
}
func Rung() {
    p.turn(degrees: 140)
    p.goto(dx: 0, dy: -40)
    p.addLine(distance: 30)
    p.addArc(radius: 7, angle: 130)
    p.addLine(distance: 25)
    p.addArc(radius: 7, angle: 130)
    p.addLine(distance: 27)
    p.turn(degrees: -40)
}
func SlideBody() {
    p.addLine(distance: 10)
    p.addArc(radius: 40, angle: 40)
    p.addLine(distance: 30)
    for i in 1 ... 2 {
        p.addArc(radius: 40, angle: -40)
        p.addArc(radius: 40, angle: 40)
        p.addLine(distance: 35)
    }
    p.addArc(radius: 40, angle: -40)
    p.addArc(radius: 10, angle: 180)
    p.addLine(distance: 30)
    p.addArc(radius: 10, angle: 180)
    p.addLine(distance: 5)
    p.addArc(radius: 5, angle: -90)
}




//--------------------------------------

//move Image into view
p.goto(dx: 60, dy: -200)

    //goto ladder#1
p.goto(dx: -160, dy: 160)

    //creating ladder#1 base
p.turn(degrees: 90)
LadderBase()
    //goto ladder#1 rungs
p.goto(dx: 0, dy: 20)
    //creating ladder#1 rungs
p.turn(degrees: 90)
for i in 1 ... 3 {
    p.addLine(distance: 40)
    p.addLine(distance: -40)
    p.turn(degrees: 90)
    p.addLine(distance: 60)
    p.turn(degrees: -90)
}
//goto ladder#1 tip
p.goto(dx: 20, dy: 20)
p.turn(degrees: 90)
//create ladder#1 tip
p.addLine(distance: 20)
//--------------------------------------

    //goto and re-orient 0,0
p.goto(dx: 180, dy: -420)

    //goto ladder#2
p.goto(dx: -80, dy: -60)
    //creating ladder#2 base
p.addLine(distance: 60)
LadderBase()
p.addLine(distance: 60)
    //goto ladder#2 rungs(right1)
p.goto(dx: 40, dy: 20)
    //creating ladder#2 rungs(right#1)
p.turn(degrees: -90)
LadderCurvedRung()
p.turn(degrees: 180)
    //goto ladder#2 rungs(right#2)
p.goto(dx: 0, dy: 120)
    //creating ladder#2 rungs(right#2)
LadderCurvedRung()
    //goto ladder#2 rungs(left)
p.goto(dx: -40, dy: -80)
    //creating ladder#2 rungs(left)
LadderCurvedRung()
    //goto ladder#2 tip
p.goto(dx: 20, dy: 180)
    //create ladder#2 tip
p.turn(degrees: -90)
p.addLine(distance: 20)
//--------------------------------------

    //goto and re-orient 0,0
p.goto(dx: 100, dy: -200)
p.turn(degrees: 0)

    //goto ladder#3
p.goto(dx: 80, dy: 80)
    //create ladder#3 base
p.addLine(distance: 20)
LadderBase()
p.addLine(distance: 20)
p.turn(degrees: -90)
    //goto ladder#3 rungs(right)
p.goto(dx: 40, dy: 80)
    //create ladder#3 rungs(right)
LadderCurvedRung()
    //goto ladder#3 rungs(left#1)
p.goto(dx: -40, dy: 60)
    //create ladder#3 rungs(left#1)
LadderCurvedRung()
p.turn(degrees: 180)
    //create ladder#3 rungs(left#2)
p.goto(dx: 0, dy: -80)
LadderCurvedRung()
p.turn(degrees: -90)
    //goto ladder#3 tip
p.goto(dx: 20, dy: 220)
    //create ladder#3 tip
p.addLine(distance: 40)
//--------------------------------------

    //goto and re-orient 0,0
p.goto(dx: -60, dy: -340)

    //goto ladder#4
p.goto(dx: 160, dy: 20)
    //create ladder#4 base
LadderBase()
p.turn(degrees: 180)
    //goto ladder#4 rungs
p.goto(dx: 40, dy: 20)
    //create ladder#4 rungs
for i in 1 ... 3 {
    p.turn(degrees: 90)
    p.addLine(distance: 40)
    p.addLine(distance: -40)
    p.turn(degrees: -90)
    p.addLine(distance: 60)
}
//add ladder#4 top
p.goto(dx: -20, dy: 20)
p.addLine(distance: 20)
//--------------------------------------

//goto and re-orient 0,0
p.goto(dx: -200, dy: -100)

    //goto ladder#1 point
p.goto(dx: -120, dy: 200)
    //draw bar 1-2
p.drawTo(dx: 80, dy: -180)
    //draw bar 2-3
p.drawTo(dx: 240, dy: 80)
    //draw bar 3-4
p.drawTo(dx: -80, dy: 80)
    //draw bar 4-1
p.drawTo(dx: -240, dy: 20)

    //--------------------------------------

    //goto and re-orient 0,0
p.goto(dx: 180, dy: -400)
    //goto swings
p.goto(dx: 140, dy: 300)
    //create swingside#1
SwingSide()
    //goto swingside#2
p.goto(dx: 120, dy: 20)
p.turn(degrees: 180)
    //create swingside#2
SwingSide()
    //goto top of swingside#1
p.goto(dx: -180, dy: 120)
    //draw connecter swing pole
p.drawTo(dx: 160, dy: 20)
    //goto swingchain#1
p.goto(dx: -120, dy: -15)
    //creating swing#1
Swing()
    //goto swing#2
p.goto(dx: 40, dy: 5)
p.turn(degrees: 180)
    //creating swing#2
Swing()
//--------------------------------------

//goto and reorient 0,0
p.goto(dx: -320, dy: -460)

//goto slideladder
p.goto(dx: -60, dy: 380)
//create slideladder
for i in 1 ... 4 {
p.addLine(distance: 20)
p.turn(degrees: 90)
p.addLine(distance: 40)
p.addLine(distance: -40)
p.turn(degrees: -90)
}
p.goto(dx: -40, dy: 0)
p.addLine(distance: -80)
p.goto(dx: 0, dy: 80)
    //creating slidebridge
p.turn(degrees: 65)
p.addLine(distance: 45)
    //creating slide
p.turn(degrees: 25)
SlideBody()
p.goto(dx: 222, dy: 134)
p.addLine(distance: -20)
p.addLine(distance: 20)
p.turn(degrees: 90)
SlideBody()
//--------------------------------------

//goto 0,0
p.goto(dx: 301, dy: -183)

print(p.currentPosition())
    //goto slidetop
p.goto(dx: -40, dy: 260)
    //creating slidetop#1
p.addLine(distance: 60)
p.addArc(radius: 20, angle: -180)
p.addLine(distance: 60)
    //creating slidetop#2
p.goto(dx: -80, dy: 58)
p.turn(degrees: 180)
p.addArc(radius: 20, angle: -180)
p.goto(dx: 40, dy: -581)
    //goto slidebars
p.goto(dx: 0, dy: 563)
p.turn(degrees: -100)
p.addLine(distance: 20)
p.turn(degrees: -80)
p.addLine(distance: 36)
p.addLine(distance: -80)
p.goto(dx: 5, dy: 0)
p.addLine(distance: 43)
p.goto(dx: 5, dy: -43)
p.addLine(distance: 42)
p.goto(dx: 5, dy: -42)
p.addLine(distance: 41)
p.goto(dx: -35, dy: 1)
p.turn(degrees: 70)
p.addLine(distance: 43)
p.turn(degrees: 110)
p.addLine(distance: 39)
p.turn(degrees: 180)
p.goto(dx: 5, dy: -1)
p.addLine(distance: 40)
for i in 1 ... 6 {
    p.goto(dx: 5, dy: -42)
    p.addLine(distance: 40)
}
//--------------------------------------

//goto and re-orient0,0
p.goto(dx: 44, dy: -303)

    //goto slide#3
p.goto(dx: -79, dy: 315)
    //create slide#3
p.turn(degrees: 90)
SlideBody()

//--------------------------------------


// Turn off high-performance
canvas.highPerformance = false

// Copy to clipboard
canvas.copyToClipboard()

