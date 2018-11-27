//
//  TeacherAssistant.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Team {
    
    var id: Int!
    var name: String!
    var requestId: String!
    var image: String!
    var project: Project!
    var teacherAssistant: TeacherAssistant!
    var teamMembers: [TeamMember]!
    var currentWeek: Week!
    var currentWeekStartDate: String!
    var points: Int!
    var status: String!
    var badges: Int!
    var rank: Int!// for internal usage
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["@id"] = requestId
        dictionary["name"] = name
        dictionary["image"] = image
        dictionary["project"] = project.convertToDictionary()
        dictionary["teacherAssistant"] = teacherAssistant.convertToDictionary()
        var teamMembersDicArray = [Dictionary<String, Any>]()
        
        for teamMember in teamMembers {
            teamMembersDicArray.append(teamMember.convertToDictionary())
        }
        
        dictionary["teamMembers"] = teamMembersDicArray
        dictionary["currentWeek"] = currentWeek.convertToDictionary()
        dictionary["currentWeekStartDate"] = currentWeekStartDate
        dictionary["points"] = points
        dictionary["status"] = status
        dictionary["Badges"] = badges
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Team {
        
        let team = Team()
        team.id =  dictionary["id"] as? Int
        team.requestId =  dictionary["@id"] as? String
        team.name =  dictionary["name"] as? String
        team.image =  dictionary["image"] as? String
        
        if let projectDic = dictionary["project"], projectDic is Dictionary<String, Any> {
            team.project =  Project.getInstance(dictionary: projectDic as! Dictionary<String, Any>)
        }
        
        if let teamMembersDic = dictionary["teamMembers"], teamMembersDic is [Dictionary<String, Any>] {
            var teamMembers: [TeamMember] = []
            for dic in teamMembersDic as! [Dictionary<String, Any>] {
                teamMembers.append(TeamMember.getInstance(dictionary: dic))
            }
            team.teamMembers = teamMembers
        }

        if let currentWeekDic = dictionary["currentWeek"], currentWeekDic is Dictionary<String, Any> {
            team.currentWeek = Week.getInstance(dictionary: currentWeekDic as! Dictionary<String, Any>)
        }
        
        if let teacherAssistantDic = dictionary["teacherAssistant"], teacherAssistantDic is Dictionary<String, Any> {
            team.teacherAssistant = TeacherAssistant.getInstance(dictionary: teacherAssistantDic as! Dictionary<String, Any>)
        }
        
        team.currentWeekStartDate =  dictionary["currentWeekStartDate"] as? String
        team.points =  dictionary["points"] as? Int
        team.status =  dictionary["status"] as? String
        team.badges =  dictionary["Badges"] as? Int
        return team
    }
}
