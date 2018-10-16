//
//  ProgramRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire

public protocol ProgramPresenterDelegate {
    func opetaionFailed(message: String)
    func getSubscriptionsSuccess(subscriptionsResponse: SubscribtionsResponse)
    func getTeamIdSuccess(teamId: String, teamMemberId: String)
    func getTeamSuccess(team: Team)
    func getWeekDeliverableSuccess(weekDeliverableResponse: WeekDeliverableResponse)
}

public class ProgramRepository {
    //getSubscribtions
    var delegate: ProgramPresenterDelegate!
    
    public func setDelegate(delegate: ProgramPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getSubscriptions(userId: Int, token: String) {
        let headers = ["X-AUTH-TOKEN" : token]
        //"Content-Type" : "application/json", 
        let parameters = ["user" : "/users/\(userId)"]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "subscriptions")!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 {
                        let subscriptionResponse = SubscribtionsResponse.getInstance(dictionary: json)
                        self.delegate.getSubscriptionsSuccess(subscriptionsResponse: subscriptionResponse)
                    } else {
                        self.delegate.opetaionFailed(message: json["message"] as! String)
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
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 {
                        
                        let members = json["hydra:member"] as! [Dictionary<String,Any>]
                        
                        for dic in members {
                            let memberDic = dic["member"] as! Dictionary<String,Any>
                            
                            if let memberId = memberDic["@id"], (memberId as! String) == "/users/\(userId)" {
                                self.delegate.getTeamIdSuccess(teamId: dic["team"] as! String, teamMemberId: dic["@id"] as! String)
                            }
                        }
                    } else {
                        self.delegate.opetaionFailed(message: json["message"] as! String)
                    }
                } else {
                    let errorResponse = response.result.value as? Dictionary<String,AnyObject>
                    self.delegate.opetaionFailed(message: errorResponse?["message"] as! String)
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
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 {
                        let team = Team.getInstance(dictionary: json)
                        self.delegate.getTeamSuccess(team: team)
                    } else {
                        self.delegate.opetaionFailed(message: json["message"] as! String)
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
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 {
                        let weekDeliverableResponse = WeekDeliverableResponse.getInstance(dictionary: json)
                        self.delegate.getWeekDeliverableSuccess(weekDeliverableResponse: weekDeliverableResponse)
                    } else {
                        self.delegate.opetaionFailed(message: json["message"] as! String)
                    }
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    
}
