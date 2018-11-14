//
//  TutorialPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public protocol TutorialView: class {
    func opetaionFailed(message: String)
    func updateUserTakeTutorialSuccess(success: Bool)
}

public class TutorialPresenter {
    fileprivate weak var tutorialView : TutorialView?
    fileprivate let tutorialRepository : TutorialRepository
    
    init(repository: TutorialRepository) {
        self.tutorialRepository = repository
        self.tutorialRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : TutorialView) {
        tutorialView = view
    }
    
}

extension TutorialPresenter {
    public func updateUserTakeTutorial() {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.tutorialRepository.updateUserTakeTutorial()
        } else {
            self.tutorialView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
}

extension TutorialPresenter: TutorialPresenterDelegate {
    public func opetaionFailed(message: String) {
        self.tutorialView?.opetaionFailed(message: message)
    }
    
    public func updateUserTakeTutorialSuccess(success: Bool) {
        self.tutorialView?.updateUserTakeTutorialSuccess(success: success)
    }
    
    
}
