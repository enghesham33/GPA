//
//  ForgetPasswordVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/2/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Toast_Swift
import SwiftyUserDefaults

class ForgetPasswordVC: BaseVC {

    var forgetPasswordLayout: ForgetPasswordLayout!// base layout of screen
    var forgetPasswordDoneLayout: ForgetPasswordDoneLayout! // layout to replace the base layout of screen
    var presenter: ForgetPasswordPresenter!
    
    
    // to return object of loginVC
    static func buildVC() -> ForgetPasswordVC {
        return ForgetPasswordVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forgetPasswordLayout = ForgetPasswordLayout(superview: self.view, forgetPasswordDelegate: self)
        forgetPasswordLayout.setupViews()
        forgetPasswordLayout.showAllViews()
        
        forgetPasswordDoneLayout = ForgetPasswordDoneLayout(superview: self.view, forgetPasswordDelegate: self)
        
        presenter = Injector.provideForgetPasswordPresenter()
        presenter.setView(view: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
extension ForgetPasswordVC: ForgetPasswordDelegate {
    func resendLinkToCurrentEmail() {
        self.presenter.forgetPassword(email: self.forgetPasswordLayout.emailField.text!)
    }
    
    func changePassword() {
        self.forgetPasswordDoneLayout.hideAllViews()
        self.forgetPasswordLayout.emailField.text = ""
        self.forgetPasswordLayout.showAllViews()
    }
    
    func goBack() {
        self.popVC()
    }
    
    func requestChangePassword() {
        
        if (self.forgetPasswordLayout.emailField.text?.isEmpty)! {
            self.view.makeToast("emptyFieldsError".localized())
        } else if !(self.forgetPasswordLayout.emailField.text?.isEmail)! {
            self.view.makeToast("validEmail".localized())
        } else {
            self.presenter.forgetPassword(email: self.forgetPasswordLayout.emailField.text!)
        }
    }
    
    func goToDoneChangePasswordScreen() {
        forgetPasswordLayout.hideAllViews()
        
        forgetPasswordDoneLayout.setupViews()
        forgetPasswordDoneLayout.showAllViews()
    }
    
    func retry() {
        
    }
}

extension ForgetPasswordVC: ForgetPasswordView {
    func forgetPasswordSuccess() {
        self.goToDoneChangePasswordScreen()
    }
    
    func forgetPasswordFailed(errorMessage: String) {
        self.view.makeToast(errorMessage)
    }
    
    
}
