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
    func openMyProfile()
    func openBadgeDialog(badge: Badge)
    func openAllBadges()
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
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var rankingImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.addBorder(width: 2, color: UIColor.AppColors.yellow)
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 20)/2
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var rankingTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "rank".localized()
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    lazy var rankingValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 30)
        return label
    }()
    
    lazy var pointsImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 12)/2
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
        label.text = "point".localized()
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
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 12)/2
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
        label.text = "badges".localized()
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
        label.font = AppFont.font(type: .Regular, size: 18)
        return label
    }()
    
    lazy var myProfileButton: RaisedButton = {
        let button = RaisedButton(title: "myPage".localized(), titleColor: .white)
        button.backgroundColor = UIColor.AppColors.green
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 14)
        
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 0.5)
        button.addTapGesture { recognizer in
            print("my profile button clicked")
            self.delegate.openMyProfile()
        }
        return button
    }()
    
    lazy var badge1Imageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (_) in
            self.delegate.openBadgeDialog(badge: self.userInfo.badges.get(at: 0)!)
        })
        return imageView
    }()
    
    lazy var badge2Imageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (_) in
            self.delegate.openBadgeDialog(badge: self.userInfo.badges.get(at: 1)!)
        })
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
            print("allBadgesLabel clicked")
            self.delegate.openAllBadges()
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
            self.membersTableView.reloadData()
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
            self.membersTableView.reloadData()
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
            self.membersTableView.reloadData()
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
        tableView.separatorStyle = .singleLine
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
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 60))
        }
        
        rankingImageview.snp.makeConstraints { (maker) in
            maker.top.equalTo(mainImageview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 20))
            maker.centerX.equalTo(mainImageview)
        }
        
        rankingValueLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(rankingImageview.snp.centerY)
            maker.centerX.equalTo(rankingImageview)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10))
            maker.leading.trailing.equalTo(rankingImageview)
            
        }
        
        rankingTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(rankingImageview)
            maker.top.equalTo(rankingValueLabel.snp.bottom)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        pointsImageview.snp.makeConstraints { (maker) in
            maker.top.equalTo(mainImageview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15))
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 12))
            maker.trailing.equalTo(rankingImageview.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2) * -1)
        }
        
        pointsValueLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(pointsImageview.snp.centerY)
            maker.centerX.equalTo(pointsImageview)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.leading.trailing.equalTo(pointsImageview)
            
        }
        
        pointsTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(pointsImageview)
            maker.top.equalTo(pointsValueLabel.snp.bottom)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        pointsAccessoryImageview.snp.makeConstraints { (maker) in
            maker.top.equalTo(pointsTitleLabel.snp.bottom)
            maker.centerX.equalTo(pointsImageview)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 6))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
        
        badgesImageview.snp.makeConstraints { (maker) in
            maker.top.equalTo(mainImageview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15))
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 12))
            maker.leading.equalTo(rankingImageview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
        }
        
        badgesValueLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(badgesImageview.snp.centerY)
            maker.centerX.equalTo(badgesImageview)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.leading.trailing.equalTo(badgesImageview)
        }
        
        badgesTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(badgesImageview)
            maker.top.equalTo(badgesValueLabel.snp.bottom)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        badgesAccessoryImageview.snp.makeConstraints { (maker) in
            maker.top.equalTo(badgesTitleLabel.snp.bottom)
            maker.centerX.equalTo(badgesImageview)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 6))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
        
        userNameLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(pointsImageview.snp.trailing)
            maker.trailing.equalTo(badgesImageview.snp.leading)
            maker.top.equalTo(rankingImageview.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        myProfileButton.snp.makeConstraints { (maker) in
            maker.leading.equalTo(pointsImageview.snp.trailing)
            maker.trailing.equalTo(badgesImageview.snp.leading)
            maker.top.equalTo(userNameLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        teamMembersButton.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView)
            maker.top.equalTo(mainImageview.snp.bottom)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 33))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
        
        allBadgesLabel.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(mainImageview)
            maker.width.equalTo((allBadgesLabel.text?.widthOfString(usingFont: allBadgesLabel.font))!)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.top.equalTo(myProfileButton.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
        
        badge1Imageview.snp.makeConstraints { (maker) in
            maker.leading.equalTo(mainImageview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 25))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15))
            maker.top.equalTo(myProfileButton.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
        }
        
        badge2Imageview.snp.makeConstraints { (maker) in
            maker.leading.equalTo(badge1Imageview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 25))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15))
            maker.top.equalTo(myProfileButton.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
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
        
        membersTableView.snp.remakeConstraints { (maker) in
            maker.leading.trailing.equalTo(superView)
            maker.top.equalTo(allTeamsButton.snp.bottom)
//            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 50))
            switch self.selection {
            case 0:
                maker.height.equalTo(CGFloat(myTeamMembers.count) * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 12))
                break

            case 1:
                maker.height.equalTo(CGFloat(allMembers.count) * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 12))
                break

            case 2:
                maker.height.equalTo(CGFloat(allTeams.count) * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 12))
                break

            default:
                break
            }
            
        }
        membersTableView.dataSource = self
        membersTableView.delegate = self
    }
    
    public func populateData() {
        var count = 0
        for member in allMembers {
            if member.member.id == user.id {
                break
            }
            count = count + 1
        }
       
        switch count {
        case 0:
            rankingValueLabel.text = "1st"
            break
            
        case 1:
            rankingValueLabel.text = "2nd"
            break
            
        case 2:
            rankingValueLabel.text = "3rd"
            break
            
        default:
            rankingValueLabel.text = "\(count + 1)th"
            break
        }
        
        pointsValueLabel.text = "\(user.totalPoints!)"
        
        badgesValueLabel.text = "\(user.totalBadges!)"
        
        userNameLabel.text = user.firstName + " " + user.lastName
        
        if userInfo.badges != nil {
            if userInfo.badges.count == 0 {
                badge1Imageview.isHidden = true
                badge2Imageview.isHidden = true
            } else if userInfo.badges.count == 1 {
                badge1Imageview.isHidden = false
                badge1Imageview.af_setImage(withURL: URL(string: (userInfo.badges.get(at: 0)?.image)!)!)
                badge2Imageview.isHidden = true
            } else {
                badge1Imageview.isHidden = false
                badge2Imageview.isHidden = false
                badge1Imageview.af_setImage(withURL: URL(string: (CommonConstants.IMAGES_BASE_URL + (userInfo.badges.get(at: 0)?.image)!))!)
                badge2Imageview.af_setImage(withURL: URL(string: (CommonConstants.IMAGES_BASE_URL + (userInfo.badges.get(at: 1)?.image)!))!)
            }
        }
        
        membersTableView.reloadData()
        
    }
    
}

extension DashboardCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch selection {
        case 0:
            return myTeamMembers.count
            
        case 1:
            return allMembers.count
            
        case 2:
            return allTeams.count
            
        default:
            return 0
        }        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MemberCell = self.membersTableView.dequeueReusableCell(withIdentifier: MemberCell.identifier, for: indexPath) as! MemberCell
        
        cell.selectionStyle = .none
        
        cell.user = user
        cell.index = indexPath.row
        if selection == 0 {
            cell.member = myTeamMembers.get(at: indexPath.row)!
        } else if selection == 1 {
            cell.member = allMembers.get(at: indexPath.row)!
        } else if selection == 2 {
            cell.member = nil
            cell.team = allTeams.get(at: indexPath.row)!
            cell.myTeamPoints = getMyTeamPoints()
        }
        cell.setupViews()
        cell.populateData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 12)
    }
    
    func getMyTeamPoints() -> Int {
        for team in allTeams {
            for member in team.teamMembers {
                if member.member.id == user.id {
                    return team.points
                }
            }
        }
        
        return 0
    }
}
