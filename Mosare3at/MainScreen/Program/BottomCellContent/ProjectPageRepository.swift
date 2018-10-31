//
//  ProjectPageRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/22/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

public protocol ProjectPagePresenterDelegate {
    func opetaionFailed(message: String)
    func getProjectsSuccess(projects: [Project])
    func getWeeksSuccess(weeks: [Week])
    func getCurrentWeekStatusSuccess(currentWeekStatus: CurrentWeekStatus)
    func updateFirstTimeWeekSuccess()
}

public class ProjectPageRepository {
    var delegate: ProjectPagePresenterDelegate!
    
    public func setDelegate(delegate: ProjectPagePresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getProjects(programId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        //"Content-Type" : "application/json",
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "programs/\(programId)/projects")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    let jsonArray = json["hydra:member"] as? [Dictionary<String,AnyObject>]
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        var projects = [Project]()
                        for dic in jsonArray! {
                            let project = Project.getInstance(dictionary: dic)
                            projects.append(project)
                        }
                        self.delegate.getProjectsSuccess(projects: projects)
                    } else {
                        let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                        self.delegate.opetaionFailed(message: jsonObj!["message"] as! String)
                    }
                } else {
                    let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                    self.delegate.opetaionFailed(message: jsonObj!["message"] as! String)
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func getWeeks(projectId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        //"Content-Type" : "application/json",
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "projects/\(projectId)/weeks")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                if let json = jsonObj!["hydra:member"] as? [Dictionary<String,AnyObject>] {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        var weeks = [Week]()
                        for dic in json {
                            let week = Week.getInstance(dictionary: dic)
                            weeks.append(week)
                        }
                        self.delegate.getWeeksSuccess(weeks: weeks)
                    } else {
                        let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                        self.delegate.opetaionFailed(message: jsonObj!["message"] as! String)
                    }
                } else {
                    let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                    self.delegate.opetaionFailed(message: jsonObj!["message"] as! String)
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func getCurrentWeekStatus(weekId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        
        let teamMemberId = Defaults[.teamMemberId]!.components(separatedBy: "/").get(at: Defaults[.teamMemberId]!.components(separatedBy: "/").count - 1)
        let url = CommonConstants.BASE_URL + "currentWeekStatus/\(teamMemberId!)/\(weekId)"
        
        Alamofire.request(URL(string: url)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let currentWeekStatus: CurrentWeekStatus = CurrentWeekStatus.getInstance(dictionary: json)
                        self.delegate.getCurrentWeekStatusSuccess(currentWeekStatus: currentWeekStatus)
                    } else {
                        let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                        self.delegate.opetaionFailed(message: jsonObj!["message"] as! String)
                    }
                } else {
                    let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                    self.delegate.opetaionFailed(message: jsonObj!["message"] as! String)
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func updateFirstTimeWeek() {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let subscriptionId = Defaults[.subscriptionId]!
        
        let url = CommonConstants.BASE_URL + "subscriptions/\(subscriptionId)"
        
        let firstTimeWeek = Subscribtion.getInstance(dictionary: Defaults[.subscription]!).firstTimeWeek
        
        let parameters = ["firstTimeWeek" : firstTimeWeek]
        
        Alamofire.request(URL(string: url)!, method: .put, parameters: parameters as [String: Any], encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let _ = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        self.delegate.updateFirstTimeWeekSuccess()
                    } else {
                        let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                        self.delegate.opetaionFailed(message: jsonObj!["message"] as! String)
                    }
                } else {
                    let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                    self.delegate.opetaionFailed(message: jsonObj!["message"] as! String)
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
}
