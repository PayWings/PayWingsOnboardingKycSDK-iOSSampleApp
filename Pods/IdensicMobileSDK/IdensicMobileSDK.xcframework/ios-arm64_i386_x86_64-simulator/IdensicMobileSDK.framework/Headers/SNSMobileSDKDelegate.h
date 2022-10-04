//
//  SNSMobileSDKDelegate.h
//  ssmSDK
//

#ifndef SNSMobileSDKDelegate_h
#define SNSMobileSDKDelegate_h

@class SNSMobileSDK;

@protocol SNSMobileSDKDelegate

@optional

/**
 * Implement if you'd like to present a custom country picker
 *
 * @discussion
 * It's up to you to present and dismiss the picker. In case the user do pick a country, call `onSelect` passing the selected country code.
 */
- (void)      snsMobileSDK:(nonnull SNSMobileSDK *)sdk
   presentCountryPickerFor:(nonnull NSDictionary<NSString *, NSString *> *)countries
                      from:(nonnull UIViewController *)presentingViewController
                     title:(nullable NSString *)title
               preselected:(nullable NSString *)countryCode
                  onSelect:(void (^ _Nonnull)(NSString * _Nonnull))onSelect;

/**
 * Implement if you'd like to use a custom image for the selected country
 *
 * @discussion
 * Used on DocType Selector screen only at the moment.
 */
- (nullable UIImage *)snsMobileSDK:(nonnull SNSMobileSDK *)sdk
           imageForSelectedCountry:(nonnull NSString *)countryCode;

/**
 * Implement if you'd like to show a custom instruction view.
 *
 * @discussion
 * Returning `nil` means the corresponding Instructions view will be constructed and shown by the sdk itself.
 */
- (nullable UIView *)    snsMobileSDK:(nonnull SNSMobileSDK *)sdk
  instructionsViewForVerificationStep:(nonnull SNSVerificationStepKey)verificationStep
                         documentType:(nonnull SNSDocumentTypeKey)documentType
                            sceneType:(nonnull SNSSceneType)sceneType;

@end

#endif /* SNSMobileSDKDelegate_h */
