//
//  ViewController.swift
//  ViewAnimation
//
//  Created by Navneet on 12/21/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit

class FirstViewController: BPViewController {    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginTapped() {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
        self.bpPush(viewController: secondVC!)

    }


}

