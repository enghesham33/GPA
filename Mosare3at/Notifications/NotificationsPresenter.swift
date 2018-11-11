//
//  NotificationsPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public protocol NotificationsView:class {
    func opetaionFailed(message: String)
    func getNotificationsSuccess(notifications: [NotificationObj], nextPage: String)
}

public class NotificationsPresenter {
    fileprivate weak var notificationsView : NotificationsView?
    fileprivate let notificationsRepository : NotificationsRepository
    
    init(repository: NotificationsRepository) {
        self.notificationsRepository = repository
        self.notificationsRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : NotificationsView) {
        notificationsView = view
    }
}

extension NotificationsPresenter {
    public func getNotifications(url: String) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            self.notificationsRepository.getNotSeenNotifications(url: url)
        } else {
            self.notificationsView?.opetaionFailed(message: "noInternetConnection".localized())
        }
    }
}

extension NotificationsPresenter: NotificationsPresenterDelegate {
    public func opetaionFailed(message: String) {
        self.notificationsView?.opetaionFailed(message: message)
    }
    
    public func getNotificationsSuccess(notifications: [NotificationObj], nextPage: String) {
        self.notificationsView?.getNotificationsSuccess(notifications: notifications, nextPage: nextPage)
    }
}
