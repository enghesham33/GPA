//
//  DashboardRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

public protocol DashboardPresenterDelegate {
    func opetaionFailed(message: String)
    func getUserSuccess(user: User)
    func getBadgesSuccess(badges: [Badge])
    func getUserInfoSuccess(userInfo: UserInfo)
    func getTeamMembersSuccess(members: [TeamMember])
    func getAllMembersSuccess(members: [TeamMember])
    func getAllTeamsSuccess(teams: [Team])
}

public class DashboardRepository {
    //getSubscribtions
    var delegate: DashboardPresenterDelegate!
    
    public func setDelegate(delegate: DashboardPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getUserData(userId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "users/\(userId)")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let user = User.getInstance(dictionary: json)
                        self.delegate.getUserSuccess(user: user)
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                } else {
                    self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func getBadges() {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "badges")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let jsonArray = json["hydra:member"] as? [Dictionary<String,AnyObject>]
                        var badges = [Badge]()
                        for dic in jsonArray! {
                            let badge = Badge.getInstance(dictionary: dic)
                            badges.append(badge)
                        }
                        self.delegate.getBadgesSuccess(badges: badges)
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                } else {
                    self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func getUserInfo() {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let userId = User.getInstance(dictionary: Defaults[.user]!).id!
        let programId = Subscribtion.getInstance(dictionary: Defaults[.subscription]!).program.requestId.components(separatedBy: "/")[Subscribtion.getInstance(dictionary: Defaults[.subscription]!).program.requestId.components(separatedBy: "/").count - 1]
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "getUserInfo/\(userId)/\(programId)")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let userInfo = UserInfo.getInstance(dictionary: json)
                        self.delegate.getUserInfoSuccess(userInfo: userInfo)
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                } else {
                    self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func getTeamMembers(teamId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "teams/\(teamId)")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let team = Team.getInstance(dictionary: json)
                        var filteredTeamMembers = [TeamMember]()
                        for member in team.teamMembers {
                            if member.status == "active" || member.status == "ended" {
                                filteredTeamMembers.append(member)
                            }
                        }
                        self.delegate.getTeamMembersSuccess(members: filteredTeamMembers)
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func getAllMembers(page: String?) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let programId = Subscribtion.getInstance(dictionary: Defaults[.subscription]!).program.requestId.components(separatedBy: "/")[Subscribtion.getInstance(dictionary: Defaults[.subscription]!).program.requestId.components(separatedBy: "/").count - 1]
        
        var parameters = ["program": programId, "status" : "active"] as [String : Any]
        if let _ = page {
            parameters["page"] = page
        }
        var members = [TeamMember]()
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "program_points")!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        
                        let membersJsonArray = json["hydra:member"] as? [Dictionary<String,AnyObject>]
                        
                        for dic in membersJsonArray! {
                            let member = TeamMember.getInstance(dictionary: dic)
                            members.append(member)
                        }
                        
                        let hydraView = json["hydra:view"] as? Dictionary<String,AnyObject>
                        if let next = hydraView!["hydra:next"] as? String {
                            let page = next.components(separatedBy: "=")[next.components(separatedBy: "=").count - 1]
                            self.getAllMembers(page: page)
                        } else {
                            self.delegate.getAllMembersSuccess(members: members)
                        }
                        
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func getAllTeams(page: String?) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        
        let projectId = Subscribtion.getInstance(dictionary: Defaults[.subscription]!).project.requestId.components(separatedBy: "/")[Subscribtion.getInstance(dictionary: Defaults[.subscription]!).project.requestId.components(separatedBy: "/").count - 1]
        
        var parameters = ["project": projectId]
        
        if let _ = page {
            parameters["page"] = page
        }
        
         var teams = [Team]()
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "teams")!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let membersJsonArray = json["hydra:member"] as? [Dictionary<String,AnyObject>]
                        
                        for dic in membersJsonArray! {
                            let team = Team.getInstance(dictionary: dic)
                            teams.append(team)
                        }
                        
                        let hydraView = json["hydra:view"] as? Dictionary<String,AnyObject>
                        if let next = hydraView!["hydra:next"] as? String {
                            let page = next.components(separatedBy: "=")[next.components(separatedBy: "=").count - 1]
                            self.getAllTeams(page: page)
                        } else {
                            self.delegate.getAllTeamsSuccess(teams: teams)
                        }
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    
}
