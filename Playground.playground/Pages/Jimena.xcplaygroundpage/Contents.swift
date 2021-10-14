//: [Previous](@previous) / [Next](@next)
/*:
## Canvas size
 
 Set the size of your desired canvas by adjusting the constants on lines 7 and 8.
 */
let preferredWidth = 600
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
let canvas = Canvas(width: preferredWidth, height: preferredHeight, quality: .Ultra)

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
canvas.translate(to: Point(x: canvas.width / 2,
                           y: canvas.height / 2))

// Show a grid
//canvas.drawAxes(withScale: true, by: 20, color: .black)

canvas.highPerformance = true
p.lineWidth = 3

/*:
 ## Add your code
 
 Beginning on line 61, you can add your own code.
  
 [Documentation](http://russellgordon.ca/CanvasGraphics/Documentation/) is available.

 */

// Begin writing your code below (you can remove the examples shown)

//Pen color
p.penColor = .black

//Main Frame
p.goto(dx: -280, dy: 200)
p.drawTo(dx: 0, dy: -400)
p.drawTo(dx: 560, dy: 0)
p.drawTo(dx: 0, dy: 400)
p.drawTo(dx: -560, dy: 0)

// Inclined Lines
p.goto(dx: 480, dy: -320)
p.drawTo(dx: 40, dy: -80)
p.drawTo(dx: -40, dy: 80)
p.drawTo(dx: 80, dy: 40)
p.drawTo(dx: -80, dy: -40)
p.drawTo(dx: -40, dy: -80)
p.drawTo(dx: 40, dy: 80)
p.drawTo(dx: -280, dy: -80)
p.drawTo(dx: 280, dy: 80)
p.drawTo(dx: -480, dy: 320)
p.drawTo(dx: 480, dy: -320)
p.drawTo(dx: -220, dy: 320)
p.drawTo(dx: 220, dy: -320)
p.drawTo(dx: -20, dy: 320)
p.drawTo(dx: 20, dy: -320)
p.drawTo(dx: 80, dy: 220)
p.goto(dx: -420, dy: 100)
p.drawTo(dx: 0, dy: -400)

// Fill Big Rectangle
p.beginFill()
p.drawTo(dx: -140, dy: 0)
p.drawTo(dx: 0, dy: 400)
p.drawTo(dx: 140, dy: -93)
    p.drawTo(dx: 0, dy: -300)
p.endFill()

//Make lines Triangle 6 & 7
p.goto(dx: 15, dy: -5)
p.beginFill()
p.drawTo(dx: 0, dy: 292)
p.drawTo(dx: 30, dy: -18)
p.drawTo(dx:0, dy: -275)
p.drawTo(dx: -30, dy: 0)
p.endFill()

p.goto(dx: 10, dy: 292)
p.beginFill()
p.drawTo(dx: 0, dy: 105)
p.drawTo(dx: -25, dy: 0)
p.drawTo(dx: 0, dy: -90)
p.drawTo(dx: 25, dy: -15)
p.endFill()

p.goto(dx: 20, dy: -20)
p.beginFill()
p.drawTo(dx: 0, dy: 127)
p.drawTo(dx: 75, dy: 0)
p.drawTo(dx: 14, dy: -20)
p.drawTo(dx: -65, dy: 0)
p.drawTo(dx: 0, dy: -120)
p.endFill()

p.goto(dx: -10, dy: 5)
p.beginFill()
p.drawTo(dx: 0, dy:-265)
p.drawTo(dx: 25, dy: 7)
p.drawTo(dx: 0, dy: 244)
p.drawTo(dx: -22, dy: 13)
p.endFill()

p.goto(dx: 35, dy: -23)
p.beginFill()
p.drawTo(dx: 0, dy: -230)
p.drawTo(dx: 30, dy: 8)
p.drawTo(dx: 0, dy: 203)
p.drawTo(dx: -30, dy: 20)
p.endFill()

