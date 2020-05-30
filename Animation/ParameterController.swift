//
//  ParameterController.swift
//  Animation
//
//  Created by Russell Gordon on 2020-05-30.
//  Copyright © 2020 Royal St. George's College. All rights reserved.
//

import Cocoa
import CanvasGraphics

class ParameterController: NSViewController {

    // MARK: Properties
    var childSketch: ViewController?
    var childSketchVisible = false
    
    // MARK: Outlets
    @IBOutlet weak var hueBox: ColorView!
    @IBOutlet weak var hueSlider: NSSlider!
    @IBOutlet weak var showAnimationButton: NSButton!
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
    }

    // This is called when the slider's value changes
    @IBAction func valueChanged(_ sender: NSSliderCell) {
        
        print("Hue is now: \(sender.doubleValue)")
        
        // Change the colour of the hue box
        hueBox.currentColor = NSColor(calibratedHue: CGFloat(sender.doubleValue)/360.0, saturation: 0.8, brightness: 0.9, alpha: 1.0)
        hueBox.display()
        print("Huebox color is now: \(hueBox.currentColor.hueComponent)")
        
        // Update in the sketch
        childSketch?.sketch.color = Color(hue: Float(hueSlider.doubleValue), saturation: 80, brightness: 90, alpha: 100)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destinationController as? ViewController {

            // Pass some information forward to the sketch
            vc.sketch.color = Color(hue: Float(hueSlider.doubleValue), saturation: 80, brightness: 90, alpha: 100)
            
            // Save a reference to the child sketch
            childSketch = vc

        }
    }

    // This is called when the "Show Animation" button is pressed
    @IBAction func showAnimation(_ sender: Any) {

        // If we haven't already shown the child sketch, show it now
        if childSketchVisible == false {
            
            // Show the actual animation
            self.performSegue(withIdentifier: "ShowAnimation", sender: self)

            // Record that we've shown the child sketch
            childSketchVisible = true
            
            // Disable the show child sketch button
            showAnimationButton.isEnabled = false

        }
        

    }
}
