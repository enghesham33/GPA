//
//  TeacherAssistantMark.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class TeacherAssistantMark {
    
    var requestId: String!
    var id: Int!
    var mark: String!
    
    var isSelected: Bool = false // for internal use not from API
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["@id"] = requestId
        dictionary["id"] = id
        dictionary["mark"] = mark
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> TeacherAssistantMark {
        let mark = TeacherAssistantMark()
        mark.requestId =  dictionary["@id"] as? String
        mark.id =  dictionary["id"] as? Int
        mark.mark =  dictionary["mark"] as? String
        return mark
    }
}
