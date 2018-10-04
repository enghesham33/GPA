//
//  User.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/2/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class User {
    
    var id: Int!
    var firstName: String!
    var lastName: String!
    var email: String!
    var token: String!
    var isActive: Bool!
    var lastLogin: Int!
    var isLearner: Bool!
    var takeTutorial: Bool!
    var roles: [String]!
    var profilePic: String!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["firstname"] = firstName
        dictionary["lastname"] = lastName
        dictionary["email"] = email
        dictionary["token"] = token
        dictionary["isActive"] = isActive
        dictionary["lastLogin"] = lastLogin
        dictionary["isLearner"] = isLearner
        dictionary["takeTutorial"] = takeTutorial
        dictionary["roles"] = roles
        dictionary["profilePic"] = profilePic
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> User {
        
        let user = User()
        
        user.id =  dictionary["id"] as? Int
        user.firstName = dictionary["firstname"] as? String
        user.lastName = dictionary["lastname"] as? String
        user.email = dictionary["email"] as? String
        user.token = dictionary["token"] as? String
        user.isActive = dictionary["isActive"] as? Bool
        user.lastLogin = dictionary["lastLogin"] as? Int
        user.isLearner = dictionary["isLearner"] as? Bool
        user.takeTutorial = dictionary["takeTutorial"] as? Bool
        user.roles = dictionary["roles"] as? [String]
        user.profilePic = dictionary["profilePic"] as? String
        
        return user
    }
    
}
