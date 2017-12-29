//
//  Created by Navneet on 12/21/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit
import BPViewsSubviewsInOutAnimation

class FirstViewController: BPViewController {    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bpEntryAnimationDirections = [.Top, .Left]
        self.bpExitAnimationDirections = [.Top, .Left]
    }
    
    @IBAction func loginTapped() {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
        self.bpPush(viewController: secondVC!)

    }


}

