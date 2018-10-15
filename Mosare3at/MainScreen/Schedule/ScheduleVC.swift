
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
    
    static func buildVC() -> ScheduleVC {
        return ScheduleVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout = ScheduleLayout(superview: self.view, scheduleLayoutDelegate: self)
        layout.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UiHelpers.setupSideMenu(delegate: self, viewToPresent: self.layout.topView.backImageView, viewToEdge: self.view, sideMenuCellDelegate: self, sideMenuHeaderDelegate: self)
    }
    
}

extension ScheduleVC: SideMenuHeaderDelegate {
    func headerClicked() {
        print("schedule :: header clicked")
    }
}

extension ScheduleVC: SideMenuCellDelegate {
    func sideMenuItemSelected(index: Int) {
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
}
