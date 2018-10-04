//
//  LoginRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/2/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import Localize_Swift
import SwiftyUserDefaults

public protocol LoginPresenterDelegate {
    func loginSuccess(user: User)
    func loginFailed(errorMessage: String)
}

public class LoginRepository {
    
    var delegate: LoginPresenterDelegate!
    
    public func setDelegate(delegate: LoginPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func login(email: String, password: String) {
         let headers = ["Content-Type" : "application/json"]
        let parameters = ["username" : email, "password" : password]
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "login")!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 {
                        let user = User.getInstance(dictionary: json)
                        self.delegate.loginSuccess(user: user)
                    } else {
                        self.delegate.loginFailed(errorMessage: json["error"] as! String)
                    }
                }
            } else {
                self.delegate.loginFailed(errorMessage: "somethingWentWrong".localized())
            }
        }
    }
    
    public func registerFCMToken(id: Int, token: String) {
        let headers = ["Content-Type" : "application/json"]
        
        let parameters = ["user" : "users/\(id)", "token" : token]
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "firebase_tokens")!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let _ = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 {
                        Defaults[.fcmToken] = token
                    }
                }
            }
        }
    }
    
    public func updateFCMToken(id: Int, oldToken: String, newToken: String) {
        let headers = ["Content-Type" : "application/json"]
        
        let parameters = ["user" : "users/\(id)", "old-token" : oldToken, "new-token" : newToken]
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "reset-firebase-token")!, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let _ = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 {
                        Defaults[.fcmToken] = newToken
                    }
                }
            }
        }
    }
}
