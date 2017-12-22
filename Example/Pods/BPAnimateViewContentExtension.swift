//
//  BPAnimateViewContentExtension.swift
//  ViewAnimation
//
//  Created by Navneet on 12/21/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit

extension UIView {
    
    static let screenWidth = UIScreen.main.bounds.width
    
    private struct AnimationKeys {
        static var delayKey: UInt8 = 0
    }
    
    private var delay: Int {
        get {
            guard let value = objc_getAssociatedObject(self, &AnimationKeys.delayKey) as? Int else {
                return NSNotFound
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AnimationKeys.delayKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @IBInspectable
    var BPDelay: Int {
        get {
            return self.delay
        }
        set {
            self.delay = newValue
        }
    }
    
    //MARK:- Animation methods
    
    func animateHalfWayTowardsLeft(isAnimated: Bool = true, completionHandler: @escaping () -> Void = {}) {
        
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
    
    func animateHalfWayTowardsRight(isAnimated: Bool = true, completionHandler: @escaping () -> Void = {}) {
        
        var animationCompleted: Int = 0
        var animationCounter: Int = 0
        
        for view in self.subviews {
            
            view.animateHalfWayTowardsRight(isAnimated: isAnimated)
            
            if view.BPDelay == NSNotFound {
                continue
            } else {
                print("Found\n\n")
                
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
    
}
