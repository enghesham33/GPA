//
//  TutorialRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

public protocol TutorialPresenterDelegate {
    func opetaionFailed(message: String)
    func updateUserTakeTutorialSuccess(success: Bool)
}

public class TutorialRepository {
    var delegate: TutorialPresenterDelegate!
    
    public func setDelegate(delegate: TutorialPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func updateUserTakeTutorial() {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let userId: Int = User.getInstance(dictionary: Defaults[.user]!).id
        let params = ["takeTutorial": true]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "users/\(userId)")!, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                       self.delegate.updateUserTakeTutorialSuccess(success: true)
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                } else {
                    self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
}