p.goto(dx: 40, dy: -29)
p.beginFill()
p.drawTo(dx: 0, dy: -190)
p.drawTo(dx: 25, dy: 6)
p.drawTo(dx: 0, dy: 170)
p.drawTo(dx: -25, dy: 16)
p.endFill()

p.goto(dx: 35, dy: -26)
p.beginFill()
p.drawTo(dx: 0, dy: -157)
p.drawTo(dx: 22, dy: 8)
p.drawTo(dx: 0, dy: 136)
p.drawTo(dx: -22, dy: 16)
p.endFill()

p.goto(dx: 33, dy: -24)
p.beginFill()
p.drawTo(dx: 0, dy: -127)
p.drawTo(dx: 17, dy: 6)
p.drawTo(dx: 0, dy: 111)
p.drawTo(dx: -17, dy: 12)
p.endFill()

p.goto(dx: 25, dy: -18)
p.beginFill()
p.drawTo(dx: 0, dy: -103)
p.drawTo(dx: 11, dy: 3)
p.drawTo(dx: 0, dy: 94)
p.drawTo(dx: -11, dy: 7)
p.endFill()

p.goto(dx: 20, dy: -16)
p.beginFill()
p.drawTo(dx: 0, dy: -83)
p.drawTo(dx: 11, dy: 3)
p.drawTo(dx: 0, dy: 76)
p.drawTo(dx: -11, dy: 7)
p.endFill()

p.goto(dx: 20, dy: -14)
p.beginFill()
p.drawTo(dx: 0, dy: -65)
p.drawTo(dx: 12, dy: 3)
p.drawTo(dx: 0, dy: 55)
p.endFill()

p.goto(dx: 7, dy: -7)
p.beginFill()
p.drawTo(dx: 0, dy: -44)
p.drawTo(dx: 8, dy: 3)
p.drawTo(dx: 0, dy: 36)
p.endFill()

p.goto(dx: 7, dy: -5)
p.beginFill()
p.drawTo(dx: 0, dy: -31)
p.drawTo(dx: 34, dy: 9)
p.endFill()


//Triangle 1
p.beginFill()
p.drawTo(dx: -20, dy: -42)
p.drawTo(dx: 42, dy: 0)
p.drawTo(dx: -20, dy: 40)
p.endFill()

p.goto(dx: 28, dy: -54)
p.beginFill()
p.drawTo(dx: 10, dy: -23)
p.drawTo(dx: -77, dy: 0)
p.drawTo(dx: 12, dy: 26)
p.drawTo(dx: 51, dy: 0)
p.endFill()


//Triangle 2

p.goto(dx: -3, dy: 14)
p.beginFill()
p.drawTo(dx: 20, dy: 0)
p.drawTo(dx: 0, dy: 60)
p.drawTo(dx: 30, dy: 14)
p.drawTo(dx: 0, dy: -100)
p.drawTo(dx: -37, dy: 0)
p.endFill()

// Triangle 8
p.goto(dx: -68, dy: 0)
p.beginFill()
p.drawTo(dx: -18, dy: 0)
p.drawTo(dx: 0, dy: 48)
p.drawTo(dx: 15, dy: 5)
p.drawTo(dx: 0, dy: -28)
p.drawTo(dx: 15, dy: 0)
p.endFill()

p.goto(dx: -16, dy: -36)
p.beginFill()
p.drawTo(dx: -32, dy: 0)
p.drawTo(dx: 0, dy: 53)
p.drawTo(dx: -15, dy: -3)
p.drawTo(dx: 0, dy: -52)
p.drawTo(dx: 44, dy: 0)
p.endFill()

p.goto(dx: -70, dy: 0)
p.beginFill()
p.drawTo(dx: 0, dy: 46)
p.drawTo(dx: 13, dy: 3)
p.drawTo(dx: 0, dy: -51)
p.endFill()

