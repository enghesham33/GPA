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
    var video: Video!
    var week: Week!
    var expectations: [String]!
    var milestones: [Milestone]!
    var deliverables: [Deliverable]!
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["@id"] = requestId
        if week != nil {
            dictionary["week"] = week.convertToDictionary()
        }
        
        if video != nil {
            dictionary["video"] = video.convertToDictionary()
        }
        
        if expectations != nil {
            dictionary["expectations"] = expectations
        }
        
        if milestones != nil {
            var milestonesDicArray = [Dictionary<String, Any>]()
            
            for milestone in milestones {
                milestonesDicArray.append(milestone.convertToDictionary())
            }
            dictionary["milestones"] = milestonesDicArray
        }
       
        if deliverables != nil {
            var deliverablesDicArray = [Dictionary<String, Any>]()
            
            for deliverable in deliverables {
                deliverablesDicArray.append(deliverable.convertToDictionary())
            }
            dictionary["deliverables"] = deliverablesDicArray
        }
        
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> WeekMaterial {
        
        let weekMaterial = WeekMaterial()        
        weekMaterial.id =  dictionary["id"] as? Int
        weekMaterial.requestId =  dictionary["@id"] as? String
        if let videoDic = dictionary["video"], videoDic is Dictionary<String, Any> {
            weekMaterial.video = Video.getInstance(dictionary: videoDic as! Dictionary<String, Any>)
        }
        
        if let weekDic = dictionary["week"], weekDic is Dictionary<String, Any> {
            weekMaterial.week = Week.getInstance(dictionary: weekDic as! Dictionary<String, Any>)
        }
        
        weekMaterial.expectations = dictionary["expectations"] as? [String]
        
        if let milestonesArrayDic = dictionary["milestones"], milestonesArrayDic is [Dictionary<String, Any>] {
            var milestones: [Milestone] = []
            for dic in milestonesArrayDic as! [Dictionary<String, Any>] {
                milestones.append(Milestone.getInstance(dictionary: dic))
            }
            weekMaterial.milestones = milestones
        }
        
        if let deliverablesArrayDic = dictionary["deliverables"], deliverablesArrayDic is [Dictionary<String, Any>] {
            var deliverables: [Deliverable] = []
            for dic in deliverablesArrayDic as! [Dictionary<String, Any>] {
                deliverables.append(Deliverable.getInstance(dictionary: dic))
            }
            weekMaterial.deliverables = deliverables
        }
        
        return weekMaterial
    }
}
