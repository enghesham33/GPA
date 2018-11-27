//
//  MemberCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

public protocol MemberCellDelegate: class {
    func goToMyProfile()
    func goToMyTeam(index: Int)
    func goToMemberDetails(index: Int, isTeamMate: Bool)
    func goToTeamDetails(index: Int)
}

class MemberCell: UITableViewCell {

    static let identifier = "MemberCell"
    var superView: UIView!
    
    var member: TeamMember!
    var team: Team!
    var user: User!
    var index: Int!
    var myTeamPoints: Int!
    var isMe: Bool = false
    var isMyTeam: Bool = false
    var tabIndex: Int!
    var delegate:MemberCellDelegate!
    
    lazy var indexImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var indexLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.isHidden = true
        label.font = AppFont.font(type: .Regular, size: 18)
        return label
    }()
    
    lazy var userProfileImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10)/2
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "rank".localized()
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    lazy var userPointsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "rank".localized()
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    lazy var userBadgesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "rank".localized()
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "left_arrow")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    public func setupViews() {
        let views = [indexLabel, indexImageview, userProfileImageview, userNameLabel, userPointsLabel, userBadgesLabel, arrowImageView]
        
        self.superView = self.contentView
        
        self.superView.addSubviews(views)
        
        self.indexImageview.snp.remakeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.centerY.equalTo(superView)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        self.indexLabel.snp.remakeConstraints { (maker) in
            maker.edges.equalTo(indexImageview)
        }
        
        self.userProfileImageview.snp.remakeConstraints { (maker) in
            maker.leading.equalTo(indexImageview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.centerY.equalTo(superView)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10))
        }
        
        self.userNameLabel.snp.remakeConstraints { (maker) in
            maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.leading.equalTo(userProfileImageview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            var name = ""
            if member != nil {
                name = member.member.firstname + " " + member.member.lastname
            } else {
                name = team.name
            }
            
            maker.width.equalTo(name.widthOfString(usingFont: userNameLabel.font))
        }
        
        self.userPointsLabel.snp.remakeConstraints { (maker) in
            maker.top.equalTo(userNameLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(userProfileImageview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.width.equalTo(getUserPointsWidth())
        }
        
        self.arrowImageView.snp.remakeConstraints { (maker) in
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.centerY.equalTo(superView)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        self.userBadgesLabel.snp.remakeConstraints { (maker) in
            maker.trailing.equalTo(arrowImageView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.top.equalTo(userPointsLabel)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            if member != nil {
                maker.width.equalTo("\(member.badgesCount!) \("badges".localized())".widthOfString(usingFont: userBadgesLabel.font))
            } else {
                maker.width.equalTo("\(team.badges!) \("badges".localized())".widthOfString(usingFont: userBadgesLabel.font))
            }
        }
    }
    
    public func populateData() {
        
        switch index {
        case 0:
            indexImageview.isHidden = false
            indexLabel.isHidden = true
            indexImageview.image = UIImage(named: "first")
            break
            
        case 1:
            indexImageview.isHidden = false
            indexLabel.isHidden = true
            indexImageview.image = UIImage(named: "second")
            break
            
        case 2:
            indexImageview.isHidden = false
            indexLabel.isHidden = true
            indexImageview.image = UIImage(named: "third")
            break
            
        default:
            indexImageview.isHidden = true
            indexLabel.isHidden = false
            indexLabel.text = "\(index + 1)"
            break
        }
        
        self.userProfileImageview.image = nil
        
        if member != nil {
            
            self.userProfileImageview.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(member.member.profilePic!)")!, placeholderImage: UIImage(named: "no_pp")!)
            userNameLabel.text = member.member.firstname + " " + member.member.lastname
            userBadgesLabel.text = "\(member.badgesCount!) \("badges".localized())"
            
        } else {
            userProfileImageview.isHidden = true
            self.userNameLabel.snp.remakeConstraints { (maker) in
                maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
                maker.leading.equalTo(indexImageview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
                maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
                var name = ""
                if member != nil {
                    name = member.member.firstname + " " + member.member.lastname
                } else {
                    name = team.name
                }
                maker.width.equalTo(name.widthOfString(usingFont: userNameLabel.font))
            }
            
            self.userPointsLabel.snp.makeConstraints { (maker) in
                maker.top.equalTo(userNameLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
                maker.leading.equalTo(indexImageview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
                maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
                maker.width.equalTo(getUserPointsWidth())
            }
            
            userNameLabel.text = team.name
            userBadgesLabel.text = "\(team.badges!) \("badges".localized())"
        }
        
        self.superView.addTapGesture { (_) in
            if self.tabIndex == 0 || self.tabIndex == 1 { // my team or all members
                if self.isMe {
                    // go to my profile
                    self.delegate.goToMyProfile()
                } else {
                    // go to member details
                    self.delegate.goToMemberDetails(index: self.index, isTeamMate: self.tabIndex == 0)
                }
            } else if self.tabIndex == 2 { // all teams
                if self.isMyTeam {
                    // go to my team
                    self.delegate.goToMyTeam(index: self.index)
                } else {
                    // go to team details
                    self.delegate.goToTeamDetails(index: self.index)
                }
                
            }
        }
    }
    
    func getUserPointsWidth() -> CGFloat {
        var points = 0//member.points
        var diffPoints = 0//member.points - user.totalPoints
        if member != nil {
            
            isMyTeam = false
            
            points = member.points
            diffPoints = member.points - user.totalPoints
            if member.member.id == user.id {
                isMe = true
                userPointsLabel.text = "\(points) \("point".localized())"
                self.superView.backgroundColor = UIColor.AppColors.lightGray
                return "\(points) \("point".localized())".widthOfString(usingFont: userPointsLabel.font)
            } else {
                self.superView.backgroundColor = .white
                var finalString = ""
                var stringToBeColored = ""
                var colorOfString = UIColor()
                if diffPoints > 0 {
                    stringToBeColored = "\(diffPoints)+"
                    colorOfString = UIColor.AppColors.green
                } else if diffPoints < 0 {
                    stringToBeColored = "\(diffPoints * -1)-"
                    colorOfString = UIColor.AppColors.red
                } else {
                    stringToBeColored = "0"
                    colorOfString = UIColor.AppColors.red
                }
                
                finalString = "\(points) \("point".localized()) (\(stringToBeColored))"
                let attributedString = NSMutableAttributedString(string:finalString)
                let range = (finalString as NSString).range(of: stringToBeColored)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colorOfString , range: range)
                userPointsLabel.attributedText = attributedString
                
                return finalString.widthOfString(usingFont: userPointsLabel.font)
            }
        } else {
            isMe = false
            for member1 in team.teamMembers {
                if member1.member.id == user.id {
                    isMyTeam = true
                    break
                }
            }
            points = team.points
            diffPoints = team.points - myTeamPoints
            if isMyTeam {
                userPointsLabel.text = "\(points) \("point".localized())"
                self.superView.backgroundColor = UIColor.AppColors.lightGray
                return "\(points) \("point".localized())".widthOfString(usingFont: userPointsLabel.font)
            } else {
                var finalString = ""
                var stringToBeColored = ""
                self.superView.backgroundColor = .white
                var colorOfString = UIColor()
                if diffPoints > 0 {
                    stringToBeColored = "\(diffPoints)+"
                    colorOfString = UIColor.AppColors.green
                } else if diffPoints < 0 {
                    stringToBeColored = "\(diffPoints * -1)-"
                    colorOfString = UIColor.AppColors.red
                } else {
                    stringToBeColored = "0"
                    colorOfString = UIColor.AppColors.red
                }
                
                finalString = "\(points) \("point".localized()) (\(stringToBeColored))"
                let attributedString = NSMutableAttributedString(string:finalString)
                let range = (finalString as NSString).range(of: stringToBeColored)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colorOfString , range: range)
                userPointsLabel.attributedText = attributedString
                
                return finalString.widthOfString(usingFont: userPointsLabel.font)
            }
        }
    }
}
