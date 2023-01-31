# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'PayWingsOnboardingKYC-SampleApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PayWingsOnboardingKYC-SampleApp

  pod 'PayWingsOnboardingKYC', '5.1.3'
  pod 'IdensicMobileSDK', :http => 'https://github.com/paywings/PayWingsOnboardingKycSDK-iOS-IdensicMobile/archive/v2.1.0.tar.gz'
  pod 'PayWingsOAuthSDK', '1.2.1'
  pod 'InAppSettingsKit', '3.3'


  post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
    end
  end

end
