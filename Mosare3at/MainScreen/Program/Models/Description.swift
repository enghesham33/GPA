//
//  Description.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class Description {
    
    var title: String!
    var description: String!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["title"] = title
        dictionary["description"] = description
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Description {
        
        let description = Description()
        description.title =  dictionary["title"] as? String
        description.description =  dictionary["description"] as? String
        return description
    }
    
}
