//
//  SettingsVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

class SettingsVC: BaseVC {

    var layout: SettingsLayout!
    
    public static func buildVC() -> SettingsVC {
        let vc = SettingsVC()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = SettingsLayout(superview: self.view, delegate: self)
        layout.setupViews()
    }

}

extension SettingsVC: SettingsLayoutDelegate {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func goToNotificationsSettings() {
       self.navigator.navigateToNotificationsSettings()
    }
    
    func changeFontSize() {
        print("changeFontSize")
    }
    
    
}
