//
//  SlideRightAnimation.swift
//  PomodoroScheduler
//
//  Created by Joshua Zahner on 4/8/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import Cocoa

class SlideRightAnimation: NSObject, NSViewControllerPresentationAnimator{
    
    func animatePresentation(of: NSViewController, from: NSViewController) {
        
        let viewController = of
        let fromViewController = from
        
        if let window = fromViewController.view.window {
            NSAnimationContext.runAnimationGroup({ (context) -> Void in
                fromViewController.view.animator().alphaValue = 0
            }, completionHandler: { () -> Void in
                viewController.view.alphaValue = 0
                window.contentViewController = viewController
                viewController.view.animator().alphaValue = 1.0
            })
        }
    }
    
    func animateDismissal(of: NSViewController, from: NSViewController) {
        
        let viewController = of
        let fromViewController = from
        
        if let window = viewController.view.window {
            NSAnimationContext.runAnimationGroup({ (context) -> Void in
                viewController.view.animator().alphaValue = 0
            }, completionHandler: { () -> Void in
                fromViewController.view.alphaValue = 0
                window.contentViewController = fromViewController
                fromViewController.view.animator().alphaValue = 1.0
            })
        }
    }
    
    
}