p.goto(dx: -38, dy: 0)
p.beginFill()
p.drawTo(dx: 0, dy: 40)
p.drawTo(dx: 13, dy: 3)
p.drawTo(dx: 0, dy: -42)
p.endFill()

p.goto(dx: -50, dy: 0)
p.beginFill()
p.drawTo(dx: 0, dy: 27)
p.drawTo(dx: 20, dy: 6)
p.drawTo(dx: 0, dy: -34)
p.endFill()

p.goto(dx: -62, dy: 0)
p.beginFill()
p.drawTo(dx: 0, dy: 17)
p.drawTo(dx: 24, dy: 7)
p.drawTo(dx: 0, dy: -22)
p.endFill()

p.goto(dx: -38, dy: 0)
p.beginFill()
p.drawTo(dx: 0, dy: 12)
p.drawTo(dx: -38, dy: -12)
p.drawTo(dx: 38, dy: 0)
p.endFill()

//Triangle 3
p.goto(dx: 275, dy: 102)
p.beginFill()
p.drawTo(dx: 0, dy: 45)
p.drawTo(dx: -20, dy: 0)
p.drawTo(dx: -22, dy: -66)
p.endFill()

p.goto(dx: 60, dy: 30)
p.beginFill()
p.drawTo(dx: 0, dy: 50)
p.drawTo(dx: -34, dy: 0)
p.drawTo(dx: 7, dy: 18)
p.drawTo(dx: 42, dy: 0)
p.drawTo(dx: 0, dy: -62)
p.endFill()

p.goto(dx: 0, dy: 73)
p.beginFill()
p.drawTo(dx: -37, dy: 0)
p.drawTo(dx: 4, dy: 14)
p.drawTo(dx: 33, dy: 0)
p.endFill()

p.goto(dx: 0, dy: 13)
p.beginFill()
p.drawTo(dx: -28, dy: 0)
p.drawTo(dx: 5, dy: 14)
p.drawTo(dx: 23, dy: 0)
p.endFill()

p.goto(dx: 0, dy: 14)
p.beginFill()
p.drawTo(dx: -18, dy: 0)
p.drawTo(dx:6 , dy: 16)
p.drawTo(dx: 12, dy: 0)
p.endFill()


//Triangle 4
p.goto(dx: -57, dy: -120)
p.beginFill()
p.drawTo(dx: -25, dy: 0)
p.drawTo(dx: -2, dy: 25)
p.drawTo(dx: 36, dy: 0)
p.endFill()

p.goto(dx: 5, dy: 14)
p.beginFill()
p.drawTo(dx: -42, dy: 0)
p.drawTo(dx: -1, dy: 14)
p.drawTo(dx: 47, dy: 0)
p.endFill()

p.goto(dx: 6, dy: 14)
p.beginFill()
p.drawTo(dx: -53, dy: 0)
p.drawTo(dx: -1, dy: 16)
p.drawTo(dx: 60, dy: 0)
p.endFill()

p.goto(dx: 5, dy: 14)
p.beginFill()
p.drawTo(dx: -65, dy: 0)
p.drawTo(dx: -1, dy: 16)
p.drawTo(dx: 73, dy: 0)
p.endFill()

p.goto(dx: 4, dy: 16)
p.beginFill()
p.drawTo(dx: -79, dy: 0)
p.drawTo(dx: -2, dy: 18)
p.drawTo(dx: 88, dy: 0)
p.endFill()

p.goto(dx: 5, dy: 20)
p.beginFill()
p.drawTo(dx: -94, dy: 0)
p.drawTo(dx: -2, dy: 26)
p.drawTo(dx: 96, dy: 0)
p.endFill()

p.goto(dx: 0, dy: 22)
p.beginFill()
p.drawTo(dx: -96, dy: 0)
p.drawTo(dx: -2, dy: 26)
p.drawTo(dx: 98, dy: 0)
p.endFill()

