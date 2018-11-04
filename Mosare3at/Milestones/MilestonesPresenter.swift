//
//  MilestonesPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/4/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
public protocol MilestoneView:class {
    func opetaionFailed(message: String)
    func getMilestonesSuccess(milestones: [Milestone])
    func getUserAnswersSuccess(userAnswers: [UserAnswer])
    func updateUserAnswerSuccess(userAnswer: UserAnswer)
}

public class MilestonePresenter {
    fileprivate weak var milestoneView : MilestoneView?
    fileprivate let milestonesRepository : MilestonesRepository
    
    init(repository: MilestonesRepository) {
        self.milestonesRepository = repository
        self.milestonesRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : MilestoneView) {
        milestoneView = view
    }
    
}

extension MilestonePresenter {
    public func getMilestones(weekMaterialId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.milestonesRepository.getMilestones(weekMaterialId: weekMaterialId)
        } else {
            self.milestoneView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getUserAnswers(userId: Int, projectId: Int, weekId: Int, milestoneId: Int, questionId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.milestonesRepository.getUserAnswers(userId: userId, projectId: projectId, weekId: weekId, milestoneId: milestoneId, questionId: questionId)
        } else {
            self.milestoneView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func updateUserAnswers(userId: Int, projectId: Int, weekId: Int, milestoneId: Int, questionId: Int, userChoice: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.milestonesRepository.updateUserAnswers(userId: userId, projectId: projectId, weekId: weekId, milestoneId: milestoneId, questionId: questionId, userChoice: userChoice)
        } else {
            self.milestoneView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
}

extension MilestonePresenter: MilestonesPresenterDelegate {
    public func updateUserAnswerSuccess(userAnswer: UserAnswer) {
        self.milestoneView?.updateUserAnswerSuccess(userAnswer: userAnswer)
    }
    
    public func opetaionFailed(message: String) {
        self.milestoneView?.opetaionFailed(message: message)
    }
    
    public func getMilestonesSuccess(milestones: [Milestone]) {
        self.milestoneView?.getMilestonesSuccess(milestones: milestones)
    }
    
    public func getUserAnswersSuccess(userAnswers: [UserAnswer]) {
        self.milestoneView?.getUserAnswersSuccess(userAnswers: userAnswers)
    }
    
    
}
