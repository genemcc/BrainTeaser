//
//  LoginVC.swift
//  BrainTeaser
//
//  Created by Gene McCullagh on 3/27/16.
//  Copyright © 2016 Gene McCullagh. All rights reserved.
//

import UIKit
import pop

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginConstraint: NSLayoutConstraint!
    
    var animEngine: AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, loginConstraint])
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.animEngine.animateOnScreen(1)
    }
}


