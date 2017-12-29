//
//  BPViewController.swift
//  ViewAnimation
//
//  Created by Navneet on 12/21/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit

open class BPViewController: UIViewController {
    
    open var bpEntryAnimationDirections: Array<UIView.BpPosition>?
    open var bpExitAnimationDirections: Array<UIView.BpPosition>?
    
    private var didAnimateOnce : Bool = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !didAnimateOnce {
            let entryDirections = bpEntryAnimationDirections ?? [.Right, .Bottom]
            self.view.animateSubViewsAwayFromCenter(towards: entryDirections, isAnimated: false, completionHandler: {
                self.view.animateSubViewsToCenter(directions: entryDirections)
            })
            didAnimateOnce = true
        } else {
            let entryDirections = bpEntryAnimationDirections ?? [.Left, .Bottom]
            self.view.animateSubViewsAwayFromCenter(towards: entryDirections, isAnimated: false, completionHandler: {
                self.view.animateSubViewsToCenter(directions: entryDirections)
            })
        }
    }
    
    //MARK:- Animation view methods
    
    open func bpPresent(viewController: UIViewController, with directions: Array<UIView.BpPosition>? = nil, animated: Bool = false) {
        self.view.animateSubViewsAwayFromCenter(towards: (directions ?? self.bpExitAnimationDirections) ?? [.Left, .Bottom]) {
            DispatchQueue.main.async {
                self.present(viewController, animated: animated, completion: nil)
            }
        }
    }
    
    open func bpDismissViewController(animated: Bool = false, with directions: Array<UIView.BpPosition>? = nil) {
        self.view.animateSubViewsAwayFromCenter(towards: (directions ?? self.bpExitAnimationDirections) ?? [.Left, .Bottom]) {
            DispatchQueue.main.async {
                self.dismiss(animated: animated, completion: nil)
            }
        }
    }
    
    open func bpPush(viewController: UIViewController, with directions: Array<UIView.BpPosition>? = nil, animated: Bool = false) {
        self.view.animateSubViewsAwayFromCenter(towards: (directions ?? self.bpExitAnimationDirections) ?? [.Left, .Bottom]) {
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: animated)
            }
        }
    }
    
    open func bpPopViewController(animated: Bool = false, with directions: Array<UIView.BpPosition>? = nil) {
        self.view.animateSubViewsAwayFromCenter(towards: (directions ?? self.bpExitAnimationDirections) ?? [.Left, .Bottom]) {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: animated)
            }
        }
    }

}
