//
//  RegisteredProject.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/20/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class RegisteredProject {
    var id: Int!
    var title: String!
    var image: String!
    var status: String!
    var finishedMilestones: Double!
    var startDate: String!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["title"] = title
        dictionary["image"] = image
        dictionary["status"] = status
        dictionary["finishedMilestones"] = finishedMilestones
        dictionary["startDate"] = startDate
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> RegisteredProject {
        let registeredProject = RegisteredProject()
        registeredProject.id =  dictionary["id"] as? Int
        registeredProject.title =  dictionary["title"] as? String
        registeredProject.image =  dictionary["image"] as? String
        registeredProject.status =  dictionary["status"] as? String
        registeredProject.finishedMilestones =  dictionary["finishedMilestones"] as? Double
        let startDateDic = dictionary["startDate"] as? Dictionary<String, Any>
        registeredProject.startDate =  startDateDic?["date"] as? String
        if registeredProject.startDate != nil {
            registeredProject.startDate = registeredProject.startDate.components(separatedBy: " ")[0]
        }
        return registeredProject
    }
}
