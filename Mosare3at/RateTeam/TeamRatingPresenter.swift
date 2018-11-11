//
//  TeamRatingPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/10/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
public protocol TeamRatingView:class {
    func opetaionFailed(message: String)
    func getTeamSuccess(team: Team)
    func getBadgesSuccess(badges: [Badge])
    func getTAMarksSuccess(marks: [TeacherAssistantMark])
    func rateTeamMembersSuccess()
    func rateTeacherAssistantSuccess()
    func updateUserBadgeSuccess()
}

public class TeamRatingPresenter {
    fileprivate weak var teamRatingView : TeamRatingView?
    fileprivate let teamRatingRepository : TeamRatingRepository
    var teamMembersNumber: Int!
    var ratedMembersNumber: Int = 0
    var updateBadgesNumber: Int = 0
    
    init(repository: TeamRatingRepository) {
        self.teamRatingRepository = repository
        self.teamRatingRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : TeamRatingView) {
        teamRatingView = view
    }
    
}

extension TeamRatingPresenter {
    public func getTeam(teamId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.teamRatingRepository.getTeam(teamId: teamId)
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getBadges() {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.teamRatingRepository.getBadges()
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getTAMarks() {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.teamRatingRepository.getTAMarks()
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func rateTheTeam(teamMembers: [TeamMember], weekRequestId: String) {
        teamMembersNumber = teamMembers.count
        for member in  teamMembers {
            if UiHelpers.isInternetAvailable() {
                UiHelpers.showLoader()
                self.teamRatingRepository.rateTeamMember(teamMember: member, weekRequestId: weekRequestId)
            } else {
                self.opetaionFailed(message: "noInternetConnection".localized())
            }
        }
    }
    
    public func updateTeamBadges(teamMembers: [TeamMember], weekRequestId: String) {
        teamMembersNumber = teamMembers.count
        for member in  teamMembers {
            if UiHelpers.isInternetAvailable() {
                UiHelpers.showLoader()
                self.teamRatingRepository.updateUserBadge(teamMember: member, weekRequestId: weekRequestId)
            } else {
                self.opetaionFailed(message: "noInternetConnection".localized())
            }
        }
    }
    
    public func rateTA(teacherAssistant: TeacherAssistant, weekRequestId: String) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.teamRatingRepository.rateTeacherAssistant(teacherAssistant: teacherAssistant, weekRequestId: weekRequestId)
        } else {
            self.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
}

extension TeamRatingPresenter: TeamRatingPresenterDelegate {
    public func getTAMarksSuccess(marks: [TeacherAssistantMark]) {
        self.teamRatingView?.getTAMarksSuccess(marks: marks)
    }
    
    public func getBadgesSuccess(badges: [Badge]) {
        self.teamRatingView?.getBadgesSuccess(badges: badges)
    }
    
    public func getTeamSuccess(team: Team) {
        self.teamRatingView?.getTeamSuccess(team: team)
    }
    
    
    public func opetaionFailed(message: String) {
        UiHelpers.hideLoader()
        self.teamRatingView?.opetaionFailed(message: message)
    }
    
    public func rateTeamMembersSuccess() {
        ratedMembersNumber = ratedMembersNumber + 1
        if ratedMembersNumber == teamMembersNumber {
            UiHelpers.hideLoader()
            self.teamRatingView?.rateTeamMembersSuccess()
        }
    }
    
    public func rateTeacherAssistantSuccess() {
        self.teamRatingView?.rateTeamMembersSuccess()
    }
    
    public func updateUserBadgeSuccess() {
        updateBadgesNumber = updateBadgesNumber + 1
        if updateBadgesNumber == teamMembersNumber {
            UiHelpers.hideLoader()
            self.teamRatingView?.updateUserBadgeSuccess()
        }
    }
    
}
