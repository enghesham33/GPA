//
//  LoginPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/2/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import Firebase

public protocol LoginView : class {
    func loginSuccess(user: User)
    func loginFailed(errorMessage: String)
}

public class LoginPresenter {
    fileprivate weak var loginView : LoginView?
    fileprivate let loginRepository : LoginRepository
    
    init(repository: LoginRepository) {
        self.loginRepository = repository
        self.loginRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : LoginView) {
        loginView = view
    }
}

extension LoginPresenter {
    public func login(email: String, password: String) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.loginRepository.login(email: email, password: password)
        } else {
            self.loginFailed(errorMessage: "noInternetConnection".localized())
        }
    }
    
    public func registerFCMToken(id: Int, token: String) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.loginRepository.registerFCMToken(id: id, token: token)
        } else {
            self.loginFailed(errorMessage: "noInternetConnection".localized())
        }
    }
    
    public func updateFCMToken(id: Int, oldToken: String, newToken: String) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.loginRepository.updateFCMToken(id: id, oldToken: oldToken, newToken: newToken)
        } else {
            self.loginFailed(errorMessage: "noInternetConnection".localized())
        }
    }
}

extension LoginPresenter: LoginPresenterDelegate {
    public func loginSuccess(user: User) {
        UiHelpers.hideLoader()
        loginView?.loginSuccess(user: user)
        self.registerFCMToken(id: user.id, token: user.token)
    }
    
    public func loginFailed(errorMessage: String) {
        UiHelpers.hideLoader()
        loginView?.loginFailed(errorMessage: errorMessage)
    }
}
