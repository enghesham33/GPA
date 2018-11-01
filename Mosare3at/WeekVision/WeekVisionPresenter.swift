//
//  WeekVisionPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/1/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public protocol WeekVisionView:class {
    func opetaionFailed(message: String)
    func getVideoLinksSuccess(link: String)
}

public class WeekVisionPresenter {
    fileprivate weak var weekVisionView : WeekVisionView?
    fileprivate let weekVisionRepository : WeekVisionRepository
    
    init(repository: WeekVisionRepository) {
        self.weekVisionRepository = repository
        self.weekVisionRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : WeekVisionView) {
        weekVisionView = view
    }
    
}

extension WeekVisionPresenter {
    public func getVideoLinks(videoId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.weekVisionRepository.getVideoLinks(videoId: videoId)
        } else {
            self.weekVisionView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
}

extension WeekVisionPresenter: WeekVisionPresenterDelegate {
    public func getVideoLinksSuccess(link: String) {
         UiHelpers.hideLoader()
        self.weekVisionView?.getVideoLinksSuccess(link: link)
    }
    
    public func opetaionFailed(message: String) {
        UiHelpers.hideLoader()
        self.weekVisionView?.opetaionFailed(message: message)
    }
}

