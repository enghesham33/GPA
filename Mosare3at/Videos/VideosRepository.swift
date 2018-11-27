//
//  VideosRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

public protocol VideosPresenterDelegate: class {
    func opetaionFailed(message: String)
    func getVideosSuccess(videos: [Video])
    func getProjectsSuccess(projects: [Project])
    func getTeamsSuccess(teams: [Team])
    func getVideoLinkSuccess(videoLink: String, index: Int)
}

public class VideosRepository {
    var delegate: VideosPresenterDelegate!
    
    public func setDelegate(delegate: VideosPresenterDelegate) {
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
    
    public func getTeams(projectId: Int?) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        var params = [String: Any]()
        if let _ = projectId {
            params["project"] = projectId
        }
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "teams")!, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let jsonArray = json["hydra:member"] as? [Dictionary<String,AnyObject>]
                        var teams: [Team] = [Team]()
                        for dic in jsonArray! {
                            let team = Team.getInstance(dictionary: dic)
                            teams.append(team)
                        }
                        self.delegate.getTeamsSuccess(teams: teams)
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func getVideos(programId: Int?, projectId: Int?, teamId: Int?, order: String, isFromProfile: Bool?) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let userId = User.getInstance(dictionary: Defaults[.user]!).id!
        
        var parameters = ["order" : order] as [String : Any]
        
        var defaultUrl = "aws/get-videos-by-filter"
        var method: HTTPMethod = .post
        var parameterEncoding: ParameterEncoding = JSONEncoding.default
        
        
        if let _ = isFromProfile {
            defaultUrl = "aws/get-user-videos/\(userId)/\(programId!)"
            method = .get
            parameterEncoding = URLEncoding.default
            
        } else {
            if let _ = programId {
                parameters["program"] =  programId
            }
            
            if let _ = projectId {
                parameters["project"] =  projectId
            }
            
            if let _ = teamId {
                parameters["team"] =  teamId
            }
        }
        
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + defaultUrl)!, method: method, parameters: parameters, encoding: parameterEncoding, headers: headers).responseJSON{
            (response) in
            
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                
                if let _ = isFromProfile {
                    if let json = response.result.value as? Dictionary<String,AnyObject> {
                        if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                            var videos: [Video] = [Video]()
                            let jsonArray = json["videos"] as? [Dictionary<String,AnyObject>]
                            
                            for dic in jsonArray! {
                                let video = Video()
                                video.id = dic["id"] as? Int
                                let uploadDateDic = dic["uploadedDate"] as? Dictionary<String,AnyObject>
                                video.uploadDate = uploadDateDic!["date"] as? String
                                if let thumbnailsDic = dic["thumbnail"], thumbnailsDic is [Dictionary<String, Any>] {
                                    var thumbnails: [Thumbnail] = []
                                    for dic in thumbnailsDic as! [Dictionary<String, Any>] {
                                        thumbnails.append(Thumbnail.getInstance(dictionary: dic))
                                    }
                                    video.thumbnails =  thumbnails
                                }
                                video.description = dic["description"] as? String
                                if let ownerDic = dic["owner"], ownerDic is  Dictionary<String, Any> {
                                    video.owner =  User.getInstance(dictionary: ownerDic as! Dictionary<String, Any>)
                                }
                                videos.append(video)
                            }
                            self.delegate.getVideosSuccess(videos: videos)
                            
                        } else {
                            self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                        }
                    } else {
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                } else {
                    if let json = response.result.value as? [[Dictionary<String,AnyObject>]] {
                        if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                            
                            let jsonArray = json[0]
                            var videos: [Video] = [Video]()
                            for dic in jsonArray {
                                let video = Video()
                                video.id = dic["id"] as? Int
                                let uploadDateDic = dic["uploadedDate"] as? Dictionary<String,AnyObject>
                                video.uploadDate = uploadDateDic!["date"] as? String
                                if let thumbnailsDic = dic["thumbnail"], thumbnailsDic is [Dictionary<String, Any>] {
                                    var thumbnails: [Thumbnail] = []
                                    for dic in thumbnailsDic as! [Dictionary<String, Any>] {
                                        thumbnails.append(Thumbnail.getInstance(dictionary: dic))
                                    }
                                    video.thumbnails =  thumbnails
                                }
                                video.description = dic["description"] as? String
                                if let ownerDic = dic["owner"], ownerDic is  Dictionary<String, Any> {
                                    video.owner =  User.getInstance(dictionary: ownerDic as! Dictionary<String, Any>)
                                }
                                videos.append(video)
                            }
                            self.delegate.getVideosSuccess(videos: videos)
                        } else {
                            self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                        }
                    }
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func getVideoLinks(videoId: Int, index: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let params = ["video":videoId]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "aws/download")!, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let jsonArray = json["results"] as? [Dictionary<String,AnyObject>]
                        let dic = jsonArray![1]
                        
                        self.delegate.getVideoLinkSuccess(videoLink: dic["360"] as! String, index: index)
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


