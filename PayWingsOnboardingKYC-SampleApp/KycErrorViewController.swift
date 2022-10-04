//
//  KycErrorViewController.swift
//  PayWingsOnboardingKYC-SampleApp
//
//  Created by tjasa on 20/07/2020.
//  Copyright © 2020 Intech. All rights reserved.
//

import UIKit
import PayWingsOnboardingKYC


class KycErrorViewController : UIViewController {
    
    
    var result: PayWingsOnboardingKYC.ErrorEvent!
    
    @IBOutlet weak var RestartKycButton: UIButton!
    
    @IBOutlet weak var AppReferenceID: KycTextLabel!
    @IBOutlet weak var ReferenceNumber: KycTextLabel!
    @IBOutlet weak var KycReferenceID: KycTextLabel!
    @IBOutlet weak var KycID: KycTextLabel!
    @IBOutlet weak var PersonID: KycTextLabel!
    @IBOutlet weak var ErrorDescription: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sample App"
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        setKycValues()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func setKycValues() {
        
        AppReferenceID.text = "AppReferenceID: " + (result.AppReferenceID ?? "")
        ReferenceNumber.text = "ReferenceNumber: " + (result.ReferenceNumber ?? "")
        KycReferenceID.text = "KycReferenceID: " + (result.KycReferenceID ?? "")
        KycID.text = "KycID: " + (result.KycID ?? "")
        PersonID.text = "PersonID: " + (result.PersonID ?? "")
        ErrorDescription.text = "ErrorDescription: " + result.StatusDescription
    }
    
    
    @IBAction func onRestartKyc(_ sender: Any) {
        showLoading()
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
