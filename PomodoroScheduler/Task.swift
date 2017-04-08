//
//  Task.swift
//  PomodoroScheduler
//
//  Created by Joshua Zahner on 4/7/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import Cocoa

class Task: NSObject{
    
    var title: String
    var time: TimeInterval
    var color: CGColor
    var status: TaskStatus = .notStarted
    
    var timer: Timer!
    
    var viewController: ViewController!
    
    init(title: String, time: TimeInterval, color: CGColor){
        
        self.title = title
        self.time = time
        self.color = color
        
    }
    
    init(title: String, endDate: Date, color: CGColor){
        
        self.title = title
        self.color = color
        
        self.time = endDate.timeIntervalSinceNow

    }
    
    init(title: String, startDate: Date, endDate: Date, color: CGColor){
        
        self.title = title
        self.color = color
        
        self.time = endDate.timeIntervalSince(startDate)
        
    }
    
    func pauseTask(){
        print("Pause")
        timer.invalidate()
        status = .paused
    }
    
    func resumeTask(){
        print("Resume")
        
        timer = Timer(timeInterval: 1, target: viewController, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        
        startTask()
        status = .started
    }
    
    func startTask(){
        print("Start")
        RunLoop.current.add(self.timer, forMode: .commonModes)
        status = .started
    }
    
    func completeTask(){
        print("Done")
        timer.invalidate()
        status = .finished
    }
    
    func calculateTimeRemaining() -> TimeInterval{
        time.subtract(1.0)
        return time
    }
    
}
