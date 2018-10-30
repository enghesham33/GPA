//
//  UserAnswer.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/23/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
public class UserAnswer {
    
    var id: Int!
    var project: String!
    var week: String!
    var milestone: String!
    var question: String!
    var userChoice: Int!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["project"] = project
        dictionary["week"] = week
        dictionary["milestone"] = milestone
        dictionary["question"] = question
        dictionary["userChoice"] = userChoice
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> UserAnswer {
        
        let userAnswer = UserAnswer()
        userAnswer.id =  dictionary["id"] as? Int
        userAnswer.project =  dictionary["project"] as? String
        userAnswer.week =  dictionary["week"] as? String
        userAnswer.milestone =  dictionary["milestone"] as? String
        userAnswer.question =  dictionary["question"] as? String
        userAnswer.userChoice =  dictionary["userChoice"] as? Int
        return userAnswer
    }
    
}
