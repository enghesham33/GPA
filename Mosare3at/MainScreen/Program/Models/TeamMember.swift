//
//  TeacherAssistant.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TeamMember {
    
    var nickname: String!
    var requestId: String!
    var member: Member!
    var status: String!
    var points: Int!
    var badgesCount: Int!
    var collectives: Int!
    
    var badges: [Badge]! // for internal usage
    var rank: Int! // for internal usage
    
    // the following is for the rating
    var ratedUser: String! // the user's request id
    var ratedBy: String! // the user's request id
    var team: String! // team request Id
    var week: String! // week request id
    var comment: String! //comment
    var badge: String! // gained points
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["nickname"] = nickname
        dictionary["@id"] = requestId
        dictionary["status"] = status
        dictionary["points"] = points
        dictionary["Badges"] = badgesCount
        dictionary["collectives"] = collectives
        dictionary["member"] = member.convertToDictionary()
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> TeamMember {
        
        let teamMember = TeamMember()
        teamMember.nickname =  dictionary["nickname"] as? String
        teamMember.status =  dictionary["status"] as? String
        teamMember.points =  dictionary["points"] as? Int
        if dictionary.keys.contains("Badges") {
            teamMember.badgesCount =  dictionary["Badges"] as? Int
        } else if dictionary.keys.contains("badges") {
            teamMember.badgesCount =  dictionary["badges"] as? Int
        }
        
        teamMember.collectives =  dictionary["collectives"] as? Int
        teamMember.requestId =  dictionary["@id"] as? String
        if dictionary.keys.contains("user") {
            teamMember.member =  Member.getInstance(dictionary: (dictionary["user"] as? Dictionary)!)
        }
        
        if dictionary.keys.contains("member") {
            teamMember.member =  Member.getInstance(dictionary: (dictionary["member"] as? Dictionary)!)
        }
        
        return teamMember
    }
}
