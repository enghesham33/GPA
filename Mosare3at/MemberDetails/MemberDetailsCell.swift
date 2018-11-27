//
//  MemberDetailsCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/25/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

public protocol MemberDetailsCellDelegate: class {
    func close()
    func openSlack()
    func openProgramDetails()
    func openMoreVideos()
    func badgeClicked(index: Int)
    func playVideo(index: Int)
}

class MemberDetailsCell: UITableViewCell {

    var delegate: MemberDetailsCellDelegate!
    
    var userInfo: UserInfo!
    var videos: [Video]!
    var isTeamMate: Bool!
    var member: TeamMember!
    
    public static let identifier = "MemberDetailsCell"
    var superView: UIView!

    lazy var menuHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var closeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "back_icon_arabic")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
            self.delegate.close()
        })
        return imageView
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
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 23)/2
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var slackImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "slack_ic")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5)/2
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
            self.delegate.openSlack()
        })
        return imageView
    }()
    
    lazy var teamPicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "team")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
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
    
    lazy var rankingValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.AppColors.gray
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10)/2
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var pointsView: UIView = {
        let imageView = UIView()
        imageView.backgroundColor = UIColor.AppColors.gray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10)/2
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var pointsTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "point".localized()
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    lazy var pointsValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var badgesView: UIView = {
        let imageView = UIView()
        imageView.backgroundColor = UIColor.AppColors.gray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10)/2
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var badgesTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "badges".localized()
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    lazy var badgesValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var horizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.gray
        return view
    }()
    
    lazy var badgesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.text = "badges".localized()
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    var badgesCollectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var registeredProgramsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        view.addTapGesture(action: { (_) in
            self.delegate.openProgramDetails()
        })
        return view
    }()
    
    lazy var registeredProgramsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.text = "registeredProjects".localized()
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var programNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 18)
        return label
    }()
    
    lazy var programPhotoImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var videosView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        return view
    }()
    
    lazy var videosLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.text = "videos".localized()
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    var videosCollectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var noVideosLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.isHidden = true
        label.text = "noVideos".localized()
        label.font = AppFont.font(type: .Bold, size: 15)
        return label
    }()
    
    lazy var moreVideosImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "left_arrow")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.AppColors.darkRed
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 20)/2
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (_) in
            self.delegate.openMoreVideos()
        })
        return imageView
    }()
    
    public func setupViews() {
        let views = [closeImageView, menuHeaderView, usernameLabel, userProfilePicImageView, slackImageview, teamPicImageView, userTeamNameLabel, mainUserProfilePicImageView, curveImageView, rankingValueLabel, pointsTitleLabel, pointsValueLabel, badgesTitleLabel, badgesValueLabel, horizontalView, badgesLabel, badgesCollectionView, registeredProgramsView, registeredProgramsLabel, programNameLabel, programPhotoImageview, videosView, videosLabel, videosCollectionView, noVideosLabel, moreVideosImageview, badgesView, pointsView]
        
        self.superView = self.contentView
        
        self.superView.addSubviews(views)
        
        self.menuHeaderView.addSubviews([closeImageView, userProfilePicImageView, usernameLabel, mainUserProfilePicImageView, curveImageView, teamPicImageView, userTeamNameLabel])
        
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
            maker.height.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 23))
        }
        
        self.slackImageview.snp.makeConstraints { (maker) in
            maker.leading.equalTo(userProfilePicImageView)
            maker.top.equalTo(userProfilePicImageView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 17))
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
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
        
        self.rankingValueLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(curveImageView)
            maker.top.equalTo(curveImageView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10))
        }
        
        pointsView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(rankingValueLabel.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.top.equalTo(rankingValueLabel).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2) * -1)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10))
        }
        
        pointsView.addSubviews([pointsTitleLabel, pointsValueLabel])
        
        pointsValueLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(pointsView)
            maker.top.equalTo(pointsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2.5))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2.5))
        }
        
        pointsTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(pointsView)
            maker.top.equalTo(pointsValueLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2.5))
        }
        
        badgesView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(rankingValueLabel.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.top.equalTo(rankingValueLabel).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2) * -1)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10))
        }
        
        badgesView.addSubviews([badgesTitleLabel, badgesValueLabel])
        
        badgesValueLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(badgesView)
            maker.top.equalTo(badgesView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2.5))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2.5))
        }
        
        badgesTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(badgesView)
            maker.top.equalTo(badgesValueLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2.5))
        }
        
        horizontalView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superView)
            maker.top.equalTo(curveImageView.snp.bottom)
            maker.height.equalTo(2)
        }
        
        badgesLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(horizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 50))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        badgesCollectionView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView)
            maker.top.equalTo(badgesLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 22))
        }
        
        registeredProgramsView.snp.makeConstraints { (maker) in
            maker.top.equalTo(badgesCollectionView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 27))
        }
        
        registeredProgramsView.addSubviews([registeredProgramsLabel, programPhotoImageview, programNameLabel])
        
        registeredProgramsLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(registeredProgramsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(registeredProgramsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(registeredProgramsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        programPhotoImageview.snp.makeConstraints { (maker) in
            maker.top.equalTo(registeredProgramsLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(registeredProgramsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(registeredProgramsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 18))
        }
        
        programNameLabel.snp.makeConstraints { (maker) in
            maker.center.equalTo(programPhotoImageview)
            maker.leading.trailing.equalTo(programPhotoImageview)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        videosView.snp.makeConstraints { (maker) in
            maker.top.equalTo(registeredProgramsView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30))
        }
        
        videosView.addSubviews([videosLabel, videosCollectionView, noVideosLabel, moreVideosImageview])
        
        videosLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(videosView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(videosView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(videosView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        videosCollectionView.snp.makeConstraints { (maker) in
            maker.top.equalTo(videosLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(videosView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(videosView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 23))
        }
        
        noVideosLabel.snp.makeConstraints { (maker) in
            maker.center.equalTo(videosCollectionView)
            maker.leading.trailing.equalTo(videosCollectionView)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        moreVideosImageview.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(videosView)
            maker.trailing.equalTo(videosView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        videosView.bringSubviewToFront(moreVideosImageview)
        
    }
    
    public func populateData() {
        if isTeamMate {
            teamPicImageView.isHidden = true
            userTeamNameLabel.isHidden = true
            
            slackImageview.isHidden = false
        } else {
            teamPicImageView.isHidden = false
            userTeamNameLabel.isHidden = false
            
            slackImageview.isHidden = true
        }
        
        userTeamNameLabel.text = userInfo.currentTeamName
        usernameLabel.text = member.member.firstname + " " + member.member.lastname
        mainUserProfilePicImageView.af_setImage(withURL: URL(string: CommonConstants.IMAGES_BASE_URL + member.member.profilePic)!)
        userProfilePicImageView.af_setImage(withURL: URL(string: CommonConstants.IMAGES_BASE_URL + member.member.profilePic)!)
        pointsValueLabel.text = "\(member.points!)"
        rankingValueLabel.text = "#\(member.rank!)"
        badgesValueLabel.text = "\(member.badgesCount!)"
        
        badgesCollectionView.backgroundColor = .clear
        badgesCollectionView.dataSource = self
        badgesCollectionView.delegate = self
        badgesCollectionView.register(MemberBadgeCell.self, forCellWithReuseIdentifier: MemberBadgeCell.identifier)
        badgesCollectionView.showsHorizontalScrollIndicator = false
        badgesCollectionView.isScrollEnabled = true
        badgesCollectionView.contentSize = CGSize(width: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 100), height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 22))
        if let layout = badgesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 22), height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 22))
        }
        
        badgesCollectionView.reloadData()
        
        let lastItemIndex = IndexPath(item: userInfo.badges.count - 1, section: 0)
        badgesCollectionView.scrollToItem(at: lastItemIndex, at: UICollectionView.ScrollPosition.right, animated: true)
        
        if let program = Subscribtion.getInstance(dictionary: Defaults[.subscription]!).program {
            programNameLabel.text = program.title
            programPhotoImageview.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(program.bgImage!)")!)
        }
        
        if videos.count > 0 {
            videosCollectionView.isHidden = false
            noVideosLabel.isHidden = true
            
            videosCollectionView.backgroundColor = .clear
            videosCollectionView.dataSource = self
            videosCollectionView.delegate = self
            videosCollectionView.register(MemberVideoCell.self, forCellWithReuseIdentifier: MemberVideoCell.identifier)
            videosCollectionView.showsHorizontalScrollIndicator = false
            videosCollectionView.isScrollEnabled = true
            videosCollectionView.contentSize = CGSize(width: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 100), height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 22))
            if let layout = videosCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                layout.itemSize = CGSize(width: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30), height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30))
            }
            
            videosCollectionView.reloadData()
            
            let lastVideoIndex = IndexPath(item: videos.count - 1, section: 0)
            videosCollectionView.scrollToItem(at: lastVideoIndex, at: UICollectionView.ScrollPosition.right, animated: true)
        } else {
            videosCollectionView.isHidden = true
            noVideosLabel.isHidden = false
        }        
    }
}

extension MemberDetailsCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == badgesCollectionView {
            return userInfo.badges.count
        } else {
            return videos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == badgesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberBadgeCell.identifier, for: indexPath) as! MemberBadgeCell
            cell.badge = userInfo.badges.get(at: indexPath.row)
            cell.delegate = self
            cell.index = indexPath.row
            cell.setupViews()
            cell.populateImage()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberVideoCell.identifier, for: indexPath) as! MemberVideoCell
            cell.video = videos.get(at: indexPath.row)
            cell.delegate = self
            cell.index = indexPath.row
            cell.setupView()
            cell.populateData()
            return cell
        }
    }
    
}

extension MemberDetailsCell: BadgeDelegate {
    func badgeSelected(index: Int) {
       self.delegate.badgeClicked(index: index)
    }
}

extension MemberDetailsCell: MemberVideoCellDelegate {
    func playVideo(index: Int) {
        self.delegate.playVideo(index: index)
    }
}
