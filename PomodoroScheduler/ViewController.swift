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
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        return formatter
    }()
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        circularView.layer?.backgroundColor = CGColor(red: 1.0, green: 0, blue: 0, alpha: 1.0)
        
        timeRemainingLabel.stringValue = dateFormatter.string(from: Date())
        
        timeRemainingLabel.isEditable = false
        timeRemainingLabel.isBezeled = false
        timeRemainingLabel.isSelectable = false
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    


}

