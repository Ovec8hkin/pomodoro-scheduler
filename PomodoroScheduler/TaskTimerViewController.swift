//
//  ViewController.swift
//  PomodoroScheduler
//
//  Created by Joshua Zahner on 4/6/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import Cocoa

class TaskTimerViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, TaskDataChanged{
    
    @IBOutlet var newTaskTitleEntry: NSTextField!
    @IBOutlet var newTaskColorButton: NSButton!
    @IBOutlet var newTaskTimeButton: NSButton!
    
    @IBOutlet var circularView: NSView!
    @IBOutlet var taskName: NSTextField!
    @IBOutlet var timeRemainingLabel: NSTextField!
    
    @IBOutlet var playButton: NSButton!
    @IBOutlet var pauseButton: NSButton!
    @IBOutlet var endButton: NSButton!
    
    @IBOutlet var tableView: NSTableView!
    
    @IBAction func play(sender: NSButton){
        
        if taskManager.tasks.count > 0{
            self.task = taskManager.tasks[0]
        }else{
            return
        }
        
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
        
        if taskManager.tasks.count > 0{
            task.completeTask()
            setUpForNewTask()
            tableView.reloadData()
        }else{
            return
        }

    }
    
    @IBAction func addTitleToTask(sender: NSTextField){
        
        print("AddTitleToTask")
        
        newTask.title = sender.stringValue
        //newTask.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        print(newTask.time)
        taskManager.addTask(task: newTask)
        
        tableView.reloadData()
        
        if taskManager.tasks.count == 1{
            setUpForNewTask()
        }
        
        newTask = Task(viewController: self)
        
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        return formatter
    }()
    
    var newTask: Task!
    
    var task: Task!
    var taskManager = TaskManager.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer?.backgroundColor = .white
        
        newTask = Task(viewController: self)
        
        let task = Task(title: "Work on TSA Projects", startDate: dateFormatter.date(from: "4:21:00")!, endDate: dateFormatter.date(from: "4:21:05")!, color: CGColor(red: 0, green: 1.0, blue: 0, alpha: 1.0), viewController: self)
        
        task.viewController = self

        // Do any additional setup after loading the view.
        circularView.layer?.backgroundColor = CGColor(red: 1.0, green: 0, blue: 0, alpha: 1.0)
        
        timeRemainingLabel.isEditable = false
        timeRemainingLabel.isBezeled = false
        timeRemainingLabel.isSelectable = false
        
        taskName.isEditable = false
        taskName.isBezeled = false
        taskName.isSelectable = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.task = taskManager.tasks[0]
        
        setUpForNewTask()
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return taskManager.tasks.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text: String
        var cellID: String
        let task = taskManager.tasks[row]
        
        if tableColumn == tableView.tableColumns[0]{
            cellID = "taskNameCell"
            text = task.title
        }else{
            cellID = "taskLengthCell"
            text = formatTimeString(time: task.time)
        }
        
        let cell = tableView.make(withIdentifier: cellID, owner: nil) as! NSTableCellView
        cell.textField?.stringValue = text
        
        return cell
        
    }
    
    func taskTimeChanged(time: TimeInterval) {
        newTask.time = time
    }
    
    func taskColorChanged(color: CGColor) {
        newTask.color = color
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskSetTime"{
            let destination = segue.destinationController as! TaskSetTimeViewController
            destination.delegate = self
            destination.task = newTask
        }
    }
    
    
    func updateTimer(){
        print("Updated Timer")
        print(task)
        
        if task.time > 0{
            timeRemainingLabel.stringValue = formatTimeString(time: task.calculateTimeRemaining())
        }else{
            task.completeTask()
            setUpForNewTask()
            tableView.reloadData()
        }
    }
    
    func formatTimeString(time: TimeInterval) -> String{
        
        let theTime = Int(time)
        
        let hours = theTime/3600
        let mins = theTime/60 % 60
        let secs = theTime % 60
        
        return String(format: "%02d:%02d:%02d", hours, mins, secs);
        
    }
    
    func setUpForNewTask(){
        
        var time: String
        var name: String
        var color: CGColor
        
        if taskManager.tasks.count > 0{
            task = taskManager.tasks[0]
            time = formatTimeString(time: task.time)
            name = task.title
            color = task.color
        }else{
            name = "No More Tasks"
            time = "00:00:00"
            color = .clear
        }
        
        timeRemainingLabel.stringValue = time
        taskName.stringValue = name
        
        circularView.layer?.backgroundColor = color
        
    }
    
    
    


}

