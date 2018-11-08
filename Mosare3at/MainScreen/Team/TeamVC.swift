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
    
    static func buildVC() -> TeamVC {
        return TeamVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout = TeamLayout(superview: self.view, teamLayoutDelegate: self)
        layout.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UiHelpers.setupSideMenu(delegate: self, viewToPresent: self.layout.topView.backImageView, viewToEdge: self.view, sideMenuCellDelegate: self, sideMenuHeaderDelegate: self)
    }
    
}

extension TeamVC: SideMenuHeaderDelegate {
    func headerClicked() {
         print("team :: header clicked")
    }
}

extension TeamVC: SideMenuCellDelegate {
    func sideMenuItemSelected(index: Int) {
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
