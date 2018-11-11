//
//  NotificationsVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

class NotificationsVC: BaseVC {

    var layout: NotificationsLayout!
    
    var notifications: [NotificationObj]!
    
    var nextPage: String!
    
    var presenter: NotificationsPresenter!
    
    public static func buildVC() -> NotificationsVC {
        let vc = NotificationsVC()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = NotificationsLayout(superview: self.view, notificationsLayoutDelegate: self, screenTitle: "notifications".localized())
        layout.setupViews()
        layout.notificationsTableView.dataSource = self
        layout.notificationsTableView.delegate = self
        
        presenter = Injector.provideNotificationsPresenter()
        presenter.setView(view: self)
        getNotifications(url: CommonConstants.BASE_URL + "notifications?flag=mob&both")
        
    }
    
    func getNotifications(url: String) {
        presenter.getNotifications(url: url)
    }
}

extension NotificationsVC: NotificationsView {
    func opetaionFailed(message: String) {
        self.view.makeToast(message)
    }
    
    func getNotificationsSuccess(notifications: [NotificationObj], nextPage: String) {
        self.notifications = notifications
        self.nextPage = nextPage
        
        self.layout.notificationsTableView.reloadData()
    }
}

extension NotificationsVC: NotificationsLayoutDelegate {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func retry() {
        
    }
}

extension NotificationsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notifications != nil {
            return notifications.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NotificationCell = self.layout.notificationsTableView.dequeueReusableCell(withIdentifier: NotificationCell.identifier, for: indexPath) as! NotificationCell
        cell.selectionStyle = .none
        cell.notification = self.notifications.get(at: indexPath.row)!
        cell.setupViews()
        cell.populateData()
        
        if indexPath.row == notifications.count - 1 && nextPage != nil && !nextPage.isEmpty {
            getNotifications(url: self.nextPage)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15)
    }
}
