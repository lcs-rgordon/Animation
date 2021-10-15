//: [Previous](@previous) / [Next](@next)
/*:
## Canvas size
 
 Set the size of your desired canvas by adjusting the constants on lines 7 and 8.
 */
let preferredWidth = 800
let preferredHeight = 900
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
canvas.highPerformance = true

// Show a grid
//canvas.drawAxes(withScale: true, by: 20, color: .black)

/*:
 ## Add your code
 
 Beginning on line 61, you can add your own code.
  
 [Documentation](http://russellgordon.ca/CanvasGraphics/Documentation/) is available.

 */
p.lineWidth = 7
p.penColor = .black



//circles
p.goto(dx: 0, dy: -300)
p.addArc(radius: 300, angle: 360)
p.goto(dx: 0, dy: 20)
p.addArc(radius: 280, angle: 360)
p.goto(dx: 0, dy: 18)
p.addArc(radius: 260, angle: 360)
p.goto(dx: 0, dy: 16)
p.addArc(radius: 240, angle: 360)
p.goto(dx: 0, dy: 14)
p.addArc(radius: 220, angle: 360)
p.goto(dx: 0, dy: 12)
p.addArc(radius: 200, angle: 360)
p.goto(dx: 0, dy: 10)
p.addArc(radius: 180, angle: 360)
p.goto(dx: 0, dy: 9)
p.addArc(radius: 160, angle: 360)
p.goto(dx: 0, dy: 8)
p.addArc(radius: 140, angle: 360)
p.goto(dx: 0, dy: 7)
p.addArc(radius: 120, angle: 360)
p.goto(dx: 0, dy: 6)
p.addArc(radius: 100, angle: 360)
p.goto(dx: 0, dy: 5)
p.addArc(radius: 80, angle: 360)
p.goto(dx: 0, dy: 4)
p.addArc(radius: 60, angle: 360)
p.goto(dx: 0, dy: 3)
p.addArc(radius: 40, angle: 360)
p.goto(dx: 0, dy: 2)
p.addArc(radius: 20, angle: 360)
p.goto(dx: 0, dy: 1)
p.addArc(radius: 10, angle: 360)
p.addArc(radius: 5, angle: 360)

//side lines
p.turn(degrees: 90)
p.goto(dx: 0, dy: 8)
p.addLine(distance: 500)
p.goto(dx: -70, dy: -10)
p.turn(degrees: -172)
p.addLine(distance: 494)
p.addLine(distance: -494)
p.goto(dx: -70, dy: -20)
p.turn(degrees: 8)
p.addLine(distance: 490)
p.addLine(distance: -490)
p.goto(dx: -70, dy: -40)
p.turn(degrees: 9)
p.addLine(distance: 480)
p.addLine(distance: -480)
p.goto(dx: -70, dy: -50)
p.turn(degrees: 11)
p.addLine(distance: 470)
p.addLine(distance: -470)
p.goto(dx: -50, dy: -70)
p.turn(degrees: 11)
p.addLine(distance: 460)
p.addLine(distance: -460)
p.goto(dx: -40, dy: -75)
p.turn(degrees: 10)
p.addLine(distance: 435)
p.addLine(distance: -435)
p.goto(dx: -10, dy: -100)
p.turn(degrees: 13)
p.addLine(distance: 400)
p.addLine(distance: -400)
p.goto(dx: 0, dy: -100)
p.turn(degrees: 15)
p.addLine(distance: 380)
p.addLine(distance: -380)
p.goto(dx: 20, dy: -100)
p.turn(degrees: 14)
p.addLine(distance: 370)
p.addLine(distance: -370)
p.goto(dx: 50, dy: -80)
p.turn(degrees: 15)
p.addLine(distance: 338)
p.addLine(distance: -338)
p.goto(dx: 60, dy: -60)
p.turn(degrees: 14)
p.addLine(distance: 320)
p.addLine(distance: -320)
p.goto(dx: 70, dy: -40)
p.turn(degrees: 15)
p.addLine(distance: 300)
p.addLine(distance: -300)
p.goto(dx: 80, dy: -20)
p.turn(degrees: 15)
p.addLine(distance: 280)
p.addLine(distance: -280)
p.goto(dx: 90, dy: 0)
p.turn(degrees: 20)
p.addLine(distance: 240)
p.addLine(distance: -235)
p.goto(dx: 100, dy: 20)
p.turn(degrees: 22)
p.addLine(distance: 255)
p.addLine(distance: -255)
p.goto(dx: 110, dy: 40)
p.turn(degrees: 25)
p.addLine(distance: 280)
p.addLine(distance: -280)
p.goto(dx: 80, dy: 60)
p.turn(degrees: 20)
p.addLine(distance: 350)
p.addLine(distance: -350)
p.goto(dx: 70, dy: 80)
p.turn(degrees: 16)
p.addLine(distance: 350)
p.addLine(distance: -350)
p.goto(dx: 40, dy: 90)
p.turn(degrees: 15)
p.addLine(distance: 400)
p.addLine(distance: -400)
p.goto(dx: 5, dy: 100)
p.turn(degrees: 13)
p.addLine(distance: 415)
p.addLine(distance: -415)
p.goto(dx: -5, dy: 120)
p.turn(degrees: 14)
p.addLine(distance: 455)
p.addLine(distance: -455)
p.goto(dx: -40, dy: 100)
p.turn(degrees: 12)
p.addLine(distance: 493)
p.addLine(distance: -493)
p.goto(dx: -80, dy: 50)
p.turn(degrees: 11)
p.addLine(distance: 480)
p.addLine(distance: -480)
p.goto(dx: -40, dy: 50)
p.turn(degrees: 7)
p.addLine(distance: 495)
p.addLine(distance: -495)
p.goto(dx: -50, dy: 20)
p.turn(degrees: 6)
p.addLine(distance: 495)
p.addLine(distance: -495)
p.goto(dx: -50, dy: 10)
p.turn(degrees: 6)
p.addLine(distance: 495)
p.addLine(distance: -495)
p.goto(dx: -40, dy: 10)
p.turn(degrees: 4)
p.addLine(distance: 495)
p.addLine(distance: -495)
p.goto(dx: -40, dy: 9)
p.turn(degrees: 5)
canvas.highPerformance = false
p.addLine(distance: 495)

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
