//
//  TaskManager.swift
//  PomodoroScheduler
//
//  Created by Joshua Zahner on 4/8/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import Cocoa

class TaskManager{
    
    static var instance = TaskManager()
    
    var tasks: [Task] = []{
        didSet{
            print(tasks)
        }
    }
    
    func addTask(task: Task){
        
        if task.time > 0{
            tasks.append(task)
        }
        
    }
    
    func removeTask(task: Task){
        tasks.remove(at: tasks.index(of: task)!)
    }
    
}
