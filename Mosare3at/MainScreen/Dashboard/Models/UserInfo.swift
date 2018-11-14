//
//  UserInfo.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class UserInfo {
    
    var user: User!
    var currentTeamId: Int!
    var currentTeamName: String!
    var currentTeamImage: String!
    var rank: Int!
    var totalPoints: Int!
    var totalBadges: Int!
    var badges: [Badge]!
    var videos: Int!
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        if user != nil {
            dictionary["user"] = user.convertToDictionary()
        }
        
        dictionary["currentTeamId"] = currentTeamId
        dictionary["currentTeamName"] = currentTeamName
        dictionary["currentTeamImage"] = currentTeamImage
        dictionary["rank"] = rank
        dictionary["totalPoints"] = totalPoints
        dictionary["totalBadges"] = totalBadges

        if badges != nil {
            var badgessDicArray = [Dictionary<String, Any>]()
            
            for badge in badges {
                badgessDicArray.append(badge.convertToDictionary())
            }
            dictionary["badges"] = badgessDicArray
        }
        
        dictionary["videos"] = videos
        
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> UserInfo {
        
        let userInfo = UserInfo()
        
        if let userDic = dictionary["user"], userDic is Dictionary<String, Any> {
            userInfo.user = User.getInstance(dictionary: userDic as! Dictionary<String, Any>)
        }
        
        userInfo.currentTeamId = dictionary["currentTeamId"] as? Int
        userInfo.currentTeamName = dictionary["currentTeamName"] as? String
        userInfo.currentTeamImage = dictionary["currentTeacurrentTeamImagemId"] as? String
        userInfo.rank = dictionary["rank"] as? Int
        userInfo.totalPoints = dictionary["totalPoints"] as? Int
        userInfo.totalBadges = dictionary["totalBadges"] as? Int
        
        if let badgesArrayDic = dictionary["badges"], badgesArrayDic is [Dictionary<String, Any>] {
            var badges: [Badge] = []
            for dic in badgesArrayDic as! [Dictionary<String, Any>] {
                badges.append(Badge.getInstance(dictionary: dic))
            }
            userInfo.badges = badges
        }
        
        userInfo.videos = dictionary["videos"] as? Int
        
        return userInfo
    }
    
}
