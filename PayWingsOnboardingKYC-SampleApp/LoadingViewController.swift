//
//  LoadingViewController.swift
//  PayWingsOnboardingKYC-SampleApp
//
//  Created by tjasa on 08/07/2020.
//  Copyright © 2020 Intech. All rights reserved.
//

import UIKit
import PayWingsOnboardingKYC


class LoadingViewController : UIViewController, VerificationResultDelegate {
    
    
    var config: KycConfig!
    
    var result = VerificationResult()
    
    var kycSuccess: PayWingsOnboardingKYC.SuccessEvent?
    var kycError: PayWingsOnboardingKYC.ErrorEvent?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sample App"
        navigationItem.setHidesBackButton(true, animated: false)
        showLoading()
        
        result.delegate = self
        
        PayWingsOnboardingKyc.startKyc(vc: self, config: config, result: result)
    }
    
    
    func success(result: PayWingsOnboardingKYC.SuccessEvent) {
        kycSuccess = result
        performSegue(withIdentifier: "kycSeccess", sender: nil)
    }
    
    func error(result: PayWingsOnboardingKYC.ErrorEvent) {
        kycError = result
        performSegue(withIdentifier: "kycError", sender: nil)
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "kycSuccess" {
            guard let vc = segue.destination as? KycDataViewController else { return }
            vc.result = kycSuccess
        }
        else if segue.identifier == "kycError" {
            guard let vc = segue.destination as? KycErrorViewController else { return }
            vc.result = kycError
        }
    }
    
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
}
