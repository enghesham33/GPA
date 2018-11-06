//
//  Answer.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/4/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class Answer {
    var answer: String!
    var isSelected: Bool = false // for internal usage not from the api
    var choiceType: ChoiceType = .NOT_SELECTED // for internal usage not from the api
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["answer"] = answer
        
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Answer {
        
        let answer = Answer()
        answer.answer =  dictionary["answer"] as? String
        return answer
    }
}

public enum ChoiceType: Int {
    case NOT_SELECTED = 1
    case RIGHT_CHOICE = 2
    case WRONG_CHOICE = 3
    case SELECTED = 4
    case RIGHT_CHOICE_IN_WRONG_QUESTION = 5
}
