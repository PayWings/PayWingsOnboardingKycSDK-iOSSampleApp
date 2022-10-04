//
//  KycDataViewController.swift
//  PayWingsOnboardingKYC-SampleApp
//
//  Created by tjasa on 20/07/2020.
//  Copyright © 2020 Intech. All rights reserved.
//

import UIKit
import PayWingsOnboardingKYC


class KycDataViewController : UIViewController {
    
    
    var result: PayWingsOnboardingKYC.SuccessEvent!
    
    @IBOutlet weak var KycTitle: UILabel!
    
    @IBOutlet weak var AppReferenceID: KycTextLabel!
    @IBOutlet weak var ReferenceNumber: KycTextLabel!
    @IBOutlet weak var KycReferenceID: KycTextLabel!
    @IBOutlet weak var KycID: KycTextLabel!
    @IBOutlet weak var PersonID: KycTextLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sample App"
        navigationItem.setHidesBackButton(true, animated: false)
        
        KycTitle.text = "KYC Successful"
        KycTitle.textColor = .systemGreen
        
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
    }
    
    
    @IBAction func onClose(_ sender: Any) {
        showLoading()
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
