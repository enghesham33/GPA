//
//  VideosPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public protocol VideosView: class {
    func opetaionFailed(message: String)
    func getVideosSuccess(videos: [Video])
    func getProjectsSuccess(projects: [Project])
    func getTeamsSuccess(teams: [Team])
    func getVideoLinkSuccess(videoLink: String, index: Int)
}

public class VideosPresenter {
    fileprivate weak var videosView : VideosView?
    fileprivate let videosRepository : VideosRepository
    
    init(repository: VideosRepository) {
        self.videosRepository = repository
        self.videosRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : VideosView) {
        videosView = view
    }
}

extension VideosPresenter {
    
    public func getProjects(programId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.videosRepository.getProjects(programId: programId)
        } else {
            self.videosView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getTeams(projectId: Int?) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.videosRepository.getTeams(projectId: projectId)
        } else {
            self.videosView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getVideos(programId: Int?, projectId: Int?, teamId: Int?, order: String, isFromProfile: Bool?) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.videosRepository.getVideos(programId: programId, projectId: projectId, teamId: teamId, order: order, isFromProfile: isFromProfile)
        } else {
            self.videosView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getVideoLinks(videoId: Int, index: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.videosRepository.getVideoLinks(videoId: videoId, index: index)
        } else {
            self.videosView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
//    public func updateUserPoints(points: Int) {
//        if UiHelpers.isInternetAvailable() {
//            self.videosRepository.updateUserPoints(points: points)
//        } else {
//            self.videosView?.opetaionFailed(message: "noInternetConnection".localized())
//        }
//    }
}

extension VideosPresenter: VideosPresenterDelegate {
    public func getVideoLinkSuccess(videoLink: String, index: Int) {
        self.videosView?.getVideoLinkSuccess(videoLink: videoLink, index: index)
    }
    
    public func opetaionFailed(message: String) {
        self.videosView?.opetaionFailed(message: message)
    }
    
    public func getVideosSuccess(videos: [Video]) {
        UiHelpers.hideLoader()
        self.videosView?.getVideosSuccess(videos: videos)
    }
    
    public func getProjectsSuccess(projects: [Project]) {
         UiHelpers.hideLoader()
        self.videosView?.getProjectsSuccess(projects: projects)
    }
    public func getTeamsSuccess(teams: [Team]) {
         UiHelpers.hideLoader()
        self.videosView?.getTeamsSuccess(teams: teams)
    }
    
    
}
