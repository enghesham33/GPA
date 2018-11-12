//
//  ProgramRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

public protocol ProgramPresenterDelegate {
    func opetaionFailed(message: String)
    func getSubscriptionsSuccess(subscriptionsResponse: SubscribtionsResponse)
    func getTeamIdSuccess(teamId: String, teamMemberId: String)
    func getTeamSuccess(team: Team)
    func getWeekDeliverableSuccess(weekDeliverableResponse: WeekDeliverableResponse)
    func getWeekMaterialSuccess(weekMaterials: [WeekMaterial])
}

public class ProgramRepository {
    //getSubscribtions
    var delegate: ProgramPresenterDelegate!
    
    public func setDelegate(delegate: ProgramPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getSubscriptions(userId: Int, token: String) {
        let headers = ["X-AUTH-TOKEN" : token]
        let parameters = ["user" : "/users/\(userId)"]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "subscriptions")!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let subscriptionResponse = SubscribtionsResponse.getInstance(dictionary: json)
                        self.delegate.getSubscriptionsSuccess(subscriptionsResponse: subscriptionResponse)
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    func getTeamId(projectId: String, userId: Int, token: String) {
        
        let headers = ["X-AUTH-TOKEN" : token]
        
        let parameters = ["project" : projectId, "member":"/users/\(userId)"]
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "team_members")!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON {
            (response) in
            UiHelpers.hideLoader()
            
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        
                        let members = json["hydra:member"] as! [Dictionary<String,Any>]
                        
                        for dic in members {
                            let memberDic = dic["member"] as! Dictionary<String,Any>
                            
                            if let memberId = memberDic["@id"], (memberId as! String) == "/users/\(userId)" {
                                self.delegate.getTeamIdSuccess(teamId: dic["team"] as! String, teamMemberId: dic["@id"] as! String)
                            }
                        }
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                } else {
//                    let errorResponse = response.result.value as? Dictionary<String,AnyObject>
                    self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    func getTeam(teamId: Int, token: String) {
        let headers = ["X-AUTH-TOKEN" : token]
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "teams/\(teamId)")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let team = Team.getInstance(dictionary: json)
                        self.delegate.getTeamSuccess(team: team)
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    func getWeekDeliverables(token: String, parameters: [String : String]) {
        let headers = ["X-AUTH-TOKEN" : token]
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "week_deliverables")!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let weekDeliverableResponse = WeekDeliverableResponse.getInstance(dictionary: json)
                        self.delegate.getWeekDeliverableSuccess(weekDeliverableResponse: weekDeliverableResponse)
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func getWeekMaterials(weekId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let params = ["week":weekId]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "week_materials")!, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let jsonArray = json["hydra:member"] as? [Dictionary<String,AnyObject>]
                        var weekMaterials = [WeekMaterial]()
                        for dic in jsonArray! {
                            let weekMaterial = WeekMaterial.getInstance(dictionary: dic)
                            weekMaterials.append(weekMaterial)
                        }
                        self.delegate.getWeekMaterialSuccess(weekMaterials: weekMaterials)
                    } else {
//                        let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                } else {
//                    let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                    self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
}
