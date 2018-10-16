//
//  Subscribtion.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SubscribtionsResponse {
    
    var hydraMember: [Subscribtion]!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        var subscriptionDicArray = [Dictionary<String, Any>]()
        
        for subscription in hydraMember {
            subscriptionDicArray.append(subscription.convertToDictionary())
        }
        
        dictionary["hydra:member"] = subscriptionDicArray
        
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> SubscribtionsResponse {
        let subscribtionResponse = SubscribtionsResponse()
        let subcscriptionsDicArray = dictionary["hydra:member"] as! [Dictionary<String, Any>]
        var hydraMember: [Subscribtion] = []
        for dic in subcscriptionsDicArray {
            hydraMember.append(Subscribtion.getInstance(dictionary: dic))
        }
        subscribtionResponse.hydraMember =  hydraMember
        return subscribtionResponse
    }
}
