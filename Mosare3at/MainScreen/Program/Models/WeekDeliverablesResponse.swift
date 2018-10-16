//
//  WeekDeliverablesResponse.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
public class WeekDeliverableResponse {
    
    var hydraMember: [WeekDeliverable]!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        var weekDeliverableDicArray = [Dictionary<String, Any>]()
        
        for weekDeliverable in hydraMember {
            weekDeliverableDicArray.append(weekDeliverable.convertToDictionary())
        }
        
        dictionary["hydra:member"] = weekDeliverableDicArray
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> WeekDeliverableResponse {
        let subscribtionResponse = WeekDeliverableResponse()
        let subcscriptionsDicArray = dictionary["hydra:member"] as! [Dictionary<String, Any>]
        var hydraMember: [WeekDeliverable] = []
        for dic in subcscriptionsDicArray {
            hydraMember.append(WeekDeliverable.getInstance(dictionary: dic))
        }
        subscribtionResponse.hydraMember =  hydraMember
        return subscribtionResponse
    }
}
