//
//  SecondViewController.swift
//  ViewAnimation
//
//  Created by Navneet on 12/21/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit

class SecondViewController: BPViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dismiss() {
        self.bpPopViewController()
    }
    
    @IBAction func push() {
        let thirdVC = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController")
        self.bpPush(viewController: thirdVC!)
    }

}
