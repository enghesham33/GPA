//
//  DashboardVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SideMenu
import Localize_Swift

class DashboardVC: BaseVC, UISideMenuNavigationControllerDelegate {
    
    var layout : DashboardLayout!
    
    static func buildVC() -> DashboardVC {
        return DashboardVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout = DashboardLayout(superview: self.view, dashboardLayoutDelegate: self)
        layout.setupViews()
        
        if AppDelegate.instance.unreadNotificationsNumber > 0 {
            self.layout.topView.notificationsNumberLabel.text = "\(AppDelegate.instance.unreadNotificationsNumber)"
        }
        
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: CommonConstants.NOTIFICATIONS_UPDATED),
                                               object: self,
                                               queue: OperationQueue.main,
                                               using: notificationsUpdated(noti:))
    }
    
    func notificationsUpdated(noti: Notification) {
        self.layout.topView.notificationsNumberLabel.text = "\(AppDelegate.instance.unreadNotificationsNumber)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UiHelpers.setupSideMenu(delegate: self, viewToPresent: self.layout.topView.backImageView, viewToEdge: self.view, sideMenuCellDelegate: self, sideMenuHeaderDelegate: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension DashboardVC: SideMenuHeaderDelegate {
    func headerClicked() {
         print("dashboard ::  header clicked")
    }
}

extension DashboardVC: SideMenuCellDelegate {
    func sideMenuItemSelected(index: Int) {
         print("dashboard :: item \(index) clicked")
    }
}

extension DashboardVC : DashboardLayoutDelegate {
    func goToNotificationsScreen() {
        self.navigator = Navigator(navController: self.navigationController!)
        self.navigator.navigateToNotifications()
    }
    
    func retry() {
        
    }
    
    func openSideMenu() {
        if Localize.currentLanguage() == "en" {
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        } else {
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
        
    }
}
