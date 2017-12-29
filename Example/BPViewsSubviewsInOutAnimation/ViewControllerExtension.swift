//
//  Created by Navneet on 12/29/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
