//
//  ProjectPagerPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/22/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public protocol ProjectPageView : class {
    func opetaionFailed(message: String)
    func getProjectsSuccess(projects: [Project])
    func getWeeksSuccess(weeks: [Week])
    func getCurrentWeekStatusSuccess(currentWeekStatus: CurrentWeekStatus)
}

public class ProjectPagerPresenter {
    fileprivate weak var projectPageView : ProjectPageView?
    fileprivate let projectPageRepository : ProjectPageRepository
    
    init(repository: ProjectPageRepository) {
        self.projectPageRepository = repository
        self.projectPageRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : ProjectPageView) {
        projectPageView = view
    }
    
}

extension ProjectPagerPresenter {
    public func getProjects(programId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
             self.projectPageRepository.getProjects(programId: programId)
        } else {
            self.projectPageView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getWeeks(projectId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.projectPageRepository.getWeeks(projectId: projectId)
        } else {
            self.projectPageView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
    
    public func getCurrentWeekStatus(weekId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.projectPageRepository.getCurrentWeekStatus(weekId: weekId)
        } else {
            self.projectPageView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
}

extension ProjectPagerPresenter : ProjectPagePresenterDelegate {
    
    public func opetaionFailed(message: String) {
        UiHelpers.hideLoader()
        self.projectPageView?.opetaionFailed(message: message)
    }
    
    public func getProjectsSuccess(projects: [Project]) {
        UiHelpers.hideLoader()
        self.projectPageView?.getProjectsSuccess(projects: projects)
    }
    
    public func getWeeksSuccess(weeks: [Week]) {
        UiHelpers.hideLoader()
        self.projectPageView?.getWeeksSuccess(weeks: weeks)
    }
    
    public func getCurrentWeekStatusSuccess(currentWeekStatus: CurrentWeekStatus) {
        UiHelpers.hideLoader()
        self.projectPageView?.getCurrentWeekStatusSuccess(currentWeekStatus: currentWeekStatus)
    }
}
