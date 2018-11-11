//
//  Badge.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class Badge {
    
    var requestId: String!
    var id: Int!
    var name: String!
    var image: String!
    var weight: Int!
    var description: String!
    
    var isSelected: Bool = false // for internal use not from API
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["@id"] = requestId
        dictionary["id"] = id
        dictionary["name"] = name
        dictionary["image"] = image
        dictionary["weight"] = weight
        dictionary["description"] = description
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Badge {
        let badge = Badge()
        badge.requestId =  dictionary["@id"] as? String
        badge.id =  dictionary["id"] as? Int
        badge.name =  dictionary["name"] as? String
        badge.image =  dictionary["image"] as? String
        badge.weight =  dictionary["weight"] as? Int
        badge.description =  dictionary["description"] as? String
        return badge
    }
}
