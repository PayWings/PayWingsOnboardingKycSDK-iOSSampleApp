//
//  ViewController.swift
//  PayWingsOnboardingKYC-SampleApp
//
//  Created by tjasa on 6/24/20.
//  Copyright © 2020 Intech. All rights reserved.
//

import UIKit
import InAppSettingsKit
import PayWingsOAuthSDK


class ViewController: UIViewController, IASKSettingsDelegate {
    
    var kycSdkVersion = "KYC SDK v5.1.3"
    var oauthSdkVersion = "OAuth SDK v1.2.1"
    
    @IBOutlet weak var KycSdkVersion: KycTextLabel!
    @IBOutlet weak var OauthSdkVersion: KycTextLabel!
    
    
    
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
        
        KycSdkVersion.text = kycSdkVersion
        OauthSdkVersion.text = oauthSdkVersion
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
        performSegue(withIdentifier: "loading", sender: nil)
    }
    
    @IBAction func startOAuth(_ sender: Any) {
        let domain = UserDefaults.standard.string(forKey: "domain") ?? ""
        let apiKey = UserDefaults.standard.string(forKey: "api_key") ?? ""
        
        PayWingsOAuthClient.initialize(environmentType: .TEST, apiKey: apiKey, domain: domain)
        performSegue(withIdentifier: "enterMobileNumber", sender: nil)
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
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
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
