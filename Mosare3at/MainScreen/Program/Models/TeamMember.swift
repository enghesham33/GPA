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
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["nickname"] = nickname
        dictionary["@id"] = requestId
        dictionary["member"] = member.convertToDictionary()
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> TeamMember {
        
        let teamMember = TeamMember()
        teamMember.nickname =  dictionary["nickname"] as? String
        teamMember.requestId =  dictionary["@id"] as? String
        teamMember.member =  Member.getInstance(dictionary: (dictionary["member"] as? Dictionary)!)
        return teamMember
    }
}
