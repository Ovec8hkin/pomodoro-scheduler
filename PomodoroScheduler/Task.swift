//
//  Task.swift
//  PomodoroScheduler
//
//  Created by Joshua Zahner on 4/7/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import Cocoa
import NotificationCenter

class Task: NSObject{
    
    var taskManager = TaskManager.instance
    
    var title: String
    var time: TimeInterval
    var color: CGColor
    var status: TaskStatus = .notStarted
    
    var timer: Timer?
    
    var viewController: TaskTimerViewController
    
    init(viewController: NSViewController){
        
        self.title = ""
        self.time = 0
        self.color = CGColor(red: 100, green: 100, blue: 100, alpha: 1)
        self.timer = nil
        self.viewController = viewController as! TaskTimerViewController
        
        super.init()
    }
    
    init(title: String, time: TimeInterval, color: CGColor, viewController: NSViewController){
        
        self.title = title
        self.time = time
        self.color = color
        self.viewController = viewController as! TaskTimerViewController
        
        self.timer = Timer(timeInterval: 1, target: viewController, selector: #selector(TaskTimerViewController.updateTimer), userInfo: nil, repeats: true)
        
        super.init()
        
        taskManager.addTask(task: self)
        
        
    }
    
    init(title: String, endDate: Date, color: CGColor, viewController: NSViewController){
        
        self.title = title
        self.color = color
        self.viewController = viewController as! TaskTimerViewController
        
        self.time = endDate.timeIntervalSinceNow
        
        
        timer = Timer(timeInterval: 1, target: viewController, selector: #selector(TaskTimerViewController.updateTimer), userInfo: nil, repeats: true)
        
        super.init()
        
        taskManager.addTask(task: self)

    }
    
    init(title: String, startDate: Date, endDate: Date, color: CGColor, viewController: NSViewController){
        
        self.title = title
        self.color = color
        self.viewController = viewController as! TaskTimerViewController
        
        self.time = endDate.timeIntervalSince(startDate)
        
        timer = Timer(timeInterval: 1.0, target: viewController, selector: #selector(TaskTimerViewController.updateTimer), userInfo: nil, repeats: true)

        
        super.init()
        
        taskManager.addTask(task: self)
        
        
    }
    
    func pauseTask(){
        print("Pause")
        if let timer = self.timer{
            timer.invalidate()
        }
        status = .paused
    }
    
    func resumeTask(){
        print("Resume")
        
        timer = Timer(timeInterval: 1, target: viewController, selector: #selector(TaskTimerViewController.updateTimer), userInfo: nil, repeats: true)
        
        startTask()
    }
    
    func startTask(){
        print("Start")
        
        if timer == nil{
            timer = Timer(timeInterval: 1.0, target: viewController, selector: #selector(TaskTimerViewController.updateTimer), userInfo: nil, repeats: true)
        }
        
        RunLoop.current.add(timer!, forMode: .commonModes)
        status = .started
    }
    
    func completeTask(){
        print("Done")
        timer?.invalidate()
        status = .finished
        taskManager.removeTask(task: self)
    }
    
    func calculateTimeRemaining() -> TimeInterval{
        time.subtract(1.0)
        return time
    }
    
}
