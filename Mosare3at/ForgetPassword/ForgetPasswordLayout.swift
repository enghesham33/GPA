//
//  ForgetPasswordLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/2/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SnapKit
import UIKit
import Material
import Localize_Swift

protocol ForgetPasswordDelegate: BaseLayoutDelegate {
    func requestChangePassword()
    func goToDoneChangePasswordScreen()
    func goBack()
    func resendLinkToCurrentEmail()
    func changePassword()
}

public class ForgetPasswordLayout: BaseLayout {
    var forgetPasswordDelegate: ForgetPasswordDelegate!
    var isHidden: Bool = false
    
    var topView: TopView = TopView()
    
    init(superview: UIView, forgetPasswordDelegate: ForgetPasswordDelegate) {
        super.init(superview: superview, delegate: forgetPasswordDelegate)
        self.forgetPasswordDelegate = forgetPasswordDelegate
    }
    
    lazy var emailField: ErrorTextField = {
        let field = UiHelpers.textField(placeholder: "enterEmail".localized())
        field.placeholderNormalColor = UIColor.AppColors.gray
        field.returnKeyType = UIReturnKeyType.next
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.font = AppFont.font(type: .Regular, size: 15)
        return field
    }()
    
    lazy var sendPasswordButton: RaisedButton = {
        let button = RaisedButton(title: "sendPassword".localized(), titleColor: .white)
        button.backgroundColor = UIColor.AppColors.green
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 18)
        
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 0.5)
        button.addTapGesture { recognizer in
            self.forgetPasswordDelegate.requestChangePassword()
        }
        return button
    }()
    
    public func setupViews() {
        let views = [emailField, sendPasswordButton, topView]
        self.superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        self.topView.setupViews(screenTitle: "forgetPassword".localized())
        self.topView.delegate = self
        
        self.emailField.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.trailing.equalTo(superview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5) * -1)
            maker.top.equalTo(topView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            
            maker.height.equalTo(30)
        }
        
        self.sendPasswordButton.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10))
            maker.trailing.equalTo(superview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10) * -1)
            maker.top.equalTo(emailField.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
    }
    
    public func hideAllViews() {
        emailField.isHidden = true
        sendPasswordButton.isHidden = true
        self.isHidden = true
    }
    
    public func showAllViews() {
        emailField.isHidden = false
        sendPasswordButton.isHidden = false
        self.isHidden = false
    }
}

extension ForgetPasswordLayout: TopViewDelegate {
    public func goToNotifications() {
        // go to notifications screen
    }
    
    public func goBack() {
        self.forgetPasswordDelegate.goBack()
    }
}
