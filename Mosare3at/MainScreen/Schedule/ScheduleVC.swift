
//
//  ScheduleVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Localize_Swift
import SideMenu

class ScheduleVC: BaseVC, UISideMenuNavigationControllerDelegate {
    
    var layout: ScheduleLayout!
    var sideMenuVC: SideMenuVC!
    
    static func buildVC() -> ScheduleVC {
        return ScheduleVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout = ScheduleLayout(superview: self.view, scheduleLayoutDelegate: self)
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
        sideMenuVC = UiHelpers.setupSideMenu(delegate: self, viewToPresent: self.layout.topView.backImageView, viewToEdge: self.view, sideMenuCellDelegate: self, sideMenuHeaderDelegate: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension ScheduleVC: SideMenuHeaderDelegate {
    func headerClicked() {
        print("schedule :: header clicked")
    }
}

extension ScheduleVC: SideMenuCellDelegate {
    func sideMenuItemSelected(index: Int) {
        sideMenuVC.closeSideMenu()
        self.navigator = Navigator(navController: self.navigationController!)
        switch index {
        case 0:
            
            break
            
        case 1:
            self.navigator.navigateToVideos()
            break
            
        case 2:
            self.navigator.navigateToGameMethodology()
            break
            
        case 3:
            self.navigator.navigateToTerms()
            break
            
        case 4:
            self.navigator.navigateToSettings()
            break
            
        default:
            break
        }
        print("schedule :: item \(index) clicked")
    }
}

extension ScheduleVC: ScheduleLayoutDelegate {
    func retry() {
        
    }
    
    func openSideMenu() {
        if Localize.currentLanguage() == "en" {
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        } else {
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
        
    }
    
    func goToNotificationsScreen() {
        self.navigator = Navigator(navController: self.navigationController!)
        self.navigator.navigateToNotifications()
    }
}
