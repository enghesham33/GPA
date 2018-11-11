//
//  MilestonesRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/4/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

public protocol MilestonesPresenterDelegate {
    func opetaionFailed(message: String)
    func getMilestonesSuccess(milestones: [Milestone])
    func getUserAnswersSuccess(userAnswers: [UserAnswer])
    func updateUserAnswerSuccess(userAnswer: UserAnswer)
}

public class MilestonesRepository {
    var delegate: MilestonesPresenterDelegate!
    
    public func setDelegate(delegate: MilestonesPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getMilestones(weekMaterialId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let params = ["weekMaterial":weekMaterialId]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "milestones")!, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let jsonArray = json["hydra:member"] as? [Dictionary<String,AnyObject>]
                        var milestones = [Milestone]()
                        for dic in jsonArray! {
                            let milestone = Milestone.getInstance(dictionary: dic)
                            milestones.append(milestone)
                        }
                        self.delegate.getMilestonesSuccess(milestones: milestones)
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
    
    public func getUserAnswers(userId: Int, projectId: Int, weekId: Int, milestoneId: Int, questionId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let params = ["user":userId, "project": projectId, "week": weekId, "milestone": milestoneId, "question": questionId]
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "user_answers")!, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let jsonArray = json["hydra:member"] as? [Dictionary<String,AnyObject>]
                        var userAnswers = [UserAnswer]()
                        for dic in jsonArray! {
                            let userAnswer = UserAnswer.getInstance(dictionary: dic)
                            userAnswers.append(userAnswer)
                        }
                        self.delegate.getUserAnswersSuccess(userAnswers: userAnswers)
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
    
    public func updateUserAnswers(userId: Int, projectId: Int, weekId: Int, milestoneId: Int, questionId: Int, userChoice: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!, "Content-Type" : "application/json"]
        let params = ["user":"/users/\(userId)", "project": "/projects/\(projectId)", "week": "/weeks/\(weekId)", "milestone": "/milestones/\(milestoneId)", "question": "/questions/\(questionId)", "userChoice": userChoice] as [String : Any]
       
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "user_answers")!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let userAnswer = UserAnswer.getInstance(dictionary: json)
                        self.delegate.updateUserAnswerSuccess(userAnswer: userAnswer)
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


