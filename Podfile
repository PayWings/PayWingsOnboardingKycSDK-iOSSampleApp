# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'PayWingsOnboardingKYC-SampleApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PayWingsOnboardingKYC-SampleApp

  pod 'PayWingsOnboardingKYC', '4.0.0'
  pod 'IdensicMobileSDK', :http => 'https://github.com/paywings/PayWingsOnboardingKycSDK-iOS-IdensicMobile/archive/v2.0.0.tar.gz'
  pod 'InAppSettingsKit', '3.3'


  post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
	    config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        end
    end
  end

end
