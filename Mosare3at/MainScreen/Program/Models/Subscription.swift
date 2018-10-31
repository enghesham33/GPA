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
    var firstTimeWeek: [Int]!
    var finishedMilestones: [Int]!
    var tutorialBadge: Bool!
    var tutorialPoint: Bool!
    var finishedRatedWeeks: [Int]!
    var sharedBadgesArr: [Int]!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["program"] = program.convertToDictionary()
        dictionary["project"] = project.convertToDictionary()
        dictionary["week"] = week.convertToDictionary()
        dictionary["milestone"] = milestone.convertToDictionary()
        dictionary["firstTimeWeek"] = firstTimeWeek
        dictionary["finishedMilestones"] = finishedMilestones
        dictionary["tutorialBadge"] = tutorialBadge
        dictionary["tutorialPoint"] = tutorialPoint
        dictionary["finishedRatedWeeks"] = finishedRatedWeeks
        dictionary["sharedBadgesArr"] = sharedBadgesArr
        
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Subscribtion {
        let subscribtion = Subscribtion()
        subscribtion.id =  dictionary["id"] as? Int
        subscribtion.program =  Program.getInstance(dictionary: dictionary["program"] as! Dictionary)
        subscribtion.project =  Project.getInstance(dictionary: dictionary["project"] as! Dictionary)
        subscribtion.week =  Week.getInstance(dictionary: dictionary["week"] as! Dictionary)
        subscribtion.milestone =  Milestone.getInstance(dictionary: dictionary["milestone"] as! Dictionary)
        subscribtion.firstTimeWeek =  dictionary["firstTimeWeek"] as? [Int]
        subscribtion.finishedMilestones =  dictionary["finishedMilestones"] as? [Int]
        subscribtion.tutorialBadge =  dictionary["tutorialBadge"] as? Bool
        subscribtion.tutorialPoint =  dictionary["tutorialPoint"] as? Bool
        subscribtion.finishedRatedWeeks =  dictionary["finishedRatedWeeks"] as? [Int]
        subscribtion.sharedBadgesArr =  dictionary["sharedBadgesArr"] as? [Int]
        return subscribtion
    }
}
