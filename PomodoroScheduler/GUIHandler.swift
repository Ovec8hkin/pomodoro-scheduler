//
//  GUIHandler.swift
//  PomodoroScheduler
//
//  Created by Joshua Zahner on 4/11/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import Cocoa

class GUIHandler: NSObject {
    
    @IBOutlet var progressView: ProgressCircleView!
    
    func handleProgress(sender: NSButton, time: TimeInterval){
        
        print("handling progress")
        print(time/10)
        
        progressView.time = time
        
        DispatchQueue.global(qos: .background).async {
            
            for i in 0...Int(time*100){
                
                self.progressView.progress = Double(i)
                Thread.sleep(forTimeInterval: 0.00042)
                DispatchQueue.main.async {
                    self.progressView.needsDisplay = true
                }
                
            }
            
        }

    }
    
    /*func progressUpdate(){
        for i in 0...100{
            progressView.progress = Double(i)
            Thread.sleep(forTimeInterval: 0.05)
            progressView.needsDisplay = true
        }
    }*/

}
