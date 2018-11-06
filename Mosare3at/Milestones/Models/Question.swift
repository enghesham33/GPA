//
//  Question.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/4/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class Question {
    var id: Int!
    var question: String!
    var choices: [Answer]!
    var weight: Int!
    var rightChoice: Int!
    var points: Int!
    var questionType: QuestionType = .NOT_ANSWERED // for internal usage not from API
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["question"] = question
        dictionary["weight"] = weight
        dictionary["rightChoice"] = rightChoice
        dictionary["points"] = points
        
        if choices != nil {
            var choicesDicArray = [Dictionary<String, Any>]()
            
            for choice in choices {
                choicesDicArray.append(choice.convertToDictionary())
            }
            dictionary["choices"] = choicesDicArray
        }
        
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Question {
        
        let question = Question()
        question.id =  dictionary["id"] as? Int
        question.question =  dictionary["question"] as? String
        question.weight =  dictionary["weight"] as? Int
        question.rightChoice =  dictionary["rightChoice"] as? Int
        question.points =  dictionary["points"] as? Int
        
        if let choicesArrayDic = dictionary["choices"], choicesArrayDic is [Dictionary<String, Any>] {
            var choices: [Answer] = []
            for dic in choicesArrayDic as! [Dictionary<String, Any>] {
                choices.append(Answer.getInstance(dictionary: dic))
            }
            question.choices = choices
        }        
        return question
    }
}

public enum QuestionType: Int {
    case NOT_ANSWERED = 1
    case RIGHT_ANSWER = 2
    case WRONG_ANSWER = 3
    case READY_TO_ANSWER = 4
}
