//
//  LoginVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 9/30/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Toast_Swift
import SwiftyUserDefaults

class LoginVC: BaseVC {

    var loginLayout: LoginLayout!
    var presenter: LoginPresenter!
    
    // to return object of loginVC
    static func buildVC() -> LoginVC {
        return LoginVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginLayout = LoginLayout(superview: self.view, loginDelegate: self)
        loginLayout.setupViews()
        
        presenter = Injector.provideLoginPresenter()
        presenter.setView(view: self)
    }

}

extension LoginVC: LoginDelegate {
    func login() {
        if (self.loginLayout.emailField.text?.isEmpty)! || (self.loginLayout.passwordField.text?.isEmpty)!{
            self.view.makeToast("emptyFieldsError".localized())
        } else if !(self.loginLayout.emailField.text?.isEmail)! {
            self.view.makeToast("validEmail".localized())
        } else {
           self.presenter.login(email: self.loginLayout.emailField.text!, password: self.loginLayout.passwordField.text!)
        }
    }
    
    func loginAsGuest() {
        
    }
    
    func goToResetPasswordScreen() {
        navigator.navigateToForgetPassword()
    }
    
    func goToTutorial() {
        
    }
    
    func goToProgramScreen() {
        
    }
    
    func retry() {
        
    }
    
    
}

extension LoginVC : LoginView {
    func loginSuccess(user: User) {
        Defaults[.user] = user.convertToDictionary()
        Defaults[.token] = user.token
        Defaults[.isLoggedIn] = true
        self.view.makeToast("تم الدخول بنجاح")
    }
    
    func loginFailed(errorMessage: String) {
        self.view.makeToast(errorMessage)
    }
    
    
}
