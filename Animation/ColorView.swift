//
//  ColorView.swift
//  Animation
//
//  Created by Russell Gordon on 2020-05-30.
//  Copyright © 2020 Royal St. George's College. All rights reserved.
//

import Cocoa

class ColorView: NSView {
    
    var currentColor: NSColor = NSColor(calibratedHue: 180.0/360.0, saturation: 0.8, brightness: 0.9, alpha: 1.0)

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // #1d161d
        currentColor.setFill()
        dirtyRect.fill()
    }

}
