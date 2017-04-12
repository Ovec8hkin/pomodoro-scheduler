//
//  ViewController.swift
//  PomodoroScheduler
//
//  Created by Joshua Zahner on 4/6/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import Cocoa

class TaskTimerViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, TaskDataChanged{
    
    @IBOutlet var handler: GUIHandler!
    /**************** IBOUTLETS ****************/
    
    @IBOutlet var scrollView: NSScrollView!
    
    @IBOutlet var newTaskTitleEntry: NSTextField!
    @IBOutlet var newTaskColorButton: NSColorWell!
    @IBOutlet var newTaskTimeButton: NSButton!
    
    @IBOutlet var outerCircularView: ProgressCircleView!
    @IBOutlet var innerCircularView: NSView!
    
    
    @IBOutlet var taskName: NSTextField!
    @IBOutlet var timeRemainingLabel: NSTextField!
    
    @IBOutlet var playButton: NSButton!
    @IBOutlet var pauseButton: NSButton!
    @IBOutlet var endButton: NSButton!
    
    @IBOutlet var tableView: NSTableView!
    
    /**************** IBACTIONS ****************/
    
    @IBAction func play(sender: NSButton){
        
        if taskManager.tasks.count > 0{
            self.task = taskManager.tasks[0]
        }else{
            return
        }
        
        switch task.status{
            
            case .notStarted:
                timerStart = Date()
                task.startTask()
                handler.handleProgress(sender: playButton, time: task.time)
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
            print("Setting up new task!")
            tableView.reloadData()
            setUpForNewTask()
        }else{
            return
        }

    }
    
    @IBAction func addTitleToTask(sender: NSTextField){
        
        closeColorPanel()
        
        print("AddTitleToTask")
        
        newTask.title = sender.stringValue
        
        print(newTask.title)
        print(newTask.time)
        print(newTask.color)
        
        taskManager.addTask(task: newTask)
        
        tableView.reloadData()
        
        if taskManager.tasks.count == 1{
            setUpForNewTask()
        }
        
        newTask = Task(viewController: self)
        
    }
    
    @IBAction func newTaskColorChanged(sender: NSColorWell){
        print("color changed")
        newTask.color = sender.color.cgColor
        
        print("THE NEW COLOR IS: \(newTask.color)")
        
    }
    
    /**************** INSTANCE VARIABLES ****************/
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        return formatter
    }()
    
    var newTask: Task!
    var timerStart: Date!
    var task: Task!
    var taskManager = TaskManager.instance
    
    /**************** OVERRIDDEN METHODS ****************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Pomodoro Scheduler"
        self.view.layer?.backgroundColor = .white
        
        newTask = Task(viewController: self)
        
        let task = Task(title: "Work on TSA Projects", startDate: dateFormatter.date(from: "4:21:00")!, endDate: dateFormatter.date(from: "4:21:05")!, color: CGColor(red: 0, green: 1.0, blue: 0, alpha: 1.0), viewController: self)
        
        task.viewController = self

        // Do any additional setup after loading the view.
        
        outerCircularView.wantsLayer = true
        
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
    
    override func viewDidAppear() {
        super.viewDidAppear()
        scrollView.backgroundColor = NSColor(cgColor: .white)!
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return taskManager.tasks.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30;
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
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskSetTime"{
            let destination = segue.destinationController as! TaskSetTimeViewController
            destination.delegate = self
            destination.task = newTask
        }
    }
    
    func taskTimeChanged(time: TimeInterval) {
        newTask.time = time
        taskName.becomeFirstResponder()
    }
    
    func taskColorChanged(color: CGColor) {
        newTask.color = color
        taskName.becomeFirstResponder()
    }
    
    
    
    /**************** CUSTOM FUNCTIONS ****************/
    
    
    func updateTimer(){
        print("Updated Timer")
        print(task)
        
        if self.task.time > 0{
            self.timeRemainingLabel.stringValue = self.formatTimeString(time: self.task.calculateTimeRemaining())
        }else{
            self.task.completeTask()
            self.setUpForNewTask()
            self.tableView.reloadData()
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
        var border: CGColor
        
        if taskManager.tasks.count > 0{
            task = taskManager.tasks[0]
            time = formatTimeString(time: task.time)
            name = task.title
            color = task.color
            border = task.color
        }else{
            name = "No More Tasks"
            time = "00:00:00"
            color = .clear
            border = .clear
        }
        
        timeRemainingLabel.stringValue = time
        taskName.stringValue = name
        
        outerCircularView.multiplier = 360/task.time
        
        print("THE COLOR \(color)")
        
        setCircleViews(color: color, border: border)
        
    }
    
    func closeColorPanel(){
        NSColorPanel.shared().orderOut(nil)
        newTaskColorButton.deactivate()
    }
    
    func setCircleViews(color: CGColor, border: CGColor){
        outerCircularView.layer?.cornerRadius = outerCircularView.frame.width/2
        innerCircularView.layer?.cornerRadius = innerCircularView.frame.width/2
        
        outerCircularView.layer?.borderWidth = 1.0
        outerCircularView.layer?.borderColor = border
        
        innerCircularView.layer?.borderWidth = 1.0
        innerCircularView.layer?.borderColor = border
        
        outerCircularView.layer?.backgroundColor = color
        innerCircularView.layer?.backgroundColor = .white
    }

}

