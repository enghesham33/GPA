//
//  SideMenuVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults



class SideMenuVC : BaseVC {
    
    var layout: SideMenuLayout!
    var sideMenuCellDelegate: SideMenuCellDelegate!
    var sideMenuHeaderDelegate: SideMenuHeaderDelegate!
    
    var menuStringsDataSource: [String] = ["myPage".localized(), "movies".localized(), "gameWay".localized(), "termsAndConditions".localized(), "settings".localized()]
    
    var menuImagesDataSource: [UIImage] = [UIImage(named: "profile")!, UIImage(named: "video_side_menu")!, UIImage(named: "profile")!, UIImage(named: "profile")!, UIImage(named: "settings")!]
    
    
    static func buildVC() -> SideMenuVC {
        return SideMenuVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = SideMenuLayout(superview: self.view, sideMenuLayoutDelegate: self)
        layout.setupViews()
        layout.sideMenuHeaderDelegate = self.sideMenuHeaderDelegate
        
        setupMenuTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: NSNotification.Name(rawValue: CommonConstants.SIDE_MENU_PROGRESS_UPDATED), object: nil)
        
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
        showUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showUserData()
    }
    
    func setupMenuTableView() {
        layout.menuTableView.dataSource = self
        layout.menuTableView.delegate = self
        
        layout.menuTableView.reloadData()
    }
    
    func showUserData() {
        let user = User.getInstance(dictionary: Defaults[.user]!)
        layout.usernameLabel.text = "\(user.firstName!) \(user.lastName!)"
        layout.mainUserProfilePicImageView.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(user.profilePic!)")!, placeholderImage: UIImage(named: "placeholder"))
        layout.userProfilePicImageView.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(user.profilePic!)")!, placeholderImage: UIImage(named: "placeholder"))
        if Singleton.getInstance().sideMenuDoneTasksCount != nil && Singleton.getInstance().sideMenuDoneTasksCount > 0 && Singleton.getInstance().sideMenuTotalTasksCount != nil && Singleton.getInstance().sideMenuTotalTasksCount > 0 {
            layout.outputsLabel.text = "\(Int(Float(Singleton.getInstance().sideMenuDoneTasksCount) / Float(Singleton.getInstance().sideMenuTotalTasksCount) * 100))% \("outputs".localized())"
        }
    }
}

extension SideMenuVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuStringsDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SideMenuCell()
        cell.selectionStyle = .none
        cell.delegate = self.sideMenuCellDelegate
        cell.index = indexPath.row
        cell.populateMenuItemData(data: self.menuStringsDataSource.get(at: indexPath.row)!, image: self.menuImagesDataSource.get(at: indexPath.row)!)
        return cell
        
    }
}

extension SideMenuVC: SideMenuLayoutDelegate {
    func retry() {
        
    }
    
    func closeSideMenu() {
        dismiss(animated: true, completion: nil)
    }
}
