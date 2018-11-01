//
//  WeekDetailsPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/1/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
public protocol WeekDetailsView:class {
    func opetaionFailed(message: String)
    func getWeekMaterialSuccess(weekMaterials: [WeekMaterial])
}

public class WeekDetailsPresenter {
    fileprivate weak var weekDetailsView : WeekDetailsView?
    fileprivate let weekDetailsRepository : WeekDetailsRepository
    
    init(repository: WeekDetailsRepository) {
        self.weekDetailsRepository = repository
        self.weekDetailsRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : WeekDetailsView) {
        weekDetailsView = view
    }
    
}

extension WeekDetailsPresenter {
    public func getWeekMaterials(weekId: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.weekDetailsRepository.getWeekMaterials(weekId: weekId)
        } else {
            self.weekDetailsView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
}

extension WeekDetailsPresenter: WeekDetailsPresenterDelegate {
    public func opetaionFailed(message: String) {
        UiHelpers.hideLoader()
        self.weekDetailsView?.opetaionFailed(message: message)
    }
    
    public func getWeekMaterialSuccess(weekMaterials: [WeekMaterial]) {
        UiHelpers.hideLoader()
        self.weekDetailsView?.getWeekMaterialSuccess(weekMaterials: weekMaterials)
    }
}
