//
//  Sketchable.swift
//  Animation
//
//  Created by Russell Gordon on 2020-06-08.
//  Copyright © 2020 Russell Gordon. All rights reserved.
//

import Foundation
import CanvasGraphics

// Any conforming type (a class or structure that adopts this protocol) must have:
// 1. A canvas property, of type Canvas
// 2. A method named draw()
protocol Sketchable {
    
    // A canvas to draw upon
    var canvas: Canvas { get set }
    
    // A method that will be invoked about 60 times per second, to create the animated effect
    func draw()
    
    
}
