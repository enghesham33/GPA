//
//  TeacherAssistant.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Deliverable {
    
    
    var requestId: String!
    var title: String!
    var typeTitle: String!
    var type: String!
    var collective: Bool!
    var estimated: Int!
    var weight: Int!
    var points: Int!
    var grades: Int!
    var descriptions: [Description]!
    var dueDate: String!
    var approved: Bool!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["title"] = title
        dictionary["@id"] = requestId
        dictionary["typeTitle"] = typeTitle
        dictionary["collective"] = collective
        dictionary["estimated"] = estimated
        dictionary["weight"] = weight
        dictionary["points"] = points
        dictionary["grades"] = grades
        dictionary["dueDate"] = dueDate
        dictionary["approved"] = approved
        var descriptionsDicArray = [Dictionary<String, Any>]()
        
        for description in descriptions {
            descriptionsDicArray.append(description.convertToDictionary())
        }
        dictionary["description"] = descriptionsDicArray
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Deliverable {
        
        let deliverable = Deliverable()
        deliverable.requestId =  dictionary["@id"] as? String
        deliverable.title =  dictionary["title"] as? String
        deliverable.typeTitle =  dictionary["typeTitle"] as? String
        deliverable.collective =  dictionary["collective"] as? Bool
        deliverable.estimated =  dictionary["estimated"] as? Int
        deliverable.weight =  dictionary["weight"] as? Int
        deliverable.points =  dictionary["points"] as? Int
        deliverable.grades =  dictionary["grades"] as? Int
        deliverable.dueDate =  dictionary["dueDate"] as? String
        deliverable.approved =  dictionary["approved"] as? Bool
        deliverable.collective =  dictionary["collective"] as? Bool
        var descriptions: [Description] = []
        for dic in dictionary["description"] as! [Dictionary<String, Any>] {
            descriptions.append(Description.getInstance(dictionary: dic))
        }
        deliverable.descriptions = descriptions
        return deliverable
    }
}
