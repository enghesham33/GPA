//
//  MyProfileRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/18/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

public protocol MyProfilePresenterDelegate : class {
    func opetaionFailed(message: String)
    func getUserInfoSuccess(userInfo: UserInfo)
}

public class MyProfileRepository {
    //getSubscribtions
    var delegate: MyProfilePresenterDelegate!

    public func setDelegate(delegate: MyProfilePresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getUserInfo() {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let userId = User.getInstance(dictionary: Defaults[.user]!).id!
        let programId = Subscribtion.getInstance(dictionary: Defaults[.subscription]!).program.requestId.components(separatedBy: "/")[Subscribtion.getInstance(dictionary: Defaults[.subscription]!).program.requestId.components(separatedBy: "/").count - 1]
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "getUserInfo/\(userId)/\(programId)")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let userInfo = UserInfo.getInstance(dictionary: json)
                        self.delegate.getUserInfoSuccess(userInfo: userInfo)
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
