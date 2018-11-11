//
//  TeacherAssistant.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TeacherAssistant {
    
    var id: Int!
    var requestId: String!
    var firstname: String!
    var profilePic: String!
    var lastname: String!
    
    // the following is for the rating
    var selectedMarks: [String] = []
    var teacherAssistant: String! // the same value of requestId
    var ratedBy: String! // the user's request id
    var team: String! // team request Id
    var week: String! // week request id
    var comment: String! //comment
    var points: Int! // gained points
    
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
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> TeacherAssistant {
        
        let teacherAssistant = TeacherAssistant()
        teacherAssistant.id =  dictionary["id"] as? Int
        teacherAssistant.requestId =  dictionary["@id"] as? String
        teacherAssistant.firstname =  dictionary["firstname"] as? String
        teacherAssistant.lastname =  dictionary["lastname"] as? String
        teacherAssistant.profilePic =  dictionary["profilePic"] as? String
        return teacherAssistant
    }
}
