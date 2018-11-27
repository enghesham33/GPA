//
//  MyProfileVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/18/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class MyProfileVC: BaseVC {

    var layout: MyProfileLayout!
    var user: User!
    var userInfo: UserInfo!
    var registeredPrograms: [RegisteredProgram]!
    
    var presenter: MyProfilePresenter!
    
    public static func buildVC() -> MyProfileVC {
        let vc = MyProfileVC()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = MyProfileLayout(superview: self.view, delegate: self)
        layout.setupViews()
        
        user = User.getInstance(dictionary: Defaults[.user]!)
        
        presenter = Injector.provideMyProfilePresenter()
        presenter.setView(view: self)
        
        presenter.getUserInfo()
    }
}

extension MyProfileVC: MyProfileView {
    func getProgramsProgressSuccess(programs: [RegisteredProgram]) {
        self.registeredPrograms = programs
        layout.myProfileTableView.dataSource = self
        layout.myProfileTableView.delegate = self
        layout.myProfileTableView.reloadData()
    }
    
    func opetaionFailed(message: String) {
        self.view.makeToast(message)
    }
    
    func getUserInfoSuccess(userInfo: UserInfo) {
        self.userInfo = userInfo
        presenter.getProgramsProgress()
    }
}

extension MyProfileVC: MyProfileLayoutDelegate {
    func goBack() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func retry() {
        
    }
    
    
}

extension MyProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyProfileCell = layout.myProfileTableView.dequeueReusableCell(withIdentifier: MyProfileCell.identifier, for: indexPath) as! MyProfileCell
        cell.selectionStyle = .none
        cell.user = user
        cell.userInfo = userInfo
        cell.programsCount = (registeredPrograms.get(at: 0)?.projects.count)!
        cell.delegate = self
        cell.setupViews()
        cell.populateData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 125)
    }
}

extension MyProfileVC: MyProfileCellDelegate {
    func navigateToVideos() {
        self.navigator.navigateToVideos(isFromProfile: true)
    }
    
    func close() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func logout() {
        AppDelegate.logout()
        AppDelegate.instance.startApplication()
    }
    
    func navigateToRegisteredPrograms() {
        self.navigator.navigateToRegisteredPrograms(programs: registeredPrograms)
    }
    
    func navigateToAllBadges() {
        presentVC(AllBadgesVC.buildVC(badges: userInfo.badges))
    }
}


