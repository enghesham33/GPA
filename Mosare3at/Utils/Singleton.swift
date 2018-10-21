//
//  Singleton.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class Singleton {
    
    static var instance: Singleton!
    
    public class func getInstance() -> Singleton {
        if instance ==  nil {
            instance = Singleton()
        }
        return instance
    }
    
    var sideMenuDoneTasksCount: Int!
    var sideMenuTotalTasksCount: Int!
    
}

