//
//  TeamVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Localize_Swift
import SideMenu

class TeamVC: BaseVC, UISideMenuNavigationControllerDelegate {
    
    var layout: TeamLayout!
    var sideMenuVC: SideMenuVC!
    static func buildVC() -> TeamVC {
        return TeamVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout = TeamLayout(superview: self.view, teamLayoutDelegate: self)
        layout.setupViews()
        if AppDelegate.instance.unreadNotificationsNumber > 0 {
            self.layout.topView.notificationsNumberLabel.isHidden = false
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

extension TeamVC: SideMenuHeaderDelegate {
    func headerClicked() {
        sideMenuVC.closeSideMenu()
        self.navigator = Navigator(navController: self.navigationController!)
        self.navigator.navigateToMyProfile()
    }
}

extension TeamVC: SideMenuCellDelegate {
    func sideMenuItemSelected(index: Int) {
        sideMenuVC.closeSideMenu()
        self.navigator = Navigator(navController: self.navigationController!)
        switch index {
        case 0:
            self.navigator.navigateToMyProfile()
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
         print("team :: item \(index) clicked")
    }
}

extension TeamVC : TeamLayoutDelegate {
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
