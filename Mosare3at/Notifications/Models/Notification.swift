//
//  Notification.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class Notification {
    var requestId: String!
    var id: Int!
    var userRequestId: String!
    var data: NotificationData!
    var type: String!
    var kind: String!
    var seen: Bool!
    var createdAt: String!
    var flag: String!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["@id"] = requestId
        dictionary["id"] = id
        dictionary["user"] = userRequestId
        dictionary["data"] = data.convertToDictionary()
        dictionary["type"] = type
        dictionary["kind"] = kind
        dictionary["seen"] = seen
        dictionary["create_at"] = createdAt
        dictionary["flag"] = flag
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Notification {
        
        let notification = Notification()
        
        notification.requestId =  dictionary["@id"] as? String
        notification.id =  dictionary["id"] as? Int
        notification.userRequestId =  dictionary["user"] as? String
        notification.data =   NotificationData.getInstance(dictionary: dictionary["data"] as! Dictionary<String, Any>)
        notification.type =  dictionary["type"] as? String
        notification.kind =  dictionary["kind"] as? String
        notification.seen =  dictionary["seen"] as? Bool
        notification.createdAt =  dictionary["create_at"] as? String
        notification.flag =  dictionary["flag"] as? String
        
        return notification
    }
}
