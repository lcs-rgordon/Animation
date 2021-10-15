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

/*:
 ## Add your code
 
 Beginning on line 61, you can add your own code.
  
 [Documentation](http://russellgordon.ca/CanvasGraphics/Documentation/) is available.

 */

// Begin writing your code below (you can remove the examples shown)
//Define a list of verticles
var triangle: [Point] = []
triangle.append (Point (x: 120, y: 200)) //A
triangle.append (Point (x: 140, y: 180)) //A
triangle.append (Point (x: 0, y: 20)) //A

//Draw triangle
canvas .drawCustomShape(with: triangle)

var triangleB: [Point] = []
triangleB.append (Point (x: 160, y: 160)) //B
triangleB.append (Point (x: 180, y: 140)) //B
triangleB.append (Point (x: 0, y: 20)) //B

canvas.drawCustomShape(with: triangleB)

var triangleC: [Point] = []
triangleC.append (Point (x: 200, y: 120)) //C
triangleC.append (Point (x: 220, y: 100)) //C
triangleC.append (Point (x: 0, y: 20)) //C

canvas.drawCustomShape(with: triangleC)

var triangleD: [Point] = []
triangleD.append (Point (x: 220, y: 70)) //D
triangleD.append (Point (x: 240, y: 50)) //D
triangleD.append (Point (x: 0, y: 20)) //D

canvas.drawCustomShape(with: triangleD)

var triangleE: [Point] = []
triangleE.append (Point (x: 220, y: 30)) //E
triangleE.append (Point (x: 240, y: 10)) //E
triangleE.append (Point (x: 0, y: 20)) //E

canvas.drawCustomShape(with: triangleE)

var triangleF: [Point] = []
triangleF.append (Point (x: 210, y: -10)) //F
triangleF.append (Point (x: 230, y: -30)) //F
triangleF.append (Point (x: 0, y: 20)) //F

canvas.drawCustomShape(with: triangleF)

var triangleG: [Point] = []
triangleG.append (Point (x: 180, y: -50)) //G
triangleG.append (Point (x: 200, y: -80)) //G
triangleG.append (Point (x: 0, y: 20)) //G

canvas.drawCustomShape(with: triangleG)

var triangleH: [Point] = []
triangleH.append (Point (x: 130, y: -80)) //H
triangleH.append (Point (x: 150, y: -130)) //H
triangleH.append (Point (x: 0, y: 20)) //H

canvas.drawCustomShape(with: triangleH)

var triangleI: [Point] = []
triangleI.append (Point (x: 100, y: -110)) //I
triangleI.append (Point (x: 110, y: -150)) //I
triangleI.append (Point (x: 0, y: 20)) //I

canvas.drawCustomShape(with: triangleI)


var triangleJ: [Point] = []
triangleJ.append (Point (x: 60 , y:-120 )) //J
triangleJ.append (Point (x:60 , y:-180 )) //J
triangleJ.append (Point (x:0, y:20 )) //J

canvas.drawCustomShape(with: triangleJ)

var triangleK: [Point] = []
triangleK.append (Point (x: 30 , y:-170 )) //K
triangleK.append (Point (x:0 , y:-190 )) //K
triangleK.append (Point (x:0, y:20 )) //K

canvas.drawCustomShape(with: triangleK)

var triangleL: [Point] = []
triangleL.append (Point (x: -160, y: 160)) //L
triangleL.append (Point (x: -180, y: 140)) //L
triangleL.append (Point (x: 0, y: 20)) //L

canvas.drawCustomShape(with: triangleL)

var triangleM: [Point] = []
triangleM.append (Point (x: -200, y: 120)) //M
triangleM.append (Point (x: -220, y: 100)) //M
triangleM.append (Point (x: 0, y: 20)) //M

canvas.drawCustomShape(with: triangleM)

var triangleN: [Point] = []
triangleN.append (Point (x: -220, y: 70)) //N
triangleN.append (Point (x: -240, y: 50)) //N
triangleN.append (Point (x: 0, y: 20)) //N

canvas.drawCustomShape(with: triangleN)

var triangleO: [Point] = []
triangleO.append (Point (x: -220, y: 30)) //O
triangleO.append (Point (x: -240, y: 10)) //O
triangleO.append (Point (x: 0, y: 20)) //O

canvas.drawCustomShape(with: triangleO)

var triangleP: [Point] = []
triangleP.append (Point (x: -210, y: -10)) //P
triangleP.append (Point (x: -230, y: -30)) //P
triangleP.append (Point (x: 0, y: 20)) //P

canvas.drawCustomShape(with: triangleF)

var triangleQ: [Point] = []
triangleQ.append (Point (x: -180, y: -50)) //Q
triangleQ.append (Point (x: -200, y: -80)) //Q
triangleQ.append (Point (x: 0, y: 20)) //Q

canvas.drawCustomShape(with: triangleQ)

var triangleR: [Point] = []
triangleR.append (Point (x: -130, y: -80)) //R
triangleR.append (Point (x: -150, y: -130)) //R
triangleR.append (Point (x: 0, y: 20)) //R

canvas.drawCustomShape(with: triangleR)

var triangleS: [Point] = []
triangleS.append (Point (x: -100, y: -110)) //S
triangleS.append (Point (x: -110, y: -150)) //S
triangleS.append (Point (x: 0, y: 20)) //S

canvas.drawCustomShape(with: triangleS)


var triangleT: [Point] = []
triangleT.append (Point (x: -60 , y:-120 )) //T
triangleT.append (Point (x:-60 , y:-180 )) //T
triangleT.append (Point (x:0, y:20 )) //T

canvas.drawCustomShape(with: triangleT)

var triangleU: [Point] = []
triangleU.append (Point (x: -120, y: 200)) //U
triangleU.append (Point (x: -140, y: 180)) //U
triangleU.append (Point (x: 0, y: 20)) //U

canvas.drawCustomShape(with: triangleU)

var triangleV: [Point] = []
triangleV.append (Point (x: -200, y: -20)) //V
triangleV.append (Point (x: -220, y: -50)) //V
triangleV.append (Point (x: 0, y: 20)) //V

canvas.drawCustomShape(with: triangleV)

var triangleW: [Point] = []
triangleW.append (Point (x: -200, y: -20)) //W
triangleW.append (Point (x: -220, y: -50)) //W
triangleW.append (Point (x: 0, y: 20)) //W

canvas.drawCustomShape(with: triangleW)


var triangleX: [Point] = []
triangleX.append (Point (x: -45, y: 180)) //X
triangleX.append (Point (x: -80, y: 185)) //X
triangleX.append (Point (x: 0, y: 20)) //X

canvas.drawCustomShape(with: triangleX)


canvas.highPerformance = false

var triangleY: [Point] = []
triangleY.append (Point (x: 45, y: 180)) //Y
triangleY.append (Point (x: 80, y: 185)) //Y
triangleY.append (Point (x: 0, y: 20)) //Y

canvas.drawCustomShape(with: triangleY)

canvas.copyToClipboard()
