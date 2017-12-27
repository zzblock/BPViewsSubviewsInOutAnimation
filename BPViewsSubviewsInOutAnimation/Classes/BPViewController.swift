//
//  BPViewController.swift
//  ViewAnimation
//
//  Created by Navneet on 12/21/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit

open class BPViewController: UIViewController {

    private var didAnimateOnce : Bool = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if !didAnimateOnce {
            self.view.animateToCenterFromRight()
            didAnimateOnce = true
        } else {
            self.view.animateToCenterFromLeft()
        }
    }
    
    //MARK:- Animation view methods
    
    open func bpPresent(viewController: UIViewController, animated: Bool = false) {
        self.view.animateHalfWayTowardsLeft {
            DispatchQueue.main.async {
                self.present(viewController, animated: animated, completion: nil)
            }
        }
    }
    
    open func bpDismissViewController(animated: Bool = false) {
        self.view.animateHalfWayTowardsRight {
            DispatchQueue.main.async {
                self.dismiss(animated: animated, completion: nil)
            }
            
        }
    }
    
    open func bpPush(viewController: UIViewController, animated: Bool = false) {
        self.view.animateHalfWayTowardsLeft {
            DispatchQueue.main.async {
                if self.navigationController != nil {
                    self.navigationController?.pushViewController(viewController, animated: animated)
                }
            }
        }
    }
    
    open func bpPopViewController(animated: Bool = false) {
        self.view.animateHalfWayTowardsRight {
            DispatchQueue.main.async {
                if self.navigationController != nil {
                    self.navigationController?.popViewController(animated: animated)
                }
            }
        }
    }

}
