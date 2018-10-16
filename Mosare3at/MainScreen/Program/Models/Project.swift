//
//  Project.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Project {
    
    var id: Int!
    var requestId: String!
    var title: String!
    var weight: Int!
    var image: String!
    var supervisor: String!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["@id"] = requestId
        dictionary["title"] = title
        dictionary["weight"] = weight
        dictionary["image"] = image
        dictionary["supervisor"] = supervisor
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Project {
        let project = Project()
        project.id =  dictionary["id"] as? Int
        project.requestId =  dictionary["@id"] as? String
        project.title =  dictionary["title"] as? String
        project.weight =  dictionary["weight"] as? Int
        project.image =  dictionary["image"] as? String
        project.supervisor =  dictionary["supervisor"] as? String
        return project
    }
}
