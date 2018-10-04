//
//  ForgetPasswordPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/3/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

public protocol ForgetPasswordView : class {
    func forgetPasswordSuccess()
    func forgetPasswordFailed(errorMessage: String)
}

public class ForgetPasswordPresenter {
    fileprivate weak var forgetPasswordView : ForgetPasswordView?
    fileprivate let forgetPasswordRepository : ForgetPasswordRepository
    
    init(repository: ForgetPasswordRepository) {
        self.forgetPasswordRepository = repository
        self.forgetPasswordRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : ForgetPasswordView) {
        forgetPasswordView = view
    }
    
    public func forgetPassword(email: String) {
        UiHelpers.showLoader()
        self.forgetPasswordRepository.forgetPassword(email: email)
    }
}

extension ForgetPasswordPresenter: ForgetPasswordPresenterDelegate {
    public func forgetPasswordSuccess() {
        UiHelpers.hideLoader()
        self.forgetPasswordView?.forgetPasswordSuccess()
    }
    
    public func forgetPasswordFailed(errorMessage: String) {
        UiHelpers.hideLoader()
        self.forgetPasswordView?.forgetPasswordFailed(errorMessage: errorMessage)
    }
    
    
}
