//
//  TaskManagerViewController.swift
//  PomodoroScheduler
//
//  Created by Joshua Zahner on 4/8/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import Cocoa

class TaskManagerViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource{
    
    var taskManager: TaskManager = TaskManager()
    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var addButton: NSButton!
    
    @IBAction func addTask(sender: NSButton){
        taskManager.addTask(task: Task(title: "3", time: 300, color: .black, viewController: self))
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer?.backgroundColor = CGColor.white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        taskManager.addTask(task: Task(title: "1", time: 100, color: .black, viewController: self))
        taskManager.addTask(task: Task(title: "2", time: 200, color: .black, viewController: self))
        
        tableView.reloadData()
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}
