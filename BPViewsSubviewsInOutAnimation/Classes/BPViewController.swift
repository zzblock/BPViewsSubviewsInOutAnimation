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
            self.view.animateHalfWayTowardsRight(isAnimated: false)
            self.view.animateHalfWayTowardsLeft()
            
            didAnimateOnce = true
        } else {
            
            self.view.animateHalfWayTowardsRight()
        }
    }
    
    //MARK:- Animation view methods
    
    open func bpPresent(viewController: UIViewController) {
        self.view.animateHalfWayTowardsLeft {
            DispatchQueue.main.async {
                self.present(viewController, animated: true, completion: nil)
            }
            
        }
    }
    
    open func bpDismissViewController() {
        self.view.animateHalfWayTowardsRight {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    open func bpPush(viewController: UIViewController) {
        self.view.animateHalfWayTowardsLeft {
            DispatchQueue.main.async {
                if self.navigationController != nil {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }
    
    open func bpPopViewController() {
        self.view.animateHalfWayTowardsRight {
            DispatchQueue.main.async {
                if self.navigationController != nil {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

}
