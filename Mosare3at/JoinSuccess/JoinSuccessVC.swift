//
//  JoinSuccessVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/9/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class JoinSuccessVC: BaseVC {

    var layout: JoinSuccessLayout!
    
    static func buildVC() -> JoinSuccessVC {
        return JoinSuccessVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = JoinSuccessLayout(superview: self.view, joinSuccessDelegate: self)
        layout.setupViews()
        
        showUserData()
    }
    
    func showUserData() {
        let user = User.getInstance(dictionary: Defaults[.user]!)
        self.layout.usernameLabel.text = "\(user.firstName!) \(user.lastName!)"
        self.layout.avatarImageview.af_setImage(withURL: URL(string: "\(CommonConstants.BASE_URL)media/download/\(user.profilePic!)")!, placeholderImage: UIImage(named: "placeholder"))
    }
}

extension JoinSuccessVC : JoinSuccessDelegate {
    func goToProgram() {
        navigator.navigateToMainScreen()
    }
    
    func retry() {
        
    }
    
    func share() {
        UiHelpers.share(textToShare: "badgeCongrat".localized(), sourceView: self.view, vc: self)
    }
}
