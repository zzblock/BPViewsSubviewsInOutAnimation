//
//  BPAnimateViewContentExtension.swift
//  ViewAnimation
//
//  Created by Navneet on 12/21/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit

extension UIView {
    
    public enum BpPosition {
        case Top
        case Right
        case Bottom
        case Left
        case Center
    }
    
    enum Axis {
        case Vertical
        case Horizontal
    }
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    private struct VarKeys {
        static var delayKey: UInt8 = 0
        static var positionKey: UInt8 = 1
        static var axisKey: UInt8 = 3
        static var animationDurationKey: UInt8 = 4
    }
    
    
    
    
    private var animationDuration: CGFloat {
        get {
            guard let value = objc_getAssociatedObject(self, &VarKeys.animationDurationKey) as? CGFloat else {
                return 0.5
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &VarKeys.animationDurationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @IBInspectable
    open var BPAnimationDuration: CGFloat {
        get {
            return self.animationDuration
        }
        set {
            self.animationDuration = newValue
        }
    }
    
    
    
    
    private var currentPosition: BpPosition {
        get {
            guard let value = objc_getAssociatedObject(self, &VarKeys.positionKey) as? BpPosition else {
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
    
    
    
    
    private var animationAxis: Axis {
        get {
            guard let value = objc_getAssociatedObject(self, &VarKeys.axisKey) as? Axis else {
                return .Horizontal
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &VarKeys.axisKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @IBInspectable
    open var BPAnimateAxisOnVerticalAndOffHorizontal: Bool {
        get {
            return self.animationAxis == .Horizontal ? false : true
        }
        set {
            self.animationAxis = newValue == false ? .Horizontal : .Vertical
        }
    }
    
    
    
    
    //MARK:- Animation methods
    
    //MARK: Horizontal
    
    open func animateHalfWayTowardsLeft(for predefinedViews: Array<UIView>? = nil, isAnimated: Bool = true, completionHandler: @escaping () -> Void = {}) {
        
        let halfWayLeft = {
            
            //Set position for parentView and loop will run for all the subviews (in this case predefined views is nil)
            if predefinedViews == nil {
                switch self.currentPosition {
                case .Left:
                    return
                case .Center:
                    self.currentPosition = .Left
                case .Right:
                    self.currentPosition = .Center
                case .Top:
                    return
                case .Bottom:
                    return
                }
            }
            
            var animationCompleted: Int = 0
            var animationCounter: Int = 0
            
            for view in predefinedViews ?? self.subviews {
                
                if predefinedViews == nil {
                    view.animateHalfWayTowardsLeft(isAnimated: isAnimated)
                } else {
                    //Set position for all predefined views
                    if view.animationAxis == .Horizontal {
                        switch view.currentPosition {
                        case .Left:
                            if view == predefinedViews?.last {
                                completionHandler()
                            }
                            continue
                        case .Center:
                            view.currentPosition = .Left
                        case .Right:
                            view.currentPosition = .Center
                        default:
                            if view == predefinedViews?.last {
                                completionHandler()
                            }
                            continue
                        }
                    }
                }
                
                if view.animationAxis != .Horizontal {
                    continue
                }
                
                if view.BPDelay == NSNotFound {
                    continue
                } else {
                    
                    animationCounter = animationCounter + 1
                    
                    if isAnimated {
                        
                        UIView.animate(withDuration: TimeInterval(view.animationDuration),
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
                        
                        animationCompleted = animationCompleted + 1
                        if animationCounter == animationCompleted {
                            completionHandler()
                        }
                        
                    }
                }
                
            }
            
            if predefinedViews != nil && predefinedViews?.count == 0 {
                completionHandler()
            }
        }
        
        if Thread.isMainThread {
            halfWayLeft()
        } else {
            DispatchQueue.main.sync {
                halfWayLeft()
            }
        }
    }
    
    open func animateHalfWayTowardsRight(for predefinedViews: Array<UIView>? = nil, isAnimated: Bool = true, completionHandler: @escaping () -> Void = {}) {
        
        let halfWayRight = {
            
            //Set position for parentView and loop will run for all the subviews (in this case predefined views is nil)
            if predefinedViews == nil {
                switch self.currentPosition {
                case .Right:
                    return
                case .Center:
                    self.currentPosition = .Right
                case .Left:
                    self.currentPosition = .Center
                case .Top:
                    return
                case .Bottom:
                    return
                }
            }
            
            var animationCompleted: Int = 0
            var animationCounter: Int = 0
            
            for view in predefinedViews ?? self.subviews {
                
                if predefinedViews == nil {
                    view.animateHalfWayTowardsRight(isAnimated: isAnimated)
                } else {
                    //Set position for all predefined views
                    if view.animationAxis == .Horizontal {
                        switch view.currentPosition {
                        case .Left:
                            view.currentPosition = .Center
                        case .Center:
                            view.currentPosition = .Right
                        case .Right:
                            if view == predefinedViews?.last {
                                completionHandler()
                            }
                            continue
                        default:
                            if view == predefinedViews?.last {
                                completionHandler()
                            }
                            continue
                        }
                    }
                }
                
                if view.animationAxis != .Horizontal {
                    continue
                }
                
                if view.BPDelay == NSNotFound {
                    continue
                } else {
                    
                    animationCounter = animationCounter + 1
                    
                    if isAnimated {
                        
                        UIView.animate(withDuration: TimeInterval(view.animationDuration),
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
                        
                        animationCompleted = animationCompleted + 1
                        if animationCounter == animationCompleted {
                            completionHandler()
                        }
                    }
                    
                }
                
            }
            
            if predefinedViews != nil && predefinedViews?.count == 0 {
                completionHandler()
            }
        }
        
        if Thread.isMainThread {
            halfWayRight()
        } else {
            DispatchQueue.main.sync {
                halfWayRight()
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
    
    //MARK: Vertical
    
    open func animateHalfWayTowardsTop(for predefinedViews: Array<UIView>? = nil, isAnimated: Bool = true, completionHandler: @escaping () -> Void = {}) {
        
        let halfWayTop = {
            
            //Set position for parentView and loop will run for all the subviews (in this case predefined views is nil)
            if predefinedViews == nil {
                switch self.currentPosition {
                case .Top:
                    return
                case .Center:
                    self.currentPosition = .Top
                case .Bottom:
                    self.currentPosition = .Center
                case .Right:
                    return
                case .Left:
                    return
                }
            }
            
            var animationCompleted: Int = 0
            var animationCounter: Int = 0
            
            for view in predefinedViews ?? self.subviews {
                
                if predefinedViews == nil {
                    view.animateHalfWayTowardsTop(isAnimated: isAnimated)
                } else {
                    //Set position for all predefined views
                    if view.animationAxis == .Vertical {
                        switch view.currentPosition {
                        case .Top:
                            if view == predefinedViews?.last {
                                completionHandler()
                            }
                            continue
                        case .Center:
                            view.currentPosition = .Top
                        case .Bottom:
                            view.currentPosition = .Center
                        default:
                            if view == predefinedViews?.last {
                                completionHandler()
                            }
                            continue
                        }
                    }
                }
                
                if view.animationAxis != .Vertical {
                    continue
                }
                
                if view.BPDelay == NSNotFound {
                    continue
                } else {
                    
                    animationCounter = animationCounter + 1
                    
                    if isAnimated {
                        
                        UIView.animate(withDuration: TimeInterval(view.animationDuration),
                                       delay: TimeInterval(CGFloat(view.BPDelay) * 0.25),
                                       options: UIViewAnimationOptions.curveEaseInOut,
                                       animations: {
                                        view.frame.origin.y = view.frame.origin.y - UIView.screenHeight
                                        
                                        if !(0...UIView.screenHeight ~= view.frame.origin.y) {
                                            view.alpha = 0
                                        }
                                        
                        }, completion: { (completed) in
                            animationCompleted = animationCompleted + 1
                            if animationCounter == animationCompleted {
                                completionHandler()
                            }
                        })
                        
                    } else {
                        view.frame.origin.y = view.frame.origin.y - UIView.screenHeight
                        
                        if !(0...UIView.screenHeight ~= view.frame.origin.y) {
                            view.alpha = 0
                        }
                        
                        animationCompleted = animationCompleted + 1
                        if animationCounter == animationCompleted {
                            completionHandler()
                        }
                        
                    }
                }
                
            }
            
            if predefinedViews != nil && predefinedViews?.count == 0 {
                completionHandler()
            }
        }
        
        if Thread.isMainThread {
            halfWayTop()
        } else {
            DispatchQueue.main.sync {
                halfWayTop()
            }
        }
    }
    
    open func animateHalfWayTowardsBottom(for predefinedViews: Array<UIView>? = nil, isAnimated: Bool = true, completionHandler: @escaping () -> Void = {}) {
        
        let halfWayBottom = {
            
            //Set position for parentView and loop will run for all the subviews (in this case predefined views is nil)
            if predefinedViews == nil {
                switch self.currentPosition {
                case .Bottom:
                    return
                case .Center:
                    self.currentPosition = .Bottom
                case .Top:
                    self.currentPosition = .Center
                case .Right:
                    return
                case .Left:
                    return
                }
            }
            
            var animationCompleted: Int = 0
            var animationCounter: Int = 0
            
            for view in predefinedViews ?? self.subviews {
                
                if predefinedViews == nil {
                    view.animateHalfWayTowardsBottom(isAnimated: isAnimated)
                } else {
                    //Set position for all predefined views
                    if view.animationAxis == .Vertical {
                        switch view.currentPosition {
                        case .Top:
                            view.currentPosition = .Center
                        case .Center:
                            view.currentPosition = .Bottom
                        case .Bottom:
                            if view == predefinedViews?.last {
                                completionHandler()
                            }
                            continue
                        default:
                            if view == predefinedViews?.last {
                                completionHandler()
                            }
                            continue
                        }
                    }
                }
                
                if view.animationAxis != .Vertical {
                    continue
                }
                
                if view.BPDelay == NSNotFound {
                    continue
                } else {
                    
                    animationCounter = animationCounter + 1
                    
                    if isAnimated {
                        
                        UIView.animate(withDuration: TimeInterval(view.animationDuration),
                                       delay: TimeInterval(CGFloat(view.BPDelay) * 0.25),
                                       options: UIViewAnimationOptions.curveEaseInOut,
                                       animations: {
                                        view.frame.origin.y = view.frame.origin.y + UIView.screenHeight
                                        
                                        view.alpha = 1
                                        
                                        
                        }, completion: { (completed) in
                            animationCompleted = animationCompleted + 1
                            if animationCounter == animationCompleted {
                                completionHandler()
                            }
                        })
                        
                    } else {
                        view.frame.origin.y = view.frame.origin.y + UIView.screenHeight
                        view.alpha = 1
                        
                        animationCompleted = animationCompleted + 1
                        if animationCounter == animationCompleted {
                            completionHandler()
                        }
                    }
                    
                }
            }
            
            if predefinedViews != nil && predefinedViews?.count == 0 {
                completionHandler()
            }
        }
        
        if Thread.isMainThread {
            halfWayBottom()
        } else {
            DispatchQueue.main.sync {
                halfWayBottom()
            }
        }
    }
    
    open func animateToCenterFromTop(completionHandler: @escaping () -> Void = {}) {
        self.animateHalfWayTowardsTop(isAnimated: false)
        self.animateHalfWayTowardsTop(isAnimated: false)
        
        self.animateHalfWayTowardsBottom {
            completionHandler()
        }
    }
    
    open func animateToCenterFromBottom(completionHandler: @escaping () -> Void = {}) {
        self.animateHalfWayTowardsBottom(isAnimated: false)
        self.animateHalfWayTowardsBottom(isAnimated: false)
        
        self.animateHalfWayTowardsTop {
            completionHandler()
        }
    }
    
    open func animateSubViewsToCenter(directions: Array<BpPosition>, isAnimated: Bool = true, completionHandler: @escaping () -> Void = {}) {
        
        var completionCount = 0
        
        let localCompletionBlock = {
            completionCount = completionCount + 1
            if completionCount >= directions.count {
                completionHandler()
            }
        }
        
        
        let viewsToAnimate: Array<UIView> = fetchAllViewsToAnimate(under: self)
        
        for direction in directions {
            switch direction {
            case .Top:
                let topViews = viewsToAnimate.filter{
                    $0.currentPosition == .Top
                }
                self.animateHalfWayTowardsBottom(for: topViews, isAnimated: isAnimated, completionHandler: {
                    localCompletionBlock()
                })
            case .Right:
                let rightViews = viewsToAnimate.filter{
                    $0.currentPosition == .Right
                }
                self.animateHalfWayTowardsLeft(for: rightViews, isAnimated: isAnimated, completionHandler: {
                    localCompletionBlock()
                })
            case .Bottom:
                let bottomViews = viewsToAnimate.filter{
                    $0.currentPosition == .Bottom
                }
                self.animateHalfWayTowardsTop(for: bottomViews, isAnimated: isAnimated, completionHandler: {
                    localCompletionBlock()
                })
            case .Left:
                let leftViews = viewsToAnimate.filter{
                    $0.currentPosition == .Left
                }
                self.animateHalfWayTowardsRight(for: leftViews, isAnimated: isAnimated, completionHandler: {
                    localCompletionBlock()
                })
                
            default:
                continue
            }
        }
    }
    
    open func animateSubViewsAwayFromCenter(towards directions: Array<BpPosition>, isAnimated: Bool = true, completionHandler: @escaping () -> Void = {}) {
        
        var completionCount = 0
        
        let localCompletionBlock = {
            completionCount = completionCount + 1
            if completionCount >= directions.count {
                completionHandler()
            }
        }
        
        
        let viewsToAnimate: Array<UIView> = fetchAllViewsToAnimate(under: self)
        
        let verticalViews = viewsToAnimate.filter{
            $0.animationAxis == .Vertical
        }
        let horizontalViews = viewsToAnimate.filter{
            $0.animationAxis == .Horizontal
        }
        
        for direction in directions {
            switch direction {
            case .Top:
                self.animateHalfWayTowardsTop(for: verticalViews, isAnimated: isAnimated, completionHandler: {
                    self.animateHalfWayTowardsTop(for: verticalViews, isAnimated: isAnimated, completionHandler: {
                        localCompletionBlock()
                    })
                })
            case .Right:
                self.animateHalfWayTowardsRight(for: horizontalViews, isAnimated: isAnimated, completionHandler: {
                    self.animateHalfWayTowardsRight(for: horizontalViews, isAnimated: isAnimated, completionHandler: {
                        localCompletionBlock()
                    })
                })
            case .Bottom:
                self.animateHalfWayTowardsBottom(for: verticalViews, isAnimated: isAnimated, completionHandler: {
                    self.animateHalfWayTowardsBottom(for: verticalViews, isAnimated: isAnimated, completionHandler: {
                        localCompletionBlock()
                    })
                })
            case .Left:
                self.animateHalfWayTowardsLeft(for: horizontalViews, isAnimated: isAnimated, completionHandler: {
                    self.animateHalfWayTowardsLeft(for: horizontalViews, isAnimated: isAnimated, completionHandler: {
                        localCompletionBlock()
                    })
                })
                
            default:
                continue
            }
        }
    }
    
    func fetchAllViewsToAnimate(under containerView: UIView) -> Array<UIView> {
        
        var viewsToAnimate: Array<UIView> = []
        
        for view in self.subviews {
            
            let subViews = view.fetchAllViewsToAnimate(under: view)
            viewsToAnimate.append(contentsOf: subViews)
            
            if view.BPDelay == NSNotFound {
                continue
            } else {
                viewsToAnimate.append(view)
            }
        }
        
        return viewsToAnimate
    }
    
}
