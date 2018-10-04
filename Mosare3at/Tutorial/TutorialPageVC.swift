//
//  File.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/4/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

class TutorialPageVC : BaseVC {
    
    var layout : TutorialLayout!
    var index: Int!
    var message: String!
    var pageTitle: String!
    
    // to return object of TutorialPageVC
    static func buildVC() -> TutorialPageVC {
        return TutorialPageVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = TutorialLayout(superview: view, tutorialDelegate: self)
        layout.setupViews(index: index, title: pageTitle, message: message)
    }
    
}

extension TutorialPageVC: TutorialDelegate {
    func goToChooseAvatar() {
        // go to choose avatar
    }
    
    func retry() {
        
    }
    
    
}
