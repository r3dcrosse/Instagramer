//
//  CamPickerSeg.swift
//  Instagramer
//
//  Created by David Wayman on 3/3/16.
//  Copyright © 2016 David Wayman. All rights reserved.
//

import UIKit

class CamPickerSeg: UIViewController {
    
    var goToCamera: Bool = true

    override func viewWillAppear(animated: Bool) {
        if goToCamera {
            // Go to the camera image picker
            self.performSegueWithIdentifier("camSegue", sender: nil)
            goToCamera = false
        } else {
            // Go back to the first tab of the tab bar controller
            self.tabBarController?.selectedIndex = 0
            goToCamera = true
        }
    }
}
