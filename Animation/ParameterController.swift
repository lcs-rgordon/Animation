//
//  ParameterController.swift
//  Animation
//
//  Created by Russell Gordon on 2020-05-30.
//  Copyright © 2020 Royal St. George's College. All rights reserved.
//

import Cocoa

class ParameterController: NSViewController {

    // MARK: Properties
    
    // MARK: Outlets
    @IBOutlet weak var hueBox: ColorView!
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
    }

    // This is called when the slider's value changes
    @IBAction func valueChanged(_ sender: NSSliderCell) {
        print("Hue is now: \(sender.doubleValue)")
        
        // Change the colour of the hue bux
        hueBox.currentColor = NSColor(calibratedHue: CGFloat(sender.doubleValue)/360.0, saturation: 0.8, brightness: 0.9, alpha: 1.0)
        hueBox.display()
        print("Huebox color is now: \(hueBox.currentColor.hueComponent)")
    }

    // This is called when the "Show Animation" button is pressed
    @IBAction func showAnimation(_ sender: Any) {
        
        self.performSegue(withIdentifier: "ShowAnimation", sender: self)
        
    }
}
