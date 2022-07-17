//
//  VerificationResult.swift
//  PayWingsOnboardingKYC-SampleApp
//
//  Created by tjasa on 6/26/20.
//  Copyright © 2020 Intech. All rights reserved.
//

import UIKit
import PayWingsOnboardingKYC


struct KycResult {
    
    static var AppReferenceID : String?
    static var ReferenceNumber : String?
    static var KycReferenceID : String?
    static var KycID : String?
    static var PersonID : String?
    static var StatusCode : Int?
    static var StatusDescription : String?
}


public class VerificationResult : VerificationResultProtocol {
    
    init() {}
    
    
    public func success(event : SuccessEvent) -> Void {
        
        KycResult.AppReferenceID = event.getAppReferenceID()
        KycResult.ReferenceNumber = event.getReferenceNumber()
        KycResult.KycReferenceID = event.getKycReferenceID()
        KycResult.KycID = event.getKycID()
        KycResult.PersonID = event.getPersonID()
        
        goToResultScreen(success: true)
    }
    
    public func error(event: ErrorEvent) {
        
        KycResult.AppReferenceID = event.getAppReferenceID()
        KycResult.ReferenceNumber = event.getReferenceNumber()
        KycResult.KycReferenceID = event.getKycReferenceID()
        KycResult.KycID = event.getKycID()
        KycResult.PersonID = event.getPersonID()
        
        KycResult.StatusCode = event.getStatusCode()
        KycResult.StatusDescription = event.getStatusDescription()
        
        goToResultScreen(success: false)
        
    }
    
    
    func goToResultScreen(success: Bool) {
        
        var vc = String()
        if success {
            vc = "KycDataViewController"
        }
        else {
            vc = "KycErrorViewController"
        }
        
        let initStoryboard = UIStoryboard(name: vc, bundle: nil)
        let initVC = initStoryboard.instantiateViewController(withIdentifier: vc)
        
        let parent = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController as! UINavigationController
        let current = parent.children[0]
        
        current.navigationController?.pushViewController(initVC, animated: true)
        
    }
    
    
}


