//
//  LoginLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 9/30/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SnapKit
import UIKit
import Material
import Localize_Swift

protocol LoginDelegate: BaseLayoutDelegate {
    func login()
    func loginAsGuest()
    func goToResetPasswordScreen()
    func goToTutorial()
    func goToProgramScreen()
}

public class LoginLayout: BaseLayout {

    var loginDelegate: LoginDelegate!
    
    init(superview: UIView, loginDelegate: LoginDelegate) {
        super.init(superview: superview, delegate: loginDelegate)
        self.loginDelegate = loginDelegate
    }
    
    lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo_red")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var emailField: ErrorTextField = {
        let field = UiHelpers.textField(placeholder: "enterEmail".localized())
        field.placeholderNormalColor = UIColor.AppColors.gray
        field.returnKeyType = UIReturnKeyType.next
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.font = AppFont.font(type: .Regular, size: 15)
        return field
    }()
    
    lazy var passwordField: ErrorTextField = {
        let field = UiHelpers.textField(placeholder: "enterPassword".localized())
        field.isSecureTextEntry = true
        field.placeholderNormalColor = UIColor.AppColors.gray
        field.font = AppFont.font(type: .Regular, size: 15)
        return field
    }()
    
    lazy var visibilityToggleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hidden")!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.AppColors.gray
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
            self.passwordField.isSecureTextEntry = !self.passwordField.isSecureTextEntry
            if self.passwordField.isSecureTextEntry {
                imageView.image = UIImage(named: "hidden")!.withRenderingMode(.alwaysTemplate)
            } else {
                imageView.image = UIImage(named: "eye")!.withRenderingMode(.alwaysTemplate)
            }
            imageView.tintColor = UIColor.AppColors.gray
            
        })
        return imageView
    }()
    
    lazy var loginButton: RaisedButton = {
        let button = RaisedButton(title: "login".localized(), titleColor: .white)
        button.backgroundColor = UIColor.AppColors.green
         button.titleLabel?.font = AppFont.font(type: .Bold, size: 18)
        
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 0.5)
        button.addTapGesture { recognizer in
            self.loginDelegate.login()
        }
        return button
    }()
    
    lazy var forgetPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "forgetPassword".localized()
        label.textColor = .black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Regular, size: 16)
        label.addTapGesture(action: { (recognizer) in
            self.loginDelegate.goToResetPasswordScreen()
        })
        return label
    }()
    
    
    public func setupViews() {
        let views = [topImageView, emailField, passwordField, loginButton, forgetPasswordLabel, visibilityToggleImageView]
        self.superview.addSubviews(views)
        
        self.topImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10))
            maker.trailing.equalTo(superview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10) * -1)
            maker.top.equalTo(superview.snp.top).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15))
        }
        
        self.emailField.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.trailing.equalTo(superview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5) * -1)
            maker.top.equalTo(topImageView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10))
            
            maker.height.equalTo(30)
        }
        
        self.passwordField.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.trailing.equalTo(superview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5) * -1)
            maker.top.equalTo(emailField.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            
            maker.height.equalTo(30)
        }
        
        self.visibilityToggleImageView.snp.makeConstraints { maker in
            maker.trailing.equalTo(passwordField.snp.trailing)
            maker.top.equalTo(passwordField)
            maker.bottom.equalTo(passwordField).offset(-4)
            maker.width.equalTo(20)
        }
        
        self.loginButton.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10))
            maker.trailing.equalTo(superview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10) * -1)
            maker.top.equalTo(passwordField.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
        
        self.forgetPasswordLabel.snp.makeConstraints { maker in
            maker.centerX.equalTo(superview.snp.centerX)
            maker.top.equalTo(loginButton.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            
            maker.height.equalTo(40)
        }
    }
    
}
