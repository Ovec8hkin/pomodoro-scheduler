//
//  ProgressCircleView.swift
//  PomodoroScheduler
//
//  Created by Joshua Zahner on 4/11/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import Cocoa

class ProgressCircleView: NSView {

    var progress = 0.0{
        didSet{
            NSLog("PROGRESS: %05d", progress*1000)
        }
    }
    var multiplier: Double = 3.6
    var time: TimeInterval = 1
    
    override var isFlipped: Bool{
        get{
            return true
        }
    }
    
    override func viewDidMoveToWindow() {
        self.progress = 0
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        
        let transform = NSAffineTransform()
        transform.translateX(by: dirtyRect.size.width/2, yBy: dirtyRect.size.height/2)
        transform.rotate(byDegrees: 270)
        transform.concat()
        
        /*if progress != 0{
            progress = 360/progress
        }else{
            progress = 0
        }*/
 
        var path = NSBezierPath()
        path.lineWidth = 2
        path.move(to: NSPoint(x: 0, y: 0))
        path.appendArc(withCenter: NSPoint(x: 0, y: 0), radius: 145, startAngle: 0, endAngle: CGFloat(progress*3.6/time))
        path.close()
        
        NSColor.red.setFill()
        path.fill()
        
        
        path = NSBezierPath()
        path.lineWidth = 2
        path.move(to: NSPoint(x: 0, y: 0))
        path.appendArc(withCenter: NSPoint(x: 0, y: 0), radius: 105, startAngle: 0, endAngle: 360)
        path.close()
        
        NSColor.white.setFill()
        path.fill()
        
    }
    
    
    func setProgress(progress: Double){
        self.progress = progress
    }
    
    func setMultiplier(multiplier: Double){
        self.multiplier = multiplier
    }
    
}
