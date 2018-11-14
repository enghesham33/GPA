//
//  DashboardCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Material

public protocol DashboardCellDelegate {
    func refreshTableViewHeight(selection: Int)
}

class DashboardCell: UITableViewCell {

    static let identifier = "DashboardCell"
    var superView: UIView!
    public static var cellHeight: CGFloat!
    var selection: Int = 0
    var delegate: DashboardCellDelegate!
    
    var user: User!
    var userInfo: UserInfo!
    var myTeamMembers: [TeamMember]!
    var allMembers: [TeamMember]!
    var allTeams: [Team]!
    
    lazy var mainImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dashboard_bg")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.AppColors.primaryColor
        return imageView
    }()
    
    lazy var rankingImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 20)/2
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var rankingTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    lazy var rankingValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 24)
        return label
    }()
    
    lazy var pointsImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15)/2
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var pointsAccessoryImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "prize")
        return imageView
    }()
    
    lazy var pointsTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Regular, size: 12)
        return label
    }()
    
    lazy var pointsValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var badgesImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15)/2
        return imageView
    }()
    
    lazy var badgesAccessoryImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "prize")
        return imageView
    }()
    
    lazy var badgesTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Regular, size: 12)
        return label
    }()
    
    lazy var badgesValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var myProfileButton: RaisedButton = {
        let button = RaisedButton(title: "myPage".localized(), titleColor: .white)
        button.backgroundColor = UIColor.AppColors.green
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 14)
        
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 0.5)
        button.addTapGesture { recognizer in
            
        }
        return button
    }()
    
    lazy var badge1Imageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var badge2Imageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var allBadgesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "allBadges".localized(), attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 16)
        label.addTapGesture(action: { (_) in
            
        })
        return label
    }()
    
    lazy var teamMembersButton: RaisedButton = {
        let button = RaisedButton(title: "team".localized(), titleColor: .black)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 14)
        
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 0.5)
        button.addTapGesture { recognizer in
            self.teamMembersLine.isHidden = false
            self.allMembersLine.isHidden = true
            self.allTeamsLine.isHidden = true
            self.selection = 0
            self.delegate.refreshTableViewHeight(selection: 0)
        }
        return button
    }()
    
    lazy var teamMembersLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.darkRed
        view.isHidden = false
        return view
    }()
    
    lazy var allMembersButton: RaisedButton = {
        let button = RaisedButton(title: "allMembers".localized(), titleColor: .black)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 14)
        
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.isUserInteractionEnabled = true
        button.addTapGesture { recognizer in
            self.teamMembersLine.isHidden = true
            self.allMembersLine.isHidden = false
            self.allTeamsLine.isHidden = true
             self.selection = 1
            self.delegate.refreshTableViewHeight(selection: 1)
        }
        return button
    }()
    
    lazy var allMembersLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.darkRed
        view.isHidden = true
        return view
    }()
    
    lazy var allTeamsButton: RaisedButton = {
        let button = RaisedButton(title: "teams".localized(), titleColor: .black)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 14)
        
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.isUserInteractionEnabled = true
        button.addTapGesture { recognizer in
            self.teamMembersLine.isHidden = true
            self.allMembersLine.isHidden = true
            self.allTeamsLine.isHidden = false
             self.selection = 2
            self.delegate.refreshTableViewHeight(selection: 2)
        }
        return button
    }()
    
    lazy var allTeamsLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.darkRed
        view.isHidden = true
        return view
    }()
    
    lazy var membersTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(MemberCell.self, forCellReuseIdentifier: MemberCell.identifier)
        return tableView
    }()
    
    public func setupViews() {
        
        let views = [mainImageview, rankingImageview, rankingTitleLabel, rankingValueLabel, pointsImageview, pointsTitleLabel, pointsValueLabel, pointsAccessoryImageview, badgesImageview, badgesTitleLabel, badgesValueLabel, badgesAccessoryImageview, userNameLabel, myProfileButton, badge1Imageview, badge2Imageview, allBadgesLabel, teamMembersButton, teamMembersLine, allMembersButton, allMembersLine, allTeamsButton, allTeamsLine, membersTableView]
        
        self.superView = self.contentView
        
        superView.addSubviews(views)
        
        mainImageview.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.equalTo(superView)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 70))
        }
        
        teamMembersButton.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView)
            maker.top.equalTo(mainImageview.snp.bottom)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 33))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
        
        teamMembersLine.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalTo(teamMembersButton)
            maker.height.equalTo(2)
        }
        
        allMembersButton.snp.makeConstraints { (maker) in
            maker.leading.equalTo(teamMembersButton.snp.trailing)
            maker.top.equalTo(mainImageview.snp.bottom)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 33))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
        
        allMembersLine.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalTo(allMembersButton)
            maker.height.equalTo(2)
        }
        
        allTeamsButton.snp.makeConstraints { (maker) in
            maker.leading.equalTo(allMembersButton.snp.trailing)
            maker.trailing.equalTo(superView)
            maker.top.equalTo(mainImageview.snp.bottom)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
        
        allTeamsLine.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalTo(allTeamsButton)
            maker.height.equalTo(2)
        }
        
        membersTableView.dataSource = self
        membersTableView.delegate = self
    }
    
    public func populateData() {
        
    }
    
}

extension DashboardCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
