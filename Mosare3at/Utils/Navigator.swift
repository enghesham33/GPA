//
//  Navigator.swift
//  Mosare3at
//
//  Created by Hesham Donia on 9/30/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public class Navigator {
    
    var navigationController: UINavigationController!
    
    public init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    public func navigateToLogin() {
        let vc = LoginVC.buildVC()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func navigateToForgetPassword() {
        let vc = ForgetPasswordVC.buildVC()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func navigateToTutorial() {
        let vc = TutorialPagerVC.buildVC()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func navigateToChooseAvatar() {
        let vc = ChooseAvatarVC.buildVC()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}
