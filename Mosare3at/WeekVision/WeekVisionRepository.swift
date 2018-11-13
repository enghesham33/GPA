//
//  WeekVisionRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/1/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

public protocol WeekVisionPresenterDelegate {
    func opetaionFailed(message: String)
    func getVideoLinksSuccess(link: String)
}

public class WeekVisionRepository {
    var delegate: WeekVisionPresenterDelegate!
    
    public func setDelegate(delegate: WeekVisionPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getVideoLinks(videoId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let params = ["video":videoId]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "aws/download")!, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {                
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let jsonArray = json["results"] as? [Dictionary<String,AnyObject>]
                        let dic = jsonArray![1]
                        
                        self.delegate.getVideoLinksSuccess(link: dic["360"] as! String)
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
