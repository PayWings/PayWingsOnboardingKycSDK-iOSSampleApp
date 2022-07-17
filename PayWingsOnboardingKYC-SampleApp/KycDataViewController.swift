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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Close", comment: ""), style: .plain, target: self, action: #selector(onClose))
        
        KycTitle.text = "KYC Successful"
        KycTitle.textColor = .systemGreen
        
        setKycValues()

    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func setKycValues() {
        
        AppReferenceID.text = "AppReferenceID: " + (KycResult.AppReferenceID ?? "")
        ReferenceNumber.text = "ReferenceNumber: " + (KycResult.ReferenceNumber ?? "")
        KycReferenceID.text = "KycReferenceID: " + (KycResult.KycReferenceID ?? "")
        KycID.text = "KycID: " + (KycResult.KycID ?? "")
        PersonID.text = "PersonID: " + (KycResult.PersonID ?? "")
    }
    
    
    @objc func onClose(_ sender: Any) {
        showLoading(vc: self)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}
