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
        
        UiHelpers.setupSideMenu(delegate: self, viewToPresent: self.layout.topView.backImageView, viewToEdge: self.view, sideMenuCellDelegate: self, sideMenuHeaderDelegate: self)
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
