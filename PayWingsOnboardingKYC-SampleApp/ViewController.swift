//
//  ViewController.swift
//  PayWingsOnboardingKYC-SampleApp
//
//  Created by tjasa on 6/24/20.
//  Copyright © 2020 Intech. All rights reserved.
//

import UIKit
import AVFoundation
import PayWingsOnboardingKYC
import InAppSettingsKit


private enum PermissionType : String {
    case Camera
    case Microphone
}


class ViewController: UIViewController, IASKSettingsDelegate {
    
    var latestSdkVersion = "v4.0.0"
    
    @IBOutlet weak var sdkVersion: KycTextLabel!
    @IBOutlet weak var StartButton: UIButton!
    
    var credentials : KycCredentials?
    var settings : KycSettings?
    var userData : KycUserData?
    
    var kycStyle : String = "default"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sample App"
        
        UserDefaults.standard.addObserver(self, forKeyPath: "kyc_style_preference", options: .new, context: nil)
        
        getStyle()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "kyc_style_preference" {
            getStyle()
        }
    }
    
    func getStyle() {
        kycStyle = UserDefaults.standard.string(forKey: "kyc_style_preference") ?? ""
        if kycStyle == "custom" {
            AppStyle.setCustomStyle()
        }
        else {
            AppStyle.setDefaultStyle()
        }
        self.loadView()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return kycStyle == "custom" ? .lightContent : .default
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sdkVersion.text = latestSdkVersion
    }
    
    
    @IBAction func openSettings(_ sender: Any) {
        let appSettingsViewController = IASKAppSettingsViewController()
        appSettingsViewController.neverShowPrivacySettings = true
        appSettingsViewController.showCreditsFooter = false
        appSettingsViewController.delegate = self
        
        let navController = UINavigationController(rootViewController: appSettingsViewController)
        navController.modalPresentationStyle = .fullScreen
        self.show(navController, sender: self)
    }
    
    func settingsViewControllerDidEnd(_ settingsViewController: IASKAppSettingsViewController) {
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func startKyc(_ sender: UIButton) {
        showLoading(vc: self)
        checkCameraPermission()
    }
    
    func goToKyc() {
        getKycSettings()
        
        DispatchQueue.main.async {
            let cameraAuthorized = (AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized) ? true : false
            let microphoneAuthorized = (AVCaptureDevice.authorizationStatus(for: AVMediaType.audio) == .authorized) ? true : false
            
            if cameraAuthorized && microphoneAuthorized {
                
                let initStoryboard = UIStoryboard(name: String(describing: LoadingViewController.self), bundle: nil)
                let initVC = initStoryboard.instantiateViewController(withIdentifier: String(describing: LoadingViewController.self))
                self.navigationController?.pushViewController(initVC, animated: true)

                self.hideLoading(vc: self)
                
                let config = KycConfig(credentials: self.credentials!, settings: self.settings!, userData: self.userData)
                let result = VerificationResult()

                PayWingsOnboardingKyc.startKyc(vc: initVC, config: config, result: result)
            }
        }
    }
    
    func getKycSettings() {
        
        let sdkUsername = UserDefaults.standard.string(forKey: "sdk_api_username") ?? ""
        let sdkPassword = UserDefaults.standard.string(forKey: "sdk_api_password") ?? ""
        let sdkBaseUrl = UserDefaults.standard.string(forKey: "sdk_api_url") ?? ""
        
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
        
    }
    
    
}



extension ViewController {
    
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
        hideLoading(vc: self)
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


extension UINavigationController {
    
    override open var shouldAutorotate: Bool {
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.shouldAutorotate
            }
            return super.shouldAutorotate
        }
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.preferredInterfaceOrientationForPresentation
            }
            return super.preferredInterfaceOrientationForPresentation
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.supportedInterfaceOrientations
            }
            return super.supportedInterfaceOrientations
        }
    }
}
