//
//  LoadingViewController.swift
//  PayWingsOnboardingKYC-SampleApp
//
//  Created by tjasa on 08/07/2020.
//  Copyright © 2020 Intech. All rights reserved.
//

import UIKit


class LoadingViewController : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sample App"
        navigationItem.setHidesBackButton(true, animated: false)
        
        showLoading(vc: self)
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    

    
}
