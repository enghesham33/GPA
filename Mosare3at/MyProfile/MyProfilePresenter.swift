//
//  MyProfilePresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/18/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public protocol MyProfileView : class {
    func opetaionFailed(message: String)
    func getUserInfoSuccess(userInfo: UserInfo)
}

public class MyProfilePresenter {
    fileprivate weak var myProfileView : MyProfileView?
    fileprivate let myProfileRepository : MyProfileRepository
    
    init(repository: MyProfileRepository) {
        self.myProfileRepository = repository
        self.myProfileRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : MyProfileView) {
        myProfileView = view
    }
}

extension MyProfilePresenter {
    public func getUserInfo() {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.myProfileRepository.getUserInfo()
        } else {
            self.myProfileView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
}

extension MyProfilePresenter: MyProfilePresenterDelegate {
    public func opetaionFailed(message: String) {
        UiHelpers.hideLoader()
        self.myProfileView?.opetaionFailed(message: message)
    }
    
    public func getUserInfoSuccess(userInfo: UserInfo) {
        UiHelpers.hideLoader()
        self.myProfileView?.getUserInfoSuccess(userInfo: userInfo)
    }
    
    
}
