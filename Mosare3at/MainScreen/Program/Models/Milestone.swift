//
//  Milestone.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Milestone {
    
    var id: Int!
    var title: String!
    var weight: Int!
    var requestId: String!
    var estimated: Int!
    var tasks: [String]!
    var questions: [Question]!
    var questionsStrings: [String]!
    var userAnswers: [UserAnswer]! // for using to get value of answered only
    var isWorkingOn: Bool! // for using in populate week details screen
    var isDone: Bool! // for using in populate week details screen
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["@id"] = requestId
        dictionary["title"] = title
        dictionary["weight"] = weight
        dictionary["estimated"] = estimated
        dictionary["tasks"] = tasks
        if questions != nil {
            dictionary["questions"] = questions
        } else {
            dictionary["questions"] = questionsStrings
        }
        
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Milestone {
        
        let mileStone = Milestone()
        mileStone.id =  dictionary["id"] as? Int
        mileStone.requestId =  dictionary["@id"] as? String
        mileStone.title =  dictionary["title"] as? String
        mileStone.weight =  dictionary["weight"] as? Int
        mileStone.estimated =  dictionary["estimated"] as? Int
        mileStone.tasks =  dictionary["tasks"] as? [String]
        
        if let questionsArrayDic = dictionary["questions"] {
            if questionsArrayDic is [Dictionary<String, Any>] {
                var questions: [Question] = []
                for dic in questionsArrayDic as! [Dictionary<String, Any>] {
                    questions.append(Question.getInstance(dictionary: dic))
                }
                mileStone.questions = questions
            } else {
                mileStone.questionsStrings =  dictionary["questions"] as? [String]
            }
        }
        return mileStone
    }
}
