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
    var summary: String!
    var weight: Int!
    var startDate: String!
    var endDate: String!
    var weekMaterial: WeekMaterial!
    var approved: Bool!
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
        dictionary["endDate"] = endDate
        dictionary["summary"] = summary
        dictionary["approved"] = approved
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
        week.endDate =  dictionary["endDate"] as? String
        week.summary =  dictionary["summary"] as? String
        week.approved =  dictionary["approved"] as? Bool
        if let weekMaterialDic = dictionary["weekMaterial"] {
            week.weekMaterial =  WeekMaterial.getInstance(dictionary: weekMaterialDic as! Dictionary<String, Any>)
        }
        
        return week
    }
}
