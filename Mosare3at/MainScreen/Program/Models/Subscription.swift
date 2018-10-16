//
//  Subscription.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

import SwiftyJSON

public class Subscribtion {
    
    var id: Int!
    var program: Program!
    var project: Project!
    var week: Week!
    var milestone: Milestone!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["program"] = program.convertToDictionary()
        dictionary["project"] = project.convertToDictionary()
        dictionary["week"] = week.convertToDictionary()
        dictionary["milestone"] = milestone.convertToDictionary()
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Subscribtion {
        let subscribtion = Subscribtion()
        subscribtion.id =  dictionary["id"] as? Int
        subscribtion.program =  Program.getInstance(dictionary: dictionary["program"] as! Dictionary)
        subscribtion.project =  Project.getInstance(dictionary: dictionary["project"] as! Dictionary)
        subscribtion.week =  Week.getInstance(dictionary: dictionary["week"] as! Dictionary)
        subscribtion.milestone =  Milestone.getInstance(dictionary: dictionary["milestone"] as! Dictionary)
        return subscribtion
    }
}
