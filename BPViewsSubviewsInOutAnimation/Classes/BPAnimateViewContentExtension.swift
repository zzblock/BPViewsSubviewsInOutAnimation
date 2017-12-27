//
//  BPAnimateViewContentExtension.swift
//  ViewAnimation
//
//  Created by Navneet on 12/21/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit

extension UIView {
    
    enum Position {
        case Right
        case Left
        case Center
    }
    
    static let screenWidth = UIScreen.main.bounds.width
    
    private struct VarKeys {
        static var delayKey: UInt8 = 0
        static var positionKey: UInt8 = 1
    }
    
    private var currentPosition: Position {
        get {
            guard let value = objc_getAssociatedObject(self, &VarKeys.positionKey) as? Position else {
                return .Center
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &VarKeys.positionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var delay: Int {
        get {
            guard let value = objc_getAssociatedObject(self, &VarKeys.delayKey) as? Int else {
                return NSNotFound
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &VarKeys.delayKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @IBInspectable
    open var BPDelay: Int {
        get {
            return self.delay
        }
        set {
            self.delay = newValue
        }
    }
    
    //MARK:- Animation methods
    
    open func animateHalfWayTowardsLeft(isAnimated: Bool = true, completionHandler: @escaping () -> Void = {}) {
        switch currentPosition {
        case .Left:
            return
        case .Center:
            currentPosition = .Left
        case .Right:
            currentPosition = .Center
        }
        
        var animationCompleted: Int = 0
        var animationCounter: Int = 0
        
        for view in self.subviews {
            
            view.animateHalfWayTowardsLeft(isAnimated: isAnimated)
            
            if view.BPDelay == NSNotFound {
                continue
            } else {
                
                animationCounter = animationCounter + 1
                
                if isAnimated {
                    
                    UIView.animate(withDuration: 0.5,
                                   delay: TimeInterval(CGFloat(view.BPDelay) * 0.25),
                                   options: UIViewAnimationOptions.curveEaseInOut,
                                   animations: {
                                    view.frame.origin.x = view.frame.origin.x - UIView.screenWidth
                                    
                                    if !(0...UIView.screenWidth ~= view.frame.origin.x) {
                                        view.alpha = 0
                                    }
                                    
                    }, completion: { (completed) in
                        animationCompleted = animationCompleted + 1
                        if animationCounter == animationCompleted {
                            completionHandler()
                        }
                    })
                    
                } else {
                    view.frame.origin.x = view.frame.origin.x - UIView.screenWidth
                    
                    if !(0...UIView.screenWidth ~= view.frame.origin.x) {
                        view.alpha = 0
                    }
                    
                }
            }
            
        }
        
    }
    
    open func animateHalfWayTowardsRight(isAnimated: Bool = true, completionHandler: @escaping () -> Void = {}) {
        switch currentPosition {
        case .Right:
            return
        case .Center:
            currentPosition = .Right
        case .Left:
            currentPosition = .Center
        }
        
        var animationCompleted: Int = 0
        var animationCounter: Int = 0
        
        for view in self.subviews {
            
            view.animateHalfWayTowardsRight(isAnimated: isAnimated)
            
            if view.BPDelay == NSNotFound {
                continue
            } else {
                
                animationCounter = animationCounter + 1
                
                if isAnimated {
                    
                    UIView.animate(withDuration: 0.5,
                                   delay: TimeInterval(CGFloat(view.BPDelay) * 0.25),
                                   options: UIViewAnimationOptions.curveEaseInOut,
                                   animations: {
                                    view.frame.origin.x = view.frame.origin.x + UIView.screenWidth
                                    
                                    view.alpha = 1
                                    
                                    
                    }, completion: { (completed) in
                        animationCompleted = animationCompleted + 1
                        if animationCounter == animationCompleted {
                            completionHandler()
                        }
                    })
                    
                } else {
                    view.frame.origin.x = view.frame.origin.x + UIView.screenWidth
                    view.alpha = 1
                }
                
            }
            
        }
    }
    
    open func animateToCenterFromLeft(completionHandler: @escaping () -> Void = {}) {
        self.animateHalfWayTowardsLeft(isAnimated: false)
        self.animateHalfWayTowardsLeft(isAnimated: false)
        
        self.animateHalfWayTowardsRight {
            completionHandler()
        }
    }
    
    open func animateToCenterFromRight(completionHandler: @escaping () -> Void = {}) {
        self.animateHalfWayTowardsRight(isAnimated: false)
        self.animateHalfWayTowardsRight(isAnimated: false)
        
        self.animateHalfWayTowardsLeft {
            completionHandler()
        }
    }
    
}
