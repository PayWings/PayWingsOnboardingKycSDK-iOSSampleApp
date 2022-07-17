//
//  AppStyle.swift
//  PayWingsOnboardingKYC-SampleApp
//
//  Created by tjasa on 29/07/2020.
//  Copyright © 2020 Intech. All rights reserved.
//

import UIKit
import PayWingsOnboardingKYC


class AppStyle {
    
    static func setCustomStyle() {
        
        PayWingsOnboardingKYC.Style.Colors.backgroundColor = .white
        PayWingsOnboardingKYC.Style.Colors.secondaryBackgroundColor = .white
        PayWingsOnboardingKYC.Style.Colors.tertiaryBackgroundColor = .white
        PayWingsOnboardingKYC.Style.Colors.backgroundStyle = .CustomLight
        
        PayWingsOnboardingKYC.Style.Colors.mainColor = UIColor.systemBlue.withAlphaComponent(0.8)
        PayWingsOnboardingKYC.Style.Colors.secondaryColor = .systemIndigo
        PayWingsOnboardingKYC.Style.Colors.tertiaryColor = .lightGray
        
        PayWingsOnboardingKYC.Style.Colors.titleTextColor = UIColor.systemBlue.withAlphaComponent(0.8)
        PayWingsOnboardingKYC.Style.Colors.textColor = .darkGray
        
        PayWingsOnboardingKYC.Style.Fonts.titleText = UIFont.systemFont(ofSize: 20, weight: .medium)
        PayWingsOnboardingKYC.Style.Fonts.text = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        PayWingsOnboardingKYC.Style.Shapes.showSeparators = false
        PayWingsOnboardingKYC.Style.Shapes.inputField = .Line
        PayWingsOnboardingKYC.Style.Shapes.borderWidth = 1
        PayWingsOnboardingKYC.Style.Shapes.cornerRadius = 15
        
        PayWingsOnboardingKYC.Style.Buttons.mainWidth = 250
        PayWingsOnboardingKYC.Style.Buttons.mainStyle = .Outlined
        PayWingsOnboardingKYC.Style.Buttons.documentTypeWidth = 250
        PayWingsOnboardingKYC.Style.Buttons.documentTypeStyle = .Outlined
        
        PayWingsOnboardingKYC.Style.Texts.navbarTitle = "Sample App"
        
        PayWingsOnboardingKYC.Style.Layout.contentTopMargin = 10
        PayWingsOnboardingKYC.Style.Layout.contentLeadingTrailingMargins = 20
        
        PayWingsOnboardingKYC.Style.Other.activityIndicatorStyle = IosCompatibility.activityIndicatorStyleCustom
    }
    
    static func setDefaultStyle() {
        
        PayWingsOnboardingKYC.Style.Colors.backgroundColor = .systemGroupedBackground
        PayWingsOnboardingKYC.Style.Colors.secondaryBackgroundColor = .secondarySystemGroupedBackground
        PayWingsOnboardingKYC.Style.Colors.tertiaryBackgroundColor = .tertiarySystemBackground
        PayWingsOnboardingKYC.Style.Colors.backgroundStyle = .Default
        
        PayWingsOnboardingKYC.Style.Colors.mainColor = getDefaultMainColor()
        PayWingsOnboardingKYC.Style.Colors.secondaryColor = .systemBlue
        PayWingsOnboardingKYC.Style.Colors.tertiaryColor = .placeholderText
        PayWingsOnboardingKYC.Style.Colors.borderColor = .lightGray
        PayWingsOnboardingKYC.Style.Colors.warningColor = .systemRed
        
        PayWingsOnboardingKYC.Style.Colors.titleTextColor = .label
        PayWingsOnboardingKYC.Style.Colors.textColor = .secondaryLabel
        PayWingsOnboardingKYC.Style.Colors.buttonTextColor = .white
        PayWingsOnboardingKYC.Style.Colors.separatorColor = .separator
        
        PayWingsOnboardingKYC.Style.Fonts.titleText = UIFont.systemFont(ofSize: 17, weight: .regular)
        PayWingsOnboardingKYC.Style.Fonts.text = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        PayWingsOnboardingKYC.Style.Shapes.showSeparators = true
        PayWingsOnboardingKYC.Style.Shapes.inputField = .Rectangle
        PayWingsOnboardingKYC.Style.Shapes.borderWidth = 0.5
        PayWingsOnboardingKYC.Style.Shapes.cornerRadius = 5
        
        PayWingsOnboardingKYC.Style.Buttons.mainWidth = 0
        PayWingsOnboardingKYC.Style.Buttons.mainStyle = .Default
        PayWingsOnboardingKYC.Style.Buttons.documentTypeWidth = 0
        PayWingsOnboardingKYC.Style.Buttons.documentTypeStyle = .Default
        
        PayWingsOnboardingKYC.Style.Texts.navbarTitle = "PayWingsOnboardingKYC"
        
        PayWingsOnboardingKYC.Style.Layout.contentTopMargin = 30
        PayWingsOnboardingKYC.Style.Layout.contentLeadingTrailingMargins = 40
        
        PayWingsOnboardingKYC.Style.Other.activityIndicatorStyle = IosCompatibility.activityIndicatorStyleDefault
        
    }
    
