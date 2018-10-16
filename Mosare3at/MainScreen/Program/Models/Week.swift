//
//  Week.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Week {
    
    var id: Int!
    var requestId: String!
    var title: String!
    var weight: Int!
    var startDate: String!
    var weekMaterial: WeekMaterial!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        if id == nil {
            id = Int(requestId.components(separatedBy: "/")[requestId.components(separatedBy: "/").count - 1])
        }
        dictionary["id"] = id
        dictionary["@id"] = requestId
        dictionary["title"] = title
        dictionary["weight"] = weight
        dictionary["startDate"] = startDate
        if weekMaterial != nil {
            dictionary["weekMaterial"] = weekMaterial.convertToDictionary()
        }
        
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Week {
        
        let week = Week()
        week.id =  dictionary["id"] as? Int
        week.requestId =  dictionary["@id"] as? String
        week.title =  dictionary["title"] as? String
        week.weight =  dictionary["weight"] as? Int
        week.startDate =  dictionary["startDate"] as? String
        if let weekMaterialDic = dictionary["weekMaterial"] {
            week.weekMaterial =  WeekMaterial.getInstance(dictionary: weekMaterialDic as! Dictionary<String, Any>)
        }
        
        return week
    }
}
