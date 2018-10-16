//
//  WeekMaterial.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class WeekMaterial {
    
    var id: Int!
    var requestId: String!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["@id"] = requestId
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> WeekMaterial {
        
        let weekMaterial = WeekMaterial()        
        weekMaterial.id =  dictionary["id"] as? Int
        weekMaterial.requestId =  dictionary["@id"] as? String
        return weekMaterial
    }
}
