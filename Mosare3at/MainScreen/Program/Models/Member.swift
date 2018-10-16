//
//  TeacherAssistant.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Member {
    
    var id: Int!
    var requestId: String!
    var firstname: String!
    var profilePic: String!
    var lastname: String!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["@id"] = requestId
        dictionary["firstname"] = firstname
        dictionary["lastname"] = lastname
        dictionary["profilePic"] = profilePic
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Member {
        
        let member = Member()
        member.id =  dictionary["id"] as? Int
        member.requestId =  dictionary["@id"] as? String
        member.firstname =  dictionary["firstname"] as? String
        member.lastname =  dictionary["lastname"] as? String
        member.profilePic =  dictionary["profilePic"] as? String
        return member
    }
}
