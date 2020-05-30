//
//  ParameterController.swift
//  Animation
//
//  Created by Russell Gordon on 2020-05-30.
//  Copyright © 2020 Royal St. George's College. All rights reserved.
//

import Cocoa

class ParameterController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func showAnimation(_ sender: Any) {
        
        self.performSegue(withIdentifier: "ShowAnimation", sender: self)
        
    }
}
