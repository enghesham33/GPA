//
//  NotificationDataLink.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class NotificationDataLink {
    var title: String!
    var href: String!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["title"] = title
        dictionary["href"] = href
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> NotificationDataLink {
        
        let notificationDataLink = NotificationDataLink()
        notificationDataLink.title =  dictionary["title"] as? String
        notificationDataLink.href =  dictionary["href"] as? String
        return notificationDataLink
    }
}
