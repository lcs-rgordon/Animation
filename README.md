# Animation

Welcome to **Animation**, an environment for authoring [Processing](https://processing.org)-style animations with Swift.

## Examples

Animations are, naturally, easy to generate:

![colorful-animation-smaller-resolution](https://user-images.githubusercontent.com/32135742/61841329-07a42b80-ae5a-11e9-84f5-b6a3a0a59acb.gif)

Of course, animations are crisp and smooth when running in Xcode; what you see above is an animated GIF.

Static images can also be generated, for example:

![thepixies](https://user-images.githubusercontent.com/32135742/61841552-c5c7b500-ae5a-11e9-8d21-e0bff2029493.png)

NOTE: the original gig poster design shown here is by [Mike Joyce at Swissted](https://www.swissted.com/pages/about-us).

## Motivation

Animation shares the same goal as the Processing environment – to allow students to learn programming by creating interactive graphics.

The following is an excerpt from **Getting Started with Processing** (2010) by Casey Reas and Ben Fry:

*Programming courses typically focus on structure and theory first. Anything visual—an interface, an animation—is considered a dessert to be enjoyed only after finishing your vegetables, usually several weeks of studying algorithms and methods. Over the years, we’ve watched many friends try to take such courses and drop out after the first lecture or after a long, frustrating night before the first assignment deadline. What initial curiosity they had about making the computer work for them was lost because they couldn’t see a path from what they had to learn first to what they wanted to create.*

My experience has been that:

* easy creation of interactive graphics
* the elegance of the Swift programming language
* the forgiving and exploratory nature of the Swift Playgrounds environment

... combines to make an extremely powerful introductory learning experience for students in Computer Science classes.

## System Requirements

* [Xcode 12.x](https://apps.apple.com/ca/app/xcode/id497799835?mt=12)

## Getting Started

Clone or [download a ZIP](https://github.com/lcs-rgordon/Animation/archive/master.zip) of the repository.

Be sure you open the `Animation.xcodeproj` file:

<img width="641" alt="Screen Shot 2019-07-24 at 9 42 57 PM" src="https://user-images.githubusercontent.com/32135742/61841955-1855a100-ae5c-11e9-89a3-30386bf8f864.png">

To create static images, use the playground file:

<img width="269" alt="Screen Shot 2019-07-24 at 9 41 46 PM" src="https://user-images.githubusercontent.com/32135742/61841886-e04e5e00-ae5b-11e9-83e1-eb3d85b664d9.png">

To create an animation, work in the `Sketch.swift` file:

<img width="279" alt="Screen Shot 2019-07-24 at 9 46 23 PM" src="https://user-images.githubusercontent.com/32135742/61842074-7edabf00-ae5c-11e9-96ad-63ff914bba1f.png">

To see your animation, build and run the Animation application:

<img width="334" alt="Screen Shot 2019-07-24 at 9 48 07 PM" src="https://user-images.githubusercontent.com/32135742/61842157-c9f4d200-ae5c-11e9-98e1-b66dcef76172.png">

## Documentation

Animation is designed to be an easy-to-use sketching environment.

Create an instance of the Canvas class and begin drawing:

```swift
import Cocoa
import PlaygroundSupport
import CanvasGraphics

// Create canvas
let canvas = Canvas(width: 300, height: 600)

// Show the canvas in the playground's live view
PlaygroundPage.current.liveView = canvas

// Draw a face
canvas.fillColor = .white
canvas.defaultBorderWidth = 5
canvas.drawEllipse(at: Point(x: 150, y: 300), width: 200, height: 200)

// Draw eyes
canvas.drawEllipse(at: Point(x: 125, y: 325), width: 10, height: 20)
canvas.drawEllipse(at: Point(x: 175, y: 325), width: 10, height: 20)

// Draw mouth
canvas.drawEllipse(at: Point(x: 150, y: 270), width: 100, height: 30)

// Turn mouth into a smile by covering up top half of mouth
canvas.drawShapesWithBorders = false
canvas.drawRectangle(at: Point(x: 150, y: 275), width: 125, height: 25, anchoredBy: .centre)
```

You can read through the [documentation for available drawing methods here](http://russellgordon.ca/CanvasGraphics/Documentation/Classes/Canvas.html).
