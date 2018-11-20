//
//  RegisteredProgram.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/20/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class RegisteredProgram {
    var id: Int!
    var title: String!
    var image: String!
    var projects: [RegisteredProject]!
    
    init() {
        
    }
    
    public func convertToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary["id"] = id
        dictionary["title"] = title
        dictionary["image"] = image
        if projects != nil {
            var projectsDicArray = [Dictionary<String, Any>]()
            
            for project in projects {
                projectsDicArray.append(project.convertToDictionary())
            }
            dictionary["projects"] = projectsDicArray
        }
        return dictionary
    }
    
    public static func getInstance(dictionary: Dictionary<String, Any>) -> RegisteredProgram {
        let registeredProject = RegisteredProgram()
        registeredProject.id =  dictionary["id"] as? Int
        registeredProject.title =  dictionary["title"] as? String
        registeredProject.image =  dictionary["image"] as? String
        if let projectsArrayDic = dictionary["projects"], projectsArrayDic is [Dictionary<String, Any>] {
            var projects: [RegisteredProject] = []
            for dic in projectsArrayDic as! [Dictionary<String, Any>] {
                projects.append(RegisteredProject.getInstance(dictionary: dic))
            }
            registeredProject.projects = projects
        }
        return registeredProject
    }
    
}
