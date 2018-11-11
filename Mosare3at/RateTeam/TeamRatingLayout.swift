//
//  TeamRatingLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift
import Material

public protocol TeamRatingLayoutDelegate: BaseLayoutDelegate {
    func goBack()
    func goToNextUser()
    func goToPreviousUser()
}

public class TeamRatingLayout: BaseLayout {
    
    var teamRatingLayoutDelegate: TeamRatingLayoutDelegate!
    var topView: TopView = TopView()
    var screenTitle = "rateTitle".localized()
    
    init(superview: UIView, teamRatingLayoutDelegate: TeamRatingLayoutDelegate) {
        super.init(superview: superview)
        self.teamRatingLayoutDelegate = teamRatingLayoutDelegate
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.primaryColor
        label.backgroundColor = .white
        label.text = "rateSubTitle".localized()
        label.textAlignment = .center
        label.font = AppFont.font(type: .Regular, size: 15)
        return label
    }()
    
    lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 33)/2
        return imageView
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.darkGray
        label.backgroundColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 15)
        return label
    }()
    
    lazy var userPositionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.darkGray
        label.backgroundColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = AppFont.font(type: .Regular, size: 13)
        return label
    }()
    
    lazy var evaluateTeacherAssistantLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.darkGray
        label.backgroundColor = .white
        label.lineBreakMode = .byWordWrapping
        label.text = "rateTeacherAssistant".localized()
        label.numberOfLines = 0
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.font = AppFont.font(type: .Bold, size: 15)
        return label
    }()
    
    lazy var progrssBar: UISlider = {
        
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.tintColor = UIColor.AppColors.darkRed
        return slider
        
    }()
    
    lazy var startProgressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.text = "0"
        label.font = AppFont.font(type: .Bold, size: 12)
        return label
    }()
    
    lazy var currentProgressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.font = AppFont.font(type: .Bold, size: 12)
        return label
    }()
    
    lazy var endProgressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.text = "10"
        label.font = AppFont.font(type: .Bold, size: 12)
        return label
    }()
    
    lazy var teacherAssistantMarksTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.register(TeacherAssitantMarksCell.self, forCellReuseIdentifier: TeacherAssitantMarksCell.identifier)
        return tableView
    }()
    
    lazy var horizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.lightGray
        return view
    }()
    
    lazy var addCommentField: ErrorTextField = {
        let field = UiHelpers.textField(placeholder: "addComment".localized())
        return field
    }()
    
    lazy var previousView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        view.addTapGesture(action: { (_) in
            self.teamRatingLayoutDelegate.goToPreviousUser()
        })
        return view
    }()
    
    lazy var previousLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "previous".localized()
        label.font = AppFont.font(type: .Bold, size: 12)
        return label
    }()
    
    lazy var previousArrowsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "right_arrows")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.AppColors.darkRed
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var usersNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = UIColor.AppColors.gray
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var nextView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        view.addTapGesture(action: { (_) in
            self.teamRatingLayoutDelegate.goToNextUser()
        })
        return view
    }()
    
    lazy var nextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.text = "next".localized()
        label.font = AppFont.font(type: .Bold, size: 12)
        return label
    }()
    
    lazy var nextArrowsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "left_arrows")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.AppColors.darkRed
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var badgesCollectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    
    public func setupViews() {
        let views = [topView, titleLabel, userProfileImageView, usernameLabel, userPositionLabel, evaluateTeacherAssistantLabel, progrssBar, startProgressLabel, currentProgressLabel, endProgressLabel, teacherAssistantMarksTableView, addCommentField, previousView, previousLabel, previousArrowsImageView, nextView, nextLabel, nextArrowsImageView, usersNumberLabel, horizontalView, badgesCollectionView]
        
        superview.addSubviews(views)
        
        // ****************** Common section ******************
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        setupTopView(screenTitle: screenTitle)
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superview)
            maker.top.equalTo(topView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        userProfileImageView.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(superview)
            maker.top.equalTo(titleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 33))
        }
        
        usernameLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superview)
            maker.top.equalTo(userProfileImageView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        userPositionLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superview)
            maker.top.equalTo(usernameLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        evaluateTeacherAssistantLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(userPositionLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        // ****************** End of common section ******************
        
        // ****************** Bottom section ******************
        
        self.previousView.snp.makeConstraints { (maker) in
            maker.leading.bottom.equalTo(superview)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 40))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 8))
        }
        
        self.previousView.addSubviews([previousLabel, previousArrowsImageView])
        
        self.previousArrowsImageView.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(previousView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3) * -1)
            maker.leading.equalTo(previousView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.top.equalTo(previousView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
        }
        self.previousLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(previousView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2) * -1)
            maker.leading.equalTo(previousArrowsImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(previousView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(previousView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
        }
        
        self.usersNumberLabel.snp.makeConstraints { (maker) in
            maker.bottom.top.equalTo(previousView)
            maker.leading.equalTo(previousView.snp.trailing)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 20))
        }
        
        self.nextView.snp.makeConstraints { (maker) in
            maker.trailing.bottom.equalTo(superview)
            maker.leading.equalTo(usersNumberLabel.snp.trailing)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 8))
        }
        
        self.nextView.addSubviews([nextLabel, nextArrowsImageView])
        
        self.nextArrowsImageView.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(nextView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3) * -1)
            maker.trailing.equalTo(nextView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.top.equalTo(nextView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
        }
        
        self.nextLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(nextView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2) * -1)
            maker.leading.equalTo(nextView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(nextView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(nextArrowsImageView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
        }
        
        self.addCommentField.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.bottom.equalTo(self.nextView.snp.top).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
        }
        
        // ****************** End of bottom section ******************
        
        // ****************** Teacher section ******************
        self.progrssBar.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.top.equalTo(evaluateTeacherAssistantLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
        }
        
        self.startProgressLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(progrssBar)
            maker.top.equalTo(progrssBar.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
        }
        
        self.currentProgressLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(superview)
            maker.top.equalTo(progrssBar.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10))
        }
        
        self.endProgressLabel.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(progrssBar)
            maker.top.equalTo(progrssBar.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
        }
        
        self.teacherAssistantMarksTableView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(progrssBar)
            maker.top.equalTo(currentProgressLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 40))
        }
        
        self.horizontalView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superview)
            maker.height.equalTo(2)
            maker.top.equalTo(teacherAssistantMarksTableView.snp.bottom).offset(8)
        }
        
        // ****************** End of teacher section ******************
        
        // ****************** Student section ******************
        self.badgesCollectionView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(progrssBar)
            maker.top.equalTo(evaluateTeacherAssistantLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 35))
            maker.trailing.equalTo(progrssBar)
        }
        badgesCollectionView.backgroundColor = .clear
        // ****************** End of student section ******************
        
        superview.bringSubviewToFront(nextView)
        superview.bringSubviewToFront(previousView)
        superview.bringSubviewToFront(usersNumberLabel)
        
    }
    
    public func setupTopView(screenTitle: String) {
        self.topView.setupViews(screenTitle: screenTitle)
        self.topView.screenTitleLabel.isHidden = false
        self.topView.delegate = self
    }

    public func updateCollectionViewConstraints(numberOfItems: Int) {
        self.badgesCollectionView.snp.remakeConstraints { (maker) in
            maker.leading.equalTo(progrssBar)
            maker.top.equalTo(evaluateTeacherAssistantLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 35))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 20) * CGFloat(numberOfItems))
        }
    }
}

extension TeamRatingLayout: TopViewDelegate {
    public func goBack() {
        self.teamRatingLayoutDelegate.goBack()
    }
    
    public func goToNotifications() {
        
    }
}