    private static func getDefaultMainColor() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return .systemIndigo
                } else {
                    return .systemTeal
                }
            }
        } else {
            return .blue
        }
    }

}


class KycButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        switch Style.Buttons.mainStyle {
        case .Default:
            self.backgroundColor = Style.Colors.mainColor
            self.tintColor = Style.Colors.buttonTextColor
        case .Outlined:
            self.backgroundColor = Style.Colors.buttonTextColor
            self.tintColor = Style.Colors.mainColor
            self.layer.borderColor = Style.Colors.mainColor.cgColor
            self.layer.borderWidth = Style.Shapes.borderWidth
        case .Inverted:
            self.backgroundColor = Style.Colors.buttonTextColor
            self.tintColor = Style.Colors.mainColor
        }
        self.layer.cornerRadius = Style.Shapes.cornerRadius
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        if Style.Buttons.mainWidth >= 250, superview != nil {
            self.leadingConstraintButton?.isActive = false
            self.trailingConstraintButton?.isActive = false
            self.centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
            self.widthAnchor.constraint(equalToConstant: Style.Buttons.mainWidth).isActive = true
            self.setNeedsLayout()
        }
        else {
            if superview != nil {
                self.leadingConstraintButton?.constant = Style.Layout.contentLeadingTrailingMargins
                self.trailingConstraintButton?.constant = Style.Layout.contentLeadingTrailingMargins
            }
        }
    }
}
class KycButtonInverted: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        self.tintColor = Style.Colors.mainColor
        self.setTitleColor(Style.Colors.tertiaryColor, for: .disabled)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        if superview != nil {
            self.leadingConstraintButton?.constant = Style.Layout.contentLeadingTrailingMargins
        }
    }
}
class KycTitle: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        self.textColor = Style.Colors.titleTextColor
        self.font = Style.Fonts.titleText
    }
}
class KycWarningTextLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.clear
        self.textColor = Style.Colors.warningColor
        self.font = Style.Fonts.text
    }
}
class KycTextLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.clear
        self.textColor = Style.Colors.textColor
        self.font = Style.Fonts.text
    }
}
class KycText: UITextView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.clear
        self.textColor = Style.Colors.textColor
        self.font = Style.Fonts.text
    }
}
class KycHelperText: UITextView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.clear
        self.textColor = Style.Colors.tertiaryColor
    }
}
class KycView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = Style.Colors.backgroundColor
    }
}
class KycSecondaryView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = Style.Colors.secondaryBackgroundColor
        if Style.Shapes.showSeparators {
            self.layer.borderWidth = 1
            self.layer.borderColor = Style.Colors.separatorColor.cgColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        if superview != nil {
            self.topConstraintView?.constant = Style.Layout.contentTopMargin
        }
    }
}
class KycContentView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.clear
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        if superview != nil {
            self.leadingConstraintView?.constant = Style.Layout.contentLeadingTrailingMargins
            self.trailingConstraintView?.constant = Style.Layout.contentLeadingTrailingMargins
        }
    }
}


enum IosCompatibility {
    
    static var activityIndicatorStyleDefault: UIActivityIndicatorView.Style {
        if #available(iOS 13, *) {
            return .large
        } else {
            return .whiteLarge
        }
    }
    static var activityIndicatorStyleCustom: UIActivityIndicatorView.Style {
        if #available(iOS 13, *) {
            return .medium
        } else {
            return .whiteLarge
        }
    }
}



extension UIButton {
    
    var leadingConstraintButton: NSLayoutConstraint? {
        get {
            self.superview?.constraints.first(where: {
                $0.firstItem as? UIView == self && $0.firstAttribute == .leading && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    var trailingConstraintButton: NSLayoutConstraint? {
        get {
            self.superview?.constraints.first(where: {
                $0.secondItem as? UIView == self && $0.firstAttribute == .trailing && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
}

extension UIView {
    
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    var leadingConstraintView: NSLayoutConstraint? {
        get {
            self.superview?.constraints.first(where: {
                $0.firstItem as? UIView == self && $0.firstAttribute == .leading && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    var trailingConstraintView: NSLayoutConstraint? {
        get {
            self.superview?.constraints.first(where: {
                $0.secondItem as? UIView == self && $0.firstAttribute == .trailing && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    var topConstraintView: NSLayoutConstraint? {
        get {
            self.superview?.constraints.first(where: {
                $0.firstItem as? UIView == self && $0.firstAttribute == .top && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
}


extension UIViewController {
    
    func showLoading(vc: UIViewController) {
        
        let activityView = UIActivityIndicatorView()
        activityView.style = Style.Other.activityIndicatorStyle
        activityView.color = UIColor.label
        activityView.center = vc.view.center
        activityView.tag = 0123
        vc.view.addSubview(activityView)
        activityView.startAnimating()
        
        vc.view.isUserInteractionEnabled = false
    }
    
    func hideLoading(vc: UIViewController) {
        if let activityView = vc.view.viewWithTag(0123) {
            activityView.removeFromSuperview()
        }
        vc.view.isUserInteractionEnabled = true
    }
    
    func transitionFromRightToLeft() {

        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: nil)
    }
}
