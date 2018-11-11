//
//  NotificationsRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

public protocol NotificationsPresenterDelegate {
    func opetaionFailed(message: String)
    func getNotificationsSuccess(notifications: [NotificationObj], nextPage: String)
}
public class NotificationsRepository {
    
    var delegate: NotificationsPresenterDelegate!
    
    public func setDelegate(delegate: NotificationsPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getNotSeenNotifications(url: String) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        
        Alamofire.request(URL(string: url)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let jsonArray = json["hydra:member"] as? [Dictionary<String,AnyObject>]
                        var notifications = [NotificationObj]()
                        for dic in jsonArray! {
                            let notification = NotificationObj.getInstance(dictionary: dic)
                            notifications.append(notification)
                        }
                        
                        if let hydraView = json["hydra:view"] as? Dictionary<String,AnyObject> {
                            if hydraView.has("hydra:next") {
                                self.delegate.getNotificationsSuccess(notifications: notifications, nextPage: hydraView["hydra:next"] as! String)
                            } else {
                                self.delegate.getNotificationsSuccess(notifications: notifications, nextPage: "")
                            }
                        } else{
                            self.delegate.getNotificationsSuccess(notifications: notifications, nextPage: "")
                        }
                        
                    } else {
//                        let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                } else {
//                    let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                    self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
}
