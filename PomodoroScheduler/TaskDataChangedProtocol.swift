//
//  TaskDataChangedProtocol.swift
//  PomodoroScheduler
//
//  Created by Joshua Zahner on 4/8/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import Cocoa

protocol TaskDataChanged: class{
    
    func taskTimeChanged(time: TimeInterval)
    func taskColorChanged(color: CGColor)
    
}
