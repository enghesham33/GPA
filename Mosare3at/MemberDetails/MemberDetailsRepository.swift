//
//  MemberDetailsRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/27/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults


public protocol MemberDetailsPresenterDelegate : class {
    func opetaionFailed(message: String)
    func getUserInfoSuccess(userInfo: UserInfo)
    func getVideosSuccess(videos: [Video])
    func getVideoLinkSuccess(videoLink: String, index: Int)
}

public class MemberDetailsRepository {
    
    var delegate: MemberDetailsPresenterDelegate!
    
    public func setDelegate(delegate: MemberDetailsPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getUserInfo(userId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
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
    
    public func getVideos(programId: Int, userId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "aws/get-user-videos/\(userId)/\(programId)")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON{
            (response) in
            
            if response.result.isSuccess {                
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
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func getVideoLinks(videoId: Int, index: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let params = ["video":videoId]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "aws/download")!, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
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
