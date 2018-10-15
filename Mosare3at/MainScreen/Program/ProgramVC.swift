//
//  ProgramVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SideMenu
import Localize_Swift

class ProgramVC: BaseVC, UISideMenuNavigationControllerDelegate {
    
    var layout: ProgramLayout!
    
    static func buildVC() -> ProgramVC {
        return ProgramVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = ProgramLayout(superview: self.view, programLayoutDelegate: self)
        layout.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UiHelpers.setupSideMenu(delegate: self, viewToPresent: self.layout.topView.backImageView, viewToEdge: self.view, sideMenuCellDelegate: self, sideMenuHeaderDelegate: self)
    }
}

extension ProgramVC: SideMenuHeaderDelegate {
    func headerClicked() {
        print("program :: header clicked")
    }
}

extension ProgramVC: SideMenuCellDelegate {
    func sideMenuItemSelected(index: Int) {
        print("program :: item \(index) clicked")
    }
}

extension ProgramVC : ProgramLayoutDelegate {
    func openSideMenu() {
        if Localize.currentLanguage() == "en" {
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        } else {
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
        
    }
    
    func retry() {
        
    }
}
