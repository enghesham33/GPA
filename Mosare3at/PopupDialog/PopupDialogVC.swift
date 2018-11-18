//
//  PopupDialogVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/18/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

class PopupDialogVC: BaseVC {

    var badge: Badge!
    
    var layout: PopupDialogLayout!
    
    var presenter: VideosPresenter!
    
    public static func buildVC() -> PopupDialogVC {
        let vc = PopupDialogVC()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = PopupDialogLayout(superview: self.view, delegate: self)
        layout.setupViews()
        layout.badge = badge
        layout.populateData()
        
        presenter = Injector.provideVideosPresenter()
    }
}

extension PopupDialogVC: PopupDialogLayoutDelegate {
    func close() {
        dismiss(animated: true, completion: nil)
    }
    
    func share() {
        UiHelpers.share(textToShare: "youGot".localized() + " " + badge.name, sourceView: self.view, vc: self)
        presenter.updateUserPoints(points: 5)
    }
    
    func retry() {
        
    }
}
