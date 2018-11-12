//
//  CanvasLiveViewableViewController.swift
//  Animation
//
//  Created by Russell Gordon on 9/13/16.
//  Copyright © 2016 Royal St. George's College. All rights reserved.
//

import Cocoa

class CanvasLiveViewableViewController: NSViewController {
    
    var canvas : Canvas
    
    init(canvas : Canvas) {
        self.canvas = canvas
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = canvas.imageView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here
        var imageRect : NSRect = NSMakeRect(0, 0, CGFloat(canvas.width), CGFloat(canvas.height))
        self.view.layer!.contents = canvas.imageView.image?.cgImage(forProposedRect: &imageRect, context: NSGraphicsContext.current, hints: nil)
        
    }
    
}
