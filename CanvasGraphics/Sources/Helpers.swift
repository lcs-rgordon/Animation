//
//  Helpers.swift
//  CanvasGraphics
//
//  A variety of useful functions.
//
//  Created by Russell Gordon on 11/12/18.
//  Copyright © 2018 Russell Gordon. All rights reserved.
//

import Foundation

/**
 Returns a random number in the given range, inclusive.
 
 - parameter from: The lowest possible random value that may be returned.
 - parameter to: The highest possible random value that may be returned.
 
 */
public func random(from : Int, to : Int) -> Int {
    
    let max = UInt32(to + 1 - from)
    
    return Int(arc4random_uniform(max)) + from
    
}
