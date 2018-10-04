//
//  ForgetPasswordRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/3/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import Localize_Swift
import SwiftyUserDefaults

public protocol ForgetPasswordPresenterDelegate {
    func forgetPasswordSuccess()
    func forgetPasswordFailed(errorMessage: String)
}

public class ForgetPasswordRepository {
    
    var delegate: ForgetPasswordPresenterDelegate!
    
    public func setDelegate(delegate: ForgetPasswordPresenterDelegate) {
        self.delegate = delegate
    }

    public func forgetPassword(email: String) {
        let headers = ["Content-Type" : "application/x-www-form-urlencoded"]
        let parameters = ["email" : email]
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "forget-password")!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 {
                        self.delegate.forgetPasswordSuccess()
                    } else {
                        self.delegate.forgetPasswordFailed(errorMessage: json["email"] as! String)
                    }
                }
            } else {
                self.delegate.forgetPasswordFailed(errorMessage: "somethingWentWrong".localized())
            }
        }
    }
}
