//: [Previous](@previous) / [Next](@next)
//: # Test Area
//:
//: ## To duplicate this page
//:
//: You can add more pages to this playground to experiment with creating static images.
//:
//: Place your cursor on line 17 of this page, press `Command-A` to select all text, and then `Command-C` to copy.
//:
//: Move to the new page and press `Command-A` to select all text there, then `Command-V` to paste.
//:
/*:
 ## Canvas size
 
 Set the size of your desired canvas by adjusting the constants on lines 17 and 18.
 */
let preferredWidth = 300
let preferredHeight = 600
/*:
 ## Required code
 
 Lines 26 to 34 are required to make the playground run.
 
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
 
 Beginning on line 42, write a meaningful comment.
 
 You can remove the code on line 43 and begin writing your own code.
 */
// Replace this comment with your first comment – what is the goal of the code you're about to write?
canvas.drawRectangle(at: Point(x: 50, y: 75), width: 100, height: 200)

/*:
 ## Show the Assistant Editor
 Don't see any results?
 
 Remember to show the Assistant Editor, and switch to Live View:
 
 ![timeline](timeline.png "Timeline")
 */
/*:
 ## Use source control
 To keep your work organized, receive feedback, and earn a high grade in this course, regular use of source control is a must.
 
 Please commit and push your work often.
 
 ![source_control](source_control.png "Source Control")
 */
