//
//  LoadingViewController.swift
//  PayWingsOnboardingKYC-SampleApp
//
//  Created by tjasa on 08/07/2020.
//  Copyright © 2020 Intech. All rights reserved.
//

import UIKit
import PayWingsOnboardingKYC
import AVFoundation


class LoadingViewController : UIViewController, VerificationResultDelegate {
    
    
    var credentials : KycCredentials?
    var settings : KycSettings?
    var userData : KycUserData?
    var userCredentials : UserCredentials?
    
    var result = VerificationResult()
    
    var kycSuccess: PayWingsOnboardingKYC.SuccessEvent?
    var kycError: PayWingsOnboardingKYC.ErrorEvent?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sample App"
        navigationItem.setHidesBackButton(true, animated: false)
        showLoading()
        
        result.delegate = self
        
        checkCameraPermission()
    }
    
    
    func goToKyc() {
        getKycSettings()
        
        DispatchQueue.main.async {
            let cameraAuthorized = (AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized) ? true : false
            let microphoneAuthorized = (AVCaptureDevice.authorizationStatus(for: AVMediaType.audio) == .authorized) ? true : false
            
            if cameraAuthorized && microphoneAuthorized {
                
                let config = KycConfig(credentials: self.credentials!, settings: self.settings!, userData: self.userData, userCredentials: self.userCredentials)
                PayWingsOnboardingKyc.startKyc(vc: self, config: config, result: self.result)
            }
        }
    }
    
    
    func getKycSettings() {
        
        let sdkUsername = UserDefaults.standard.string(forKey: "sdk_api_username") ?? ""
        let sdkPassword = UserDefaults.standard.string(forKey: "sdk_api_password") ?? ""
        let sdkBaseUrl = UserDefaults.standard.string(forKey: "sdk_api_url") ?? ""
        let apiKey = UserDefaults.standard.string(forKey: "api_key") ?? ""
        
        credentials = KycCredentials(username: sdkUsername, password: sdkPassword, endpointUrl: sdkBaseUrl)
        
        let referenceId = UUID().uuidString
        let referenceNumber = UserDefaults.standard.string(forKey: "reference_number") ?? ""
        let language = UserDefaults.standard.string(forKey: "language_preference") ?? ""
        
        settings = KycSettings(referenceID: referenceId, referenceNumber: referenceNumber, language: language)
        
        let firstName = UserDefaults.standard.string(forKey: "data_first_name") ?? nil
        let middleName = UserDefaults.standard.string(forKey: "data_middle_name") ?? nil
        let lastName = UserDefaults.standard.string(forKey: "data_last_name") ?? nil
        let address1 = UserDefaults.standard.string(forKey: "data_address1") ?? nil
        let address2 = UserDefaults.standard.string(forKey: "data_address2") ?? nil
        let address3 = UserDefaults.standard.string(forKey: "data_address3") ?? nil
        let zipCode = UserDefaults.standard.string(forKey: "data_zip_code") ?? nil
        let city = UserDefaults.standard.string(forKey: "data_city") ?? nil
        let state = UserDefaults.standard.string(forKey: "data_state") ?? nil
        let countryCode = UserDefaults.standard.string(forKey: "data_country_code") ?? nil
        let email = UserDefaults.standard.string(forKey: "data_email") ?? nil
        let mobileNumber = UserDefaults.standard.string(forKey: "data_phone_number") ?? nil

        userData = KycUserData(firstName: firstName, middleName: middleName, lastName: lastName, address1: address1, address2: address2, address3: address3, zipCode: zipCode, city: city, state: state, countryCode: countryCode, email: email, mobileNumber: mobileNumber)
        
        if let token = AppData.shared().accessToken {
            userCredentials = UserCredentials(accessToken: token, refreshToken: AppData.shared().refreshToken)
        }
    }
    
    
    // VerificationResultDelegate
    func success(result: PayWingsOnboardingKYC.SuccessEvent) {
        kycSuccess = result
        performSegue(withIdentifier: "kycSuccess", sender: nil)
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


private enum PermissionType : String {
    case Camera
    case Microphone
}

extension LoadingViewController {
    
    private func checkCameraPermission() {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            checkMicrophonePermission()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) -> Void in
                if granted == true {
                    self.checkMicrophonePermission()
                }
            })
        case .denied:
            showPhoneSettings(type: PermissionType.Camera.rawValue)
        case .restricted: // The user can't grant access due to restrictions.
            return
        default:
            fatalError(NSLocalizedString("Camera Authorization Status not handled!", comment: ""))
        }
    }
    
    private func checkMicrophonePermission() {
        
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            goToKyc()
        case .denied:
            showPhoneSettings(type: PermissionType.Microphone.rawValue)
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                if granted {
                    self.goToKyc()
                }
            })
        default:
            fatalError(NSLocalizedString("Microphone Authorization Status not handled!", comment: ""))
        }
    }

    private func showPhoneSettings(type: String) {
        hideLoading()
        let alertController = UIAlertController(title: NSLocalizedString("Permission Error", comment: ""), message: NSLocalizedString("Permission for ", comment: "") + NSLocalizedString(type, comment: "") + NSLocalizedString(" access denied, please allow our app permission through Settings in your phone if you want to use our service.", comment: ""), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    //
                })
            }
        })
        present(alertController, animated: true)
    }
}
