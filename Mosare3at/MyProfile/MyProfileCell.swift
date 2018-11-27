//
//  MyProfileCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/18/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Material

public protocol MyProfileCellDelegate: class {
    func close()
    func logout()
    func navigateToRegisteredPrograms()
    func navigateToAllBadges()
    func navigateToVideos()
}

class MyProfileCell: UITableViewCell {

    public static let identifier = "MyProfileCell"
    var superView: UIView!
    var delegate: MyProfileCellDelegate!
    
    var user: User!
    var userInfo: UserInfo!
    var programsCount: Int = 0
    
    lazy var menuHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var closeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "close")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
            self.delegate.close()
        })
        return imageView
    }()
    
    lazy var outputsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "المخرجات"
        label.lineBreakMode = .byWordWrapping
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var userProfilePicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var teamPicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var userTeamNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    lazy var mainUserProfilePicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var curveImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "curve")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var myProfileView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        return view
    }()
    
    lazy var myProfileTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = true
        tableView.register(MyProfileDetailsCell.self, forCellReuseIdentifier: MyProfileDetailsCell.identifier)
        return tableView
    }()
    
    lazy var logoutButton: RaisedButton = {
        let button = RaisedButton(title: "logout".localized(), titleColor: .white)
        button.backgroundColor = UIColor.AppColors.darkRed
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 18)
        
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 1)
        button.addTapGesture { recognizer in
            self.delegate.logout()
        }
        return button
    }()
    
    public func setupViews() {
        let views = [menuHeaderView, mainUserProfilePicImageView, closeImageView, userProfilePicImageView, myProfileView, myProfileTableView, logoutButton, curveImageView, teamPicImageView, userTeamNameLabel, outputsLabel]
        
        superView = self.contentView
        
        self.superView.addSubviews(views)
        
        self.menuHeaderView.addSubviews([closeImageView, outputsLabel, userProfilePicImageView, usernameLabel, mainUserProfilePicImageView, curveImageView, teamPicImageView, userTeamNameLabel])
        
        self.menuHeaderView.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.equalTo(superView)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 70))
        }
        
        self.mainUserProfilePicImageView.snp.makeConstraints { maker in
            maker.leading.trailing.top.equalTo(self.menuHeaderView)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 65))
        }
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = mainUserProfilePicImageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainUserProfilePicImageView.addSubview(blurEffectView)
        
        menuHeaderView.bringSubviewToFront(closeImageView)
        menuHeaderView.bringSubviewToFront(userProfilePicImageView)
        menuHeaderView.bringSubviewToFront(outputsLabel)
        menuHeaderView.bringSubviewToFront(usernameLabel)
        menuHeaderView.bringSubviewToFront(curveImageView)
        
        
        self.closeImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(self.menuHeaderView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(self.menuHeaderView.snp.top).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        self.userProfilePicImageView.snp.makeConstraints { maker in
            maker.centerX.equalTo(self.menuHeaderView)
            maker.top.equalTo(menuHeaderView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 23))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 23))
        }
        
        self.outputsLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(self.menuHeaderView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
            maker.trailing.equalTo(self.userProfilePicImageView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
            maker.top.equalTo(menuHeaderView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 23))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10))
        }
        
        self.usernameLabel.snp.makeConstraints { maker in
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
            maker.leading.trailing.equalTo(self.menuHeaderView)
            maker.top.equalTo(self.userProfilePicImageView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
        }
        
        teamPicImageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(usernameLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 42))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        userTeamNameLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(usernameLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(teamPicImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 70))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        self.curveImageView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalTo(self.menuHeaderView)
            maker.top.equalTo(userTeamNameLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
        }
        
        myProfileView.snp.remakeConstraints { (maker) in
            maker.top.equalTo(curveImageView.snp.bottom)
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7) * CGFloat(5) + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        myProfileView.addSubview(myProfileTableView)
        myProfileTableView.snp.remakeConstraints { (maker) in
            maker.top.equalTo(myProfileView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(myProfileView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(myProfileView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7) * CGFloat(5))
        }
        
        logoutButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(myProfileView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
        }
    }
    
    public func populateData() {
        
        myProfileTableView.dataSource = self
        myProfileTableView.delegate = self
        myProfileTableView.reloadData()
        
        self.usernameLabel.text = "\(user.firstName!) \(user.lastName!)"
        self.mainUserProfilePicImageView.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(user.profilePic!)")!, placeholderImage: UIImage(named: "placeholder"))
        self.userProfilePicImageView.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(user.profilePic!)")!, placeholderImage: UIImage(named: "placeholder"))
        if Singleton.getInstance().sideMenuDoneTasksCount != nil && Singleton.getInstance().sideMenuDoneTasksCount > 0 && Singleton.getInstance().sideMenuTotalTasksCount != nil && Singleton.getInstance().sideMenuTotalTasksCount > 0 {
            self.outputsLabel.text = "\(Int(Float(Singleton.getInstance().sideMenuDoneTasksCount) / Float(Singleton.getInstance().sideMenuTotalTasksCount) * 100))% \("outputs".localized())"
        }
        
        self.userTeamNameLabel.text = userInfo.currentTeamName
        if userInfo.currentTeamImage != nil {
            self.teamPicImageView.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(userInfo.currentTeamImage!)")!, placeholderImage: UIImage(named: "placeholder"))
        } else {
            self.teamPicImageView.image = UIImage(named: "team")?.withRenderingMode(.alwaysTemplate)
            self.teamPicImageView.tintColor = .white
        }
        
    }
}

extension MyProfileCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyProfileDetailsCell = myProfileTableView.dequeueReusableCell(withIdentifier: MyProfileDetailsCell.identifier, for: indexPath) as! MyProfileDetailsCell
        cell.selectionStyle = .none
        cell.setupViews()
        cell.index = indexPath.row
        cell.delegate = self
        switch indexPath.row {
        case 0:
            cell.populateData(title: "registeredProjects".localized(), count: "\(programsCount)")
            break
            
        case 1:
            cell.populateData(title: "videos".localized(), count: "\(userInfo!.videos!)")
            break
            
        case 2:
            cell.populateData(title: "badges".localized(), count: "\(userInfo!.badges.count)")
            break
            
        case 3:
            if userInfo.achievements != nil {
                cell.populateData(title: "acheivements".localized(), count: "\(userInfo!.achievements.count)")
            } else {
                cell.populateData(title: "acheivements".localized(), count: "0")
            }
            break
            
        case 4:
            cell.populateData(title: "personalData".localized(), count: "")
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7)
    }
}

extension MyProfileCell : MyProfileDetailsCellDelegate {
    func navigate(index: Int) {
        switch index {
        case 0:
            self.delegate.navigateToRegisteredPrograms()
            break
            
        case 1:
            self.delegate.navigateToVideos()
            break
            
        case 2:
            self.delegate.navigateToAllBadges()
            break
            
        case 3:
            
            break
            
        case 4:
            
            break
        default:
            break
        }
        
    }
}
