//
//  Program.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Program {
    
    var requestId: String!
    var title: String!
    var bgImage: String!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["@id"] = requestId
        dictionary["title"] = title
        dictionary["bgImage"] = bgImage
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> Program {
        let program = Program()
        program.requestId =  dictionary["@id"] as? String
        program.title =  dictionary["title"] as? String
        program.bgImage =  dictionary["bgImage"] as? String
        return program
    }
}

