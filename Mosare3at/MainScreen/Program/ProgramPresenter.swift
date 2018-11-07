//
//  ProgramPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/16/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public protocol ProgramView : class {
    func opetaionFailed(message: String)
    func getSubscriptionsSuccess(subscriptionsResponse: SubscribtionsResponse)
    func getTeamIdSuccess(teamId: String, teamMemberId: String)
    func getTeamSuccess(team: Team)
    func getWeekDeliverableSuccess(weekDeliverableResponse: WeekDeliverableResponse)
    func getWeekMaterialSuccess(weekMaterials: [WeekMaterial])
}

public class ProgramPresenter {
    fileprivate weak var programView : ProgramView?
    fileprivate let programRepository : ProgramRepository
    
    init(repository: ProgramRepository) {
        self.programRepository = repository
        self.programRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : ProgramView) {
        programView = view
    }
}

extension ProgramPresenter {
    
    public func getSubscriptions(userId: Int, token: String) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.programRepository.getSubscriptions(userId: userId, token: token)
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
        
    }
    
    public func getTeamId(projectId: String, userId: Int, token: String) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.programRepository.getTeamId(projectId: projectId, userId: userId, token: token)
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getTeam(teamId: Int, token: String) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.programRepository.getTeam(teamId: teamId, token: token)
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getWeekDeliverables(parameters: [String:String], token: String) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.programRepository.getWeekDeliverables(token: token, parameters: parameters)
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getWeekMaterials(weekId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.programRepository.getWeekMaterials(weekId: weekId)
        } else {
            self.programView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
}

extension ProgramPresenter: ProgramPresenterDelegate {
    public func opetaionFailed(message: String) {
        self.programView?.opetaionFailed(message: message)
    }
    
    public func getSubscriptionsSuccess(subscriptionsResponse: SubscribtionsResponse) {
        self.programView?.getSubscriptionsSuccess(subscriptionsResponse: subscriptionsResponse)
    }
    
    public func getTeamIdSuccess(teamId: String, teamMemberId: String) {
        self.programView?.getTeamIdSuccess(teamId: teamId, teamMemberId: teamMemberId)
    }
    
    public func getTeamSuccess(team: Team) {
        self.programView?.getTeamSuccess(team: team)
    }
    
    public func getWeekDeliverableSuccess(weekDeliverableResponse: WeekDeliverableResponse) {
        self.programView?.getWeekDeliverableSuccess(weekDeliverableResponse: weekDeliverableResponse)
    }
    
    public func getWeekMaterialSuccess(weekMaterials: [WeekMaterial]) {
        UiHelpers.hideLoader()
        self.programView?.getWeekMaterialSuccess(weekMaterials: weekMaterials)
    }
}
