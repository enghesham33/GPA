//
//  MemberDetailsPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/27/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation


public protocol MemberDetailsView : class {
    func opetaionFailed(message: String)
    func getUserInfoSuccess(userInfo: UserInfo)
    func getVideosSuccess(videos: [Video])
    func getVideoLinkSuccess(videoLink: String, index: Int)
}


public class MemberDetailsPresenter {
    fileprivate weak var memberDetailsView : MemberDetailsView?
    fileprivate let memberDetailsRepository : MemberDetailsRepository!
    
    init(repository: MemberDetailsRepository) {
        self.memberDetailsRepository = repository
        self.memberDetailsRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : MemberDetailsView) {
        memberDetailsView = view
    }
}

extension MemberDetailsPresenter {
    public func getUserInfo(userId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.memberDetailsRepository.getUserInfo(userId: userId)
        } else {
            self.memberDetailsView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getVideos(programId: Int, userId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.memberDetailsRepository.getVideos(programId: programId, userId: userId)
        } else {
            self.memberDetailsView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getVideoLinks(videoId: Int, index: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.memberDetailsRepository.getVideoLinks(videoId: videoId, index: index)
        } else {
            self.memberDetailsView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
}

extension MemberDetailsPresenter: MemberDetailsPresenterDelegate {
    public func opetaionFailed(message: String) {
        UiHelpers.hideLoader()
        self.memberDetailsView?.opetaionFailed(message: message)
    }
    
    public func getUserInfoSuccess(userInfo: UserInfo) {
        self.memberDetailsView?.getUserInfoSuccess(userInfo: userInfo)
    }
    
    public func getVideosSuccess(videos: [Video]) {
        UiHelpers.hideLoader()
        self.memberDetailsView?.getVideosSuccess(videos: videos)
    }
    
    public func getVideoLinkSuccess(videoLink: String, index: Int) {
        UiHelpers.hideLoader()
        self.memberDetailsView?.getVideoLinkSuccess(videoLink: videoLink, index: index)
    }
    
    
}
