//
//  TeamRatingRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/10/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

public protocol TeamRatingPresenterDelegate {
    func opetaionFailed(message: String)
    func getTeamSuccess(team: Team)
    func getBadgesSuccess(badges: [Badge])
    func getTAMarksSuccess(marks: [TeacherAssistantMark])
    func rateTeamMembersSuccess()
    func rateTeacherAssistantSuccess()
    func updateUserBadgeSuccess()
}

public class TeamRatingRepository {
    var delegate: TeamRatingPresenterDelegate!
    
    public func setDelegate(delegate: TeamRatingPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getTeam(teamId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
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
    
    public func getBadges() {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "badges")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            UiHelpers.hideLoader()
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
                        let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                } else {
                    let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                    self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func getTAMarks() {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "ta_marks")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let jsonArray = json["hydra:member"] as? [Dictionary<String,AnyObject>]
                        var marks = [TeacherAssistantMark]()
                        for dic in jsonArray! {
                            let mark = TeacherAssistantMark.getInstance(dictionary: dic)
                            marks.append(mark)
                        }
                        self.delegate.getTAMarksSuccess(marks: marks)
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
    
    public func rateTeacherAssistant(teacherAssistant: TeacherAssistant, weekRequestId: String) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        var parameters = ["taMarks" : teacherAssistant.selectedMarks, "teacherAssistant" : teacherAssistant.requestId, "ratedBy" : "/users/\(User.getInstance(dictionary: Defaults[.user]!).id)", "team": Defaults[.teamId]!, "week" : weekRequestId, "points" : teacherAssistant.points] as [String : Any]
        
        if teacherAssistant.comment != nil && !teacherAssistant.comment.isEmpty {
            parameters["comment"] = teacherAssistant.comment
        } else {
            parameters["comment"] = " "
        }
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "ta_rating")!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        self.delegate.rateTeacherAssistantSuccess()
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
    
    public func rateTeamMember(teamMember: TeamMember, weekRequestId: String) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        
        var parameters = ["ratedUser" : "/users/\(teamMember.member.id!)", "ratedBy" : "/users/\(User.getInstance(dictionary: Defaults[.user]!).id!)", "team": Defaults[.teamId]!, "week" : weekRequestId] as [String : Any]
        
        var badge = Badge()
        for selectedBadge in teamMember.badges {
            if selectedBadge.isSelected {
                badge = selectedBadge
                break
            }
        }
        
        if badge.id != nil {
            parameters["badge"] = badge.requestId
        }
        
        if teamMember.comment != nil && !teamMember.comment.isEmpty {
            parameters["comment"] = teamMember.comment
        } else {
            parameters["comment"] = " "
        }
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "team_ratings")!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            (response) in
            
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let _ = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        self.delegate.rateTeamMembersSuccess()
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
    
    public func updateUserBadge(teamMember: TeamMember, weekRequestId: String) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        var badge = Badge()
        for selectedBadge in teamMember.badges {
            if selectedBadge.isSelected {
                badge = selectedBadge
                break
            }
        }
        
        
        var parameters = ["teamMember" : teamMember.requestId, "activity" : "activities/2", "badge": badge.requestId, "week" : weekRequestId] as [String : Any]
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "team_ratings")!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            (response) in
            
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let _ = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        self.delegate.updateUserBadgeSuccess()
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
}
