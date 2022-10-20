//
//  AppData.swift
//  PayWingsOnboardingKYC-SampleApp
//
//  Created by Tjasa Jan on 20/10/2022.
//  Copyright © 2022 Intech. All rights reserved.
//

import Foundation


class AppData {
    
    private static var privateShared : AppData?
    
    final class func shared() -> AppData
    {
        guard let iShared = privateShared else {
            privateShared = AppData()
            return privateShared!
        }
        return iShared
    }
    
    private init() {}
    deinit {}
    
    class func destroy() {
        privateShared = nil
    }
    
    
    var accessToken: String?
    var refreshToken: String?
    
    var userEmail = ""
    var emailSent = false
}
