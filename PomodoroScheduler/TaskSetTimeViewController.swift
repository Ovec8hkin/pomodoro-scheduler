//
//  TaskSetTimeViewController.swift
//  PomodoroScheduler
//
//  Created by Joshua Zahner on 4/8/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import Cocoa

class TaskSetTimeViewController: NSViewController{
    
    var task: Task!
    var delegate: TaskDataChanged? = nil
    
    @IBOutlet var hoursInput: NSTextField!
    @IBOutlet var minutesInput: NSTextField!
    @IBOutlet var secondsInput: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hoursInput.stringValue = String(Int(task.time)/3600)
        minutesInput.stringValue = String(Int(task.time)/60 % 60)
        secondsInput.stringValue = String(Int(task.time) % 60)
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func computeTime(){
        let hours = Int(hoursInput.stringValue)! * 3600
        let minutes = Int(minutesInput.stringValue)! * 60
        let seconds = Int(secondsInput.stringValue)!
        
        task.time = TimeInterval(hours + minutes + seconds)
        
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        computeTime()
        
        delegate?.taskTimeChanged(time: task.time)
        
    }
    
    
}
