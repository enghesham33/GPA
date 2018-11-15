//
//  DashboardPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public protocol DashboardView : class {
    func opetaionFailed(message: String)
    func getUserSuccess(user: User)
    func getBadgesSuccess(badges: [Badge])
    func getUserInfoSuccess(userInfo: UserInfo)
    func getTeamMembersSuccess(members: [TeamMember])
    func getAllMembersSuccess(members: [TeamMember])
    func getAllTeamsSuccess(teams: [Team])
}

public class DashboardPresenter {
    fileprivate weak var dashboardView : DashboardView?
    fileprivate let dashboardRepository : DashboardRepository
    
    init(repository: DashboardRepository) {
        self.dashboardRepository = repository
        self.dashboardRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : DashboardView) {
        dashboardView = view
    }
}

extension DashboardPresenter {
    public func getUser(userId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.dashboardRepository.getUserData(userId: userId)
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getBadges() {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.dashboardRepository.getBadges()
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getUserInfo() {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.dashboardRepository.getUserInfo()
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getTeamMembers(teamId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.dashboardRepository.getTeamMembers(teamId: teamId)
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getAllMembers() {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.dashboardRepository.getAllMembers(page: nil)
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getAllTeams() {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.dashboardRepository.getAllTeams(page: nil)
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
}

extension DashboardPresenter: DashboardPresenterDelegate {
    public func opetaionFailed(message: String) {
        self.dashboardView?.opetaionFailed(message: message)
    }
    
    public func getUserSuccess(user: User) {
        self.dashboardView?.getUserSuccess(user: user)
    }
    
    public func getBadgesSuccess(badges: [Badge]) {
        self.dashboardView?.getBadgesSuccess(badges: badges)
    }
    
    public func getUserInfoSuccess(userInfo: UserInfo) {
        self.dashboardView?.getUserInfoSuccess(userInfo: userInfo)
    }
    
    public func getTeamMembersSuccess(members: [TeamMember]) {
        self.dashboardView?.getTeamMembersSuccess(members: members)
    }
    
    public func getAllMembersSuccess(members: [TeamMember]) {
        self.dashboardView?.getAllMembersSuccess(members: members)
    }
    
    public func getAllTeamsSuccess(teams: [Team]) {
        UiHelpers.hideLoader()
        self.dashboardView?.getAllTeamsSuccess(teams: teams)
    }
    
}
