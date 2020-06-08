//
//  ViewController.swift
//  Animation
//
//  Created by Russell Gordon on 2015-12-05.
//  Copyright © 2015 Russell Gordon. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var timer = Timer()
    var sketch = Sketch()
    
    @IBOutlet var myView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tell OS that we want a layer to display an image on
        self.view.wantsLayer = true
        
        // Initialize the timer used to drive the sketch
        timer = Timer.scheduledTimer(timeInterval: 1/Double(sketch.currentDrawing.canvas.framesPerSecond), target: self, selector: #selector(ViewController.timedDraw), userInfo: nil, repeats: true)
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        // Before the view appears, resize to match the size of the canvas we are painting on
        // See: http://stackoverflow.com/questions/27578085/resizing-window-to-view-controller-size-in-storyboard
        preferredContentSize = NSSize(width: sketch.currentDrawing.canvas.width, height: sketch.currentDrawing.canvas.height)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @objc func timedDraw() {
        
        // Call the draw() method on the Sketch object
        sketch.currentDrawing.draw()
        
        // Make sure the canvas image gets updated
        sketch.currentDrawing.canvas.highPerformance = false

        // Increment the frame count for the current canvas of the sketch
        sketch.currentDrawing.canvas.frameCount += 1
        
        // Get a Core Graphics representation of the current image on the canvas
        // and set it to the backing layer of the NSView object tied to the
        var imageRect : NSRect = NSMakeRect(0, 0, CGFloat(sketch.currentDrawing.canvas.width), CGFloat(sketch.currentDrawing.canvas.height))
        NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: sketch.currentDrawing.canvas.offscreenRepresentation)
        self.view.layer!.contents = sketch.currentDrawing.canvas.image?.cgImage(forProposedRect: &imageRect, context: NSGraphicsContext.current, hints: nil)

    }
    
}

