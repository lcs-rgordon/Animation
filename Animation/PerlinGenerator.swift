//
// Port of a Perlin noise Objective-C implementation in Swift
// Original source https://github.com/czgarrett/perlin-ios
//
// For references on the Perlin algorithm:
// Each of these has a slightly different way of explaining Perlin noise.  They were all useful:
// Overviews of Perlin: http://paulbourke.net/texture_colour/perlin/ and http://freespace.virgin.net/hugo.elias/models/m_perlin.htm
// Awesome C++ tutorial on Perlin: http://www.dreamincode.net/forums/topic/66480-perlin-noise/

//  MIT License:

//  Perlin-Swift Copyright (c) 2015 Lachlan Hurst
//  Perlin-iOS Copyright (C) 2011 by Christopher Z. Garrett

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN

import Foundation

// MARK: - Seeds

let permutationSize = 256
let permutation: [Int] = (0..<permutationSize).map { _ in
    Int(arc4random() & 0xff)
}

// MARK: - Gradient

typealias Gradient = [[Int8]]

let gradient: Gradient = [
    [ 1,  1,  1, 0], [ 1,  1, 0,  1], [ 1, 0,  1,  1], [0,  1,  1,  1],
    [ 1,  1, -1, 0], [ 1,  1, 0, -1], [ 1, 0,  1, -1], [0,  1,  1, -1],
    [ 1, -1,  1, 0], [ 1, -1, 0,  1], [ 1, 0, -1,  1], [0,  1, -1,  1],
    [ 1, -1, -1, 0], [ 1, -1, 0, -1], [ 1, 0, -1, -1], [0,  1, -1, -1],
    [-1,  1,  1, 0], [-1,  1, 0,  1], [-1, 0,  1,  1], [0, -1,  1,  1],
    [-1,  1, -1, 0], [-1,  1, 0, -1], [-1, 0,  1, -1], [0, -1,  1, -1],
    [-1, -1,  1, 0], [-1, -1, 0,  1], [-1, 0, -1,  1], [0, -1, -1,  1],
    [-1, -1, -1, 0], [-1, -1, 0, -1], [-1, 0, -1, -1], [0, -1, -1, -1],
]

// MARK: - Noise

open class PerlinGenerator {
    
    var octaves: Int
    var persistence: Double
    var zoom: Double
    
    public init() {
        octaves = 1
        persistence = 1
        zoom = 1
    }
    
    func index(i: Int, j: Int, k: Int, l: Int) -> Int {
        let p0 = i & 0xff
        let p1 = (j + permutation[p0]) & 0xff
        let p2 = (k + permutation[p1]) & 0xff
        let p3 = (l + permutation[p2]) & 0xff
        return permutation[p3] & 0x1f
    }
    
    func productOf(a: Double, b: Int8) -> Double {
        if b > 0 {
            return a
        } else if b < 0 {
            return -a
        }
        return 0
    }
    
    func dotProduct(x0: Double, x1: Int8,
                    y0: Double, y1: Int8,
                    z0: Double, z1: Int8,
                    t0: Double, t1: Int8) -> Double {
        return productOf(a: x0, b: x1) +
            productOf(a: y0, b: y1) +
            productOf(a: z0, b: z1) +
            productOf(a: t0, b: t1)
    }
    
    func spline(state: Double) -> Double {
        let square = state * state
        let cubic = square * state
        return cubic * (6 * square - 15 * state + 10)
    }
    
    func interpolate(a: Double, b: Double, x: Double) -> Double {
        return a + x * (b - a)
    }
    
