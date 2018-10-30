//
//  CurrentWeekStatus.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/23/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
public class CurrentWeekStatus {
    
    var finishedMilestones: Int!
    var allMilestones: Int!
    var deliveredDeliverables: Int!
     var allDeliverables: Int!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["finished_milestones"] = finishedMilestones
        dictionary["all_milestones"] = allMilestones
        dictionary["deliveredDeliverables"] = deliveredDeliverables
        dictionary["all_deliverables"] = allDeliverables
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> CurrentWeekStatus {
        let currentWeekStatus = CurrentWeekStatus()
        currentWeekStatus.finishedMilestones =  dictionary["finished_milestones"] as? Int
        currentWeekStatus.allMilestones =  dictionary["all_milestones"] as? Int
        currentWeekStatus.deliveredDeliverables =  dictionary["deliveredDeliverables"] as? Int
        currentWeekStatus.allDeliverables =  dictionary["all_deliverables"] as? Int
        return currentWeekStatus
    }
}