//Triangle 5
p.goto(dx: -85, dy: -236)
p.beginFill()
p.drawTo(dx: -39, dy: 0)
p.drawTo(dx: 43, dy: -64)
p.endFill()

p.goto(dx: -5, dy: 79)
p.beginFill()
p.drawTo(dx: -51, dy: 0)
p.drawTo(dx: -12, dy: 19)
p.drawTo(dx: 61, dy: 0)
p.endFill()

p.goto(dx: 0, dy: 13)
p.beginFill()
p.drawTo(dx: -68, dy: 0)
p.drawTo(dx: -12, dy: 17)
p.drawTo(dx: 78, dy: 0)
p.endFill()

p.goto(dx: 0, dy: 13)
p.beginFill()
p.drawTo(dx: -89, dy: 0)
p.drawTo(dx: -12, dy: 19)
p.drawTo(dx: 99, dy: 0)
p.endFill()

p.goto(dx: 0, dy: 13)
p.beginFill()
p.drawTo(dx: -108, dy: 0)
p.drawTo(dx: -12, dy: 17)
p.drawTo(dx: 118, dy: 0)
p.endFill()

p.goto(dx: 0, dy: 13)
p.beginFill()
p.drawTo(dx: -127, dy: 0)
p.drawTo(dx: -12, dy: 17)
p.drawTo(dx: 137, dy: 0)
p.endFill()

p.goto(dx: 0, dy: 22)
p.beginFill()
p.drawTo(dx: -152, dy: 0)
p.drawTo(dx: -15, dy: 25)
p.drawTo(dx: 164, dy: 0)
p.endFill()

p.goto(dx: 0, dy: 17)
p.beginFill()
p.drawTo(dx: -178, dy: 0)
p.drawTo(dx: -15, dy: 21)
p.drawTo(dx: 191, dy: 0)
p.endFill()

//Triangle 6
p.goto(dx: -20, dy: -246)
p.beginFill()
p.drawTo(dx: -18, dy: 0)
p.drawTo(dx: 0, dy: -22)
p.drawTo(dx: -13, dy: 9)
p.drawTo(dx: 0, dy: 24)
p.drawTo(dx: 19, dy: 0)
p.endFill()

p.goto(dx: -8, dy: 13)
p.beginFill()
p.drawTo(dx: -23, dy: 0)
p.drawTo(dx: 0, dy: -29)
p.drawTo(dx: -13, dy: 8)
p.drawTo(dx: 0, dy: 34)
p.drawTo(dx: 30, dy: 0)
p.endFill()

p.goto(dx:-10, dy: 16)
p.beginFill()
p.drawTo(dx: -36, dy: 0)
p.drawTo(dx: 0, dy: -38)
p.drawTo(dx: -18, dy: 11)
p.drawTo(dx: 0, dy: 42)
p.drawTo(dx: 43, dy: 0)
p.endFill()


p.goto(dx: -15, dy: 17)
p.beginFill()
p.drawTo(dx: -45, dy: 0)
p.drawTo(dx: 0, dy: -48)
p.drawTo(dx: -22, dy: 16)
p.drawTo(dx: 0, dy: 50)
p.drawTo(dx: 58, dy: 0)
p.endFill()

p.goto(dx: -17, dy: 24)
p.beginFill()
p.drawTo(dx: -58, dy: 0)
p.drawTo(dx: 0, dy: -63)
p.drawTo(dx: -25, dy: 18)
p.drawTo(dx: 0, dy: 67)
p.drawTo(dx: 68, dy: 0)
p.endFill()


canvas.highPerformance = false

p.goto(dx: -23, dy: 29)
p.beginFill()
p.drawTo(dx:-65 , dy: 0)
p.drawTo(dx: 0, dy: -84)
p.drawTo(dx: -22, dy: 16)
p.drawTo(dx: 0, dy: 90)
p.drawTo(dx: 71, dy: 0)
p.endFill()

canvas.copyToClipboard()



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
