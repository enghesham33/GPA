//
//  DefaultsKeys.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/2/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let user = DefaultsKey<Dictionary<String, Any>?>("user")
    static let fcmToken = DefaultsKey<String?>("fcm_token")
    static let token = DefaultsKey<String?>("token")
    static let isLoggedIn = DefaultsKey<Bool?>("isLoggedIn")
    static let subscriptionId = DefaultsKey<Int?>("subscriptionId")
    static let subscription = DefaultsKey<Dictionary<String, Any>?>("subscription")
    static let teamId = DefaultsKey<String?>("teamId")
    static let teamMemberId = DefaultsKey<String?>("teamMemberId")
    static let currentWeek = DefaultsKey<Dictionary<String, Any>?>("currentWeek")
}
