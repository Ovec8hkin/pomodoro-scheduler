//
//  ViewController.swift
//  PomodoroScheduler
//
//  Created by Joshua Zahner on 4/6/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var circularView: NSView!
    @IBOutlet var timeRemainingLabel: NSTextField!
    @IBOutlet var playButton: NSButton!
    @IBOutlet var pauseButton: NSButton!
    @IBOutlet var endButton: NSButton!
    
    @IBAction func play(sender: NSButton){
        
        switch task.status{
            
            case .notStarted:
                task.startTask()
            case .paused:
                task.resumeTask()
            default:
                break
            
        }
        
    }
    
    @IBAction func pause(sender: NSButton){
        task.pauseTask()
    }
    
    @IBAction func end(sender: NSButton){
        task.completeTask()
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        return formatter
    }()
    
    var task: Task!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        task = Task(title: "Work on TSA Projects", startDate: dateFormatter.date(from: "4:21:00")!, endDate: dateFormatter.date(from: "6:38:00")!, color: CGColor(red: 0, green: 1.0, blue: 0, alpha: 1.0))
        
        timer = Timer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        task.timer = timer
        task.viewController = self

        // Do any additional setup after loading the view.
        circularView.layer?.backgroundColor = CGColor(red: 1.0, green: 0, blue: 0, alpha: 1.0)
        
        timeRemainingLabel.isEditable = false
        timeRemainingLabel.isBezeled = false
        timeRemainingLabel.isSelectable = false
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func updateTimer(){
        print("Updated Timer")
        timeRemainingLabel.stringValue = formatTimeString(time: task.calculateTimeRemaining())
    }
    
    func formatTimeString(time: TimeInterval) -> String{
        
        let theTime = Int(time)
        
        let hours = theTime/3600
        let mins = theTime/60 % 60
        let secs = theTime % 60
        
        return String(format: "%02d:%02d:%02d", hours, mins, secs);
        
    }
    
    
    


}