    func smoothNoise(x: Double, y: Double, z: Double, t: Double) -> Double {
        let x0 = Int(x > 0 ? x : x - 1)
        let y0 = Int(y > 0 ? y : y - 1)
        let z0 = Int(z > 0 ? z : z - 1)
        let t0 = Int(t > 0 ? t : t - 1)
        
        let x1 = x0+1
        let y1 = y0+1
        let z1 = z0+1
        let t1 = t0+1
        
        // The vectors
        var dx0 = x - Double(x0)
        var dy0 = y - Double(y0)
        var dz0 = z - Double(z0)
        var dt0 = t - Double(t0)
        let dx1 = x - Double(x1)
        let dy1 = y - Double(y1)
        let dz1 = z - Double(z1)
        let dt1 = t - Double(t1)
        
        // The 16 gradient values
        let g0000 = gradient[index(i: x0, j: y0, k: z0, l: t0)]
        let g0001 = gradient[index(i: x0, j: y0, k: z0, l: t1)]
        let g0010 = gradient[index(i: x0, j: y0, k: z1, l: t0)]
        let g0011 = gradient[index(i: x0, j: y0, k: z1, l: t1)]
        let g0100 = gradient[index(i: x0, j: y1, k: z0, l: t0)]
        let g0101 = gradient[index(i: x0, j: y1, k: z0, l: t1)]
        let g0110 = gradient[index(i: x0, j: y1, k: z1, l: t0)]
        let g0111 = gradient[index(i: x0, j: y1, k: z1, l: t1)]
        let g1000 = gradient[index(i: x1, j: y0, k: z0, l: t0)]
        let g1001 = gradient[index(i: x1, j: y0, k: z0, l: t1)]
        let g1010 = gradient[index(i: x1, j: y0, k: z1, l: t0)]
        let g1011 = gradient[index(i: x1, j: y0, k: z1, l: t1)]
        let g1100 = gradient[index(i: x1, j: y1, k: z0, l: t0)]
        let g1101 = gradient[index(i: x1, j: y1, k: z0, l: t1)]
        let g1110 = gradient[index(i: x1, j: y1, k: z1, l: t0)]
        let g1111 = gradient[index(i: x1, j: y1, k: z1, l: t1)]
        
        // The 16 dot products
        let b0000 = dotProduct(x0: dx0, x1: g0000[0], y0:dy0, y1:g0000[1], z0:dz0, z1:g0000[2], t0:dt0, t1:g0000[3])
        let b0001 = dotProduct(x0: dx0, x1: g0001[0], y0:dy0, y1:g0001[1], z0:dz0, z1:g0001[2], t0:dt1, t1:g0001[3])
        let b0010 = dotProduct(x0: dx0, x1: g0010[0], y0:dy0, y1:g0010[1], z0:dz1, z1:g0010[2], t0:dt0, t1:g0010[3])
        let b0011 = dotProduct(x0: dx0, x1: g0011[0], y0:dy0, y1:g0011[1], z0:dz1, z1:g0011[2], t0:dt1, t1:g0011[3])
        let b0100 = dotProduct(x0: dx0, x1: g0100[0], y0:dy1, y1:g0100[1], z0:dz0, z1:g0100[2], t0:dt0, t1:g0100[3])
        let b0101 = dotProduct(x0: dx0, x1: g0101[0], y0:dy1, y1:g0101[1], z0:dz0, z1:g0101[2], t0:dt1, t1:g0101[3])
        let b0110 = dotProduct(x0: dx0, x1: g0110[0], y0:dy1, y1:g0110[1], z0:dz1, z1:g0110[2], t0:dt0, t1:g0110[3])
        let b0111 = dotProduct(x0: dx0, x1: g0111[0], y0:dy1, y1:g0111[1], z0:dz1, z1:g0111[2], t0:dt1, t1:g0111[3])
        let b1000 = dotProduct(x0: dx1, x1: g1000[0], y0:dy0, y1:g1000[1], z0:dz0, z1:g1000[2], t0:dt0, t1:g1000[3])
        let b1001 = dotProduct(x0: dx1, x1: g1001[0], y0:dy0, y1:g1001[1], z0:dz0, z1:g1001[2], t0:dt1, t1:g1001[3])
        let b1010 = dotProduct(x0: dx1, x1: g1010[0], y0:dy0, y1:g1010[1], z0:dz1, z1:g1010[2], t0:dt0, t1:g1010[3])
        let b1011 = dotProduct(x0: dx1, x1: g1011[0], y0:dy0, y1:g1011[1], z0:dz1, z1:g1011[2], t0:dt1, t1:g1011[3])
        let b1100 = dotProduct(x0: dx1, x1: g1100[0], y0:dy1, y1:g1100[1], z0:dz0, z1:g1100[2], t0:dt0, t1:g1100[3])
        let b1101 = dotProduct(x0: dx1, x1: g1101[0], y0:dy1, y1:g1101[1], z0:dz0, z1:g1101[2], t0:dt1, t1:g1101[3])
        let b1110 = dotProduct(x0: dx1, x1: g1110[0], y0:dy1, y1:g1110[1], z0:dz1, z1:g1110[2], t0:dt0, t1:g1110[3])
        let b1111 = dotProduct(x0: dx1, x1: g1111[0], y0:dy1, y1:g1111[1], z0:dz1, z1:g1111[2], t0:dt1, t1:g1111[3])
        
        dx0 = spline(state: dx0)
        dy0 = spline(state: dy0)
        dz0 = spline(state: dz0)
        dt0 = spline(state: dt0)
        
        let b111 = interpolate(a: b1110, b:b1111, x:dt0)
        let b110 = interpolate(a: b1100, b:b1101, x:dt0)
        let b101 = interpolate(a: b1010, b:b1011, x:dt0)
        let b100 = interpolate(a: b1000, b:b1001, x:dt0)
        let b011 = interpolate(a: b0110, b:b0111, x:dt0)
        let b010 = interpolate(a: b0100, b:b0101, x:dt0)
        let b001 = interpolate(a: b0010, b:b0011, x:dt0)
        let b000 = interpolate(a: b0000, b:b0001, x:dt0)
        
        let b11 = interpolate(a: b110, b:b111, x:dz0)
        let b10 = interpolate(a: b100, b:b101, x:dz0)
        let b01 = interpolate(a: b010, b:b011, x:dz0)
        let b00 = interpolate(a: b000, b:b001, x:dz0)
        
        let b1 = interpolate(a: b10, b:b11, x:dy0)
        let b0 = interpolate(a: b00, b:b01, x:dy0)
        
        let result = interpolate(a: b0, b:b1, x:dx0)
        
        return result
    }
    
    open func perlinNoise(x: Double, y: Double = 0, z: Double = 0, t: Double = 0) -> Double {
        
        var noise: Double = 0.0
        for octave in 0..<octaves {
            let frequency = pow(2, Double(octave)) / zoom
            let amplitude = pow(persistence, Double(octave))
            
            noise += smoothNoise(x: x * frequency,
                                 y: y * frequency,
                                 z: z * frequency,
                                 t: t * frequency) * amplitude
        }
        return noise        
    }
}
