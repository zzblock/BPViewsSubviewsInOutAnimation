//
//  BPViewController.swift
//  ViewAnimation
//
//  Created by Navneet on 12/21/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit

class BPViewController: UIViewController {

    private var didAnimateOnce : Bool = false
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    func bpPresent(viewController: UIViewController) {
        self.view.animateHalfWayTowardsLeft {
            DispatchQueue.main.async {
                self.present(viewController, animated: true, completion: nil)
            }
            
        }
    }
    
    func bpDismissViewController() {
        self.view.animateHalfWayTowardsRight {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    func bpPush(viewController: UIViewController) {
        self.view.animateHalfWayTowardsLeft {
            DispatchQueue.main.async {
                if self.navigationController != nil {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }
    
    func bpPopViewController() {
        self.view.animateHalfWayTowardsRight {
            DispatchQueue.main.async {
                if self.navigationController != nil {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

}
