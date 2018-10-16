//
//  WeekDeliverable.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class WeekDeliverable {
    
    var id: Int!
    var requestId: String!
    var teamMember: TeamMember!
    var team: Team!
    var teacherAssistant: TeacherAssistant!
    var deliverable: Deliverable!
    var week: Week!
    var status: String!
    var createDate: String!
    var deliverDate: String!
    var replyDate: String!
    var grades: Int!
    var video: Video!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["@id"] = requestId
        dictionary["teamMember"] = teamMember.convertToDictionary()
        dictionary["team"] = team.convertToDictionary()
        dictionary["teacherAssistant"] = teacherAssistant.convertToDictionary()
        dictionary["deliverable"] = deliverable.convertToDictionary()
        dictionary["week"] = week.convertToDictionary()
        dictionary["status"] = status
        dictionary["createDate"] = createDate
        dictionary["deliverDate"] = deliverDate
        dictionary["replyDate"] = replyDate
        dictionary["grades"] = grades
        dictionary["video"] = video.convertToDictionary()
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> WeekDeliverable {
        
        let weekDeliverable = WeekDeliverable()
        weekDeliverable.requestId =  dictionary["@id"] as? String
        weekDeliverable.id =  dictionary["id"] as? Int
        if let teamMembersDic = dictionary["teamMember"], teamMembersDic is Dictionary<String, Any>  {
            weekDeliverable.teamMember =  TeamMember.getInstance(dictionary: teamMembersDic as! Dictionary<String, Any>)
        }
        
        if let weekDic = dictionary["week"], weekDic is Dictionary<String, Any> {
            weekDeliverable.week =  Week.getInstance(dictionary: weekDic as! Dictionary<String, Any>)
        }
        
        if let teamDic = dictionary["team"], teamDic is Dictionary<String, Any> {
            weekDeliverable.team =  Team.getInstance(dictionary: teamDic as! Dictionary<String, Any>)
        }
        
        if let teacherAssistantDic = dictionary["teacherAssistant"], teacherAssistantDic is Dictionary<String, Any> {
            weekDeliverable.teacherAssistant =  TeacherAssistant.getInstance(dictionary: teacherAssistantDic as! Dictionary<String, Any>)
        }
        
        if let deliverableDic = dictionary["deliverable"], deliverableDic is Dictionary<String, Any> {
            weekDeliverable.deliverable = Deliverable.getInstance(dictionary:deliverableDic as! Dictionary<String, Any>)
        }
        weekDeliverable.status =  dictionary["status"] as? String
        weekDeliverable.createDate =  dictionary["dueDate"] as? String
        weekDeliverable.replyDate =  dictionary["replyDate"] as? String
        weekDeliverable.deliverDate =  dictionary["deliverDate"] as? String
        weekDeliverable.grades =  dictionary["grades"] as? Int
        
        if let videoDic = dictionary["video"], videoDic is Dictionary<String, Any> {
            weekDeliverable.video =  Video.getInstance(dictionary: videoDic as! Dictionary<String, Any>)
        }
        return weekDeliverable
    }
    
}
