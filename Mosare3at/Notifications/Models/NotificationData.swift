//
//  NotificationData.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class NotificationData {
    var title: String!
    var message: String!
    var links: [NotificationDataLink]!
    var deliverableType: String!
    var objectId: Int!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["title"] = title
        dictionary["message"] = message
        dictionary["deliverable_type"] = deliverableType
        dictionary["object_id"] = objectId
        
        if links != nil {
            var linksDicArray = [Dictionary<String, Any>]()
            
            for link in links {
                linksDicArray.append(link.convertToDictionary())
            }
            dictionary["link"] = linksDicArray
        }
        
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> NotificationData {
        
        let notificationData = NotificationData()
        
        notificationData.title =  dictionary["title"] as? String
        notificationData.message =  dictionary["message"] as? String
        notificationData.deliverableType =  dictionary["deliverable_type"] as? String
        notificationData.objectId =  dictionary["object_id"] as? Int
        
        if let linksArrayDic = dictionary["link"], linksArrayDic is [Dictionary<String, Any>] {
            var links: [NotificationDataLink] = []
            for dic in linksArrayDic as! [Dictionary<String, Any>] {
                links.append(NotificationDataLink.getInstance(dictionary: dic))
            }
            notificationData.links = links
        }
        return notificationData
    }
}
