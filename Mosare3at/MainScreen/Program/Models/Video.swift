//
//  Video.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class Video {
    
    var thumbnails: [Thumbnail]!
    var requestId: String!
    var id: Int!
    var title: String!
    var description: String!
    var accessMode: String!
    var uploadDate: String!
    var owner: User!
    
    var videoLink: String! // for internal usage
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["@id"] = requestId
        dictionary["id"] = id
        dictionary["title"] = title
        dictionary["description"] = description
        var thumbnailsDicArray = [Dictionary<String, Any>]()
        for thumb in thumbnails {
            thumbnailsDicArray.append(thumb.convertToDictionary())
        }
        dictionary["thumbnail"] = thumbnailsDicArray
        dictionary["accessMode"] = accessMode
        dictionary["uploadDate"] = uploadDate
        dictionary["owner"] = owner.convertToDictionary()
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Video {
        
        let video = Video()
        video.requestId =  dictionary["@id"] as? String
        video.id =  dictionary["id"] as? Int
        video.title =  dictionary["title"] as? String
        video.description =  dictionary["description"] as? String
        
        if let thumbnailsDic = dictionary["thumbnail"], thumbnailsDic is [Dictionary<String, Any>] {
            var thumbnails: [Thumbnail] = []
            for dic in thumbnailsDic as! [Dictionary<String, Any>] {
                thumbnails.append(Thumbnail.getInstance(dictionary: dic))
            }
            video.thumbnails =  thumbnails
        }
        
        if let ownerDic = dictionary["owner"], ownerDic is  Dictionary<String, Any> {
            video.owner =  User.getInstance(dictionary: ownerDic as! Dictionary<String, Any>)
        }
        video.accessMode =  dictionary["accessMode"] as? String
        video.uploadDate =  dictionary["uploadDate"] as? String
        return video
    }
    
}
