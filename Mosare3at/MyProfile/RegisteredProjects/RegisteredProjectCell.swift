//
//  RegisteredProjectCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/20/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

class RegisteredProjectCell: UITableViewCell {

    public static let identifier = "RegisteredProjectCell"

    var superView: UIView!
    var project: RegisteredProject!
    
    lazy var projectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    lazy var projectNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.clipsToBounds = true
        label.font = AppFont.font(type: .Bold, size: 14)
        return label
    }()
    
    lazy var projectPercentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.clipsToBounds = true
        label.font = AppFont.font(type: .Bold, size: 14)
        return label
    }()
    
    lazy var projectPercentProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor.AppColors.darkRed
        progressView.trackTintColor = UIColor.AppColors.gray
        return progressView
    }()
    
    lazy var giveUpFromProjectLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "giveUpFromProject".localized(), attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        label.textColor = UIColor.AppColors.gray
        label.textAlignment = .center
        label.font = AppFont.font(type: .Regular, size: 12)
        label.addTapGesture(action: { (_) in
            
        })
        return label
    }()
    
    lazy var projectStartDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "date_icon")
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var projectStartDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.clipsToBounds = true
        label.isHidden = true
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    public func setupViews() {
        let views = [projectImageView, projectNameLabel, projectPercentLabel, projectPercentProgressView, giveUpFromProjectLabel, projectStartDateImageView, projectStartDateLabel]
        
        superView = self.contentView
        
        superView.addSubviews(views)
        
        projectImageView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 18))
            maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.bottom.equalTo(superView).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
        }
        
        projectNameLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(projectImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(projectImageView)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        projectPercentLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(projectImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(projectNameLabel.snp.bottom)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        giveUpFromProjectLabel.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(superView).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.bottom.equalTo(projectImageView).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 30))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        projectPercentProgressView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(giveUpFromProjectLabel.snp.leading).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.bottom.equalTo(projectImageView).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.leading.equalTo(projectImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.height.equalTo(4)
        }
        
        projectStartDateImageView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(projectImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 6))
            maker.bottom.equalTo(projectImageView).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        projectStartDateLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(projectStartDateImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.bottom.equalTo(projectImageView).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
            maker.trailing.equalTo(giveUpFromProjectLabel.snp.leading).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
        }
    }
    
    public func populateData() {
        
        projectImageView.af_setImage(withURL: URL(string: CommonConstants.IMAGES_BASE_URL + project.image)!)
        projectNameLabel.text = project.title
        
        if project.finishedMilestones != nil {
            projectPercentLabel.text = "\(Int(project.finishedMilestones)) %"
            projectPercentProgressView.setProgress(Float(project.finishedMilestones) / Float(100), animated: false)
            
            projectPercentLabel.isHidden = false
            projectPercentProgressView.isHidden = false
            
            projectStartDateLabel.isHidden = true
            projectStartDateImageView.isHidden = true
        } else {
            projectStartDateLabel.text = "startIn".localized() + project.startDate
            
            projectPercentLabel.isHidden = true
            projectPercentProgressView.isHidden = true
            
            projectStartDateLabel.isHidden = false
            projectStartDateImageView.isHidden = false
        }
    }
}
