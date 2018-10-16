//
//  Thumbnail.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class Thumbnail {
    
    var thumb: String!
    var height: String!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["thumb"] = thumb
        dictionary["height"] = height
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Thumbnail {
        
        let thumbnail = Thumbnail()
        thumbnail.thumb =  dictionary["thumb"] as? String
        thumbnail.height =  dictionary["height"] as? String
        return thumbnail
    }
    
}
