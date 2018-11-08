//
//  MilestoneCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/1/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift
import Material

public protocol MilestoneCellDelegate: class {
    func goToMilestonesScreen(index: Int)
}

class MilestoneCell: UITableViewCell {
    
    public var delegate: MilestoneCellDelegate!
    
    static let identifier = "MilestoneCell"
    var superView: UIView!
    
    var weekWeight: Int!
    var milestone: Milestone!
    var index: Int!
    var isDone: Bool!
    var isWorkingOn: Bool!
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.clipsToBounds = true
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var verticalView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.lightGray
        return view
    }()
    
    lazy var verticalView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.lightGray
        return view
    }()
    
    lazy var milestoneNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var doneMilestoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_done")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var estimatedTimeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "alarm")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var estimatedTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = AppFont.font(type: .Bold, size: 14)
        return label
    }()
    
    public func setupViews() {
        let views = [containerView, weightLabel, verticalView1, verticalView2, milestoneNameLabel, doneMilestoneImageView, estimatedTimeLabel, estimatedTimeIconImageView]
        
        superView = self.contentView
        superView.addSubviews(views)
        containerView.addSubviews([weightLabel, verticalView1, verticalView2, milestoneNameLabel, doneMilestoneImageView, estimatedTimeLabel, estimatedTimeIconImageView])
        
        superView.backgroundColor = UIColor.AppColors.gray
        
        superView.addTapGesture { (_) in
            self.delegate.goToMilestonesScreen(index: self.index)
        }
        
        containerView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
            
            maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            
            maker.bottom.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
        }
        
        weightLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 8))
            maker.centerY.equalTo(containerView)
        }
        
        verticalView1.snp.makeConstraints { (maker) in
            maker.leading.equalTo(weightLabel.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 6))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 8))
            
            maker.width.equalTo(1)
            maker.centerY.equalTo(containerView)
        }
        
        milestoneNameLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(verticalView1.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 35))
            
            maker.top.bottom.equalTo(containerView)
        }
        
        verticalView2.snp.makeConstraints { (maker) in
            maker.leading.equalTo(milestoneNameLabel.snp.trailing)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 8))
            
            maker.width.equalTo(1)
            maker.centerY.equalTo(containerView)
        }
        
        doneMilestoneImageView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(verticalView2.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 12))
            
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            
            maker.centerY.equalTo(containerView)
        }
        
        estimatedTimeIconImageView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(verticalView2.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            
            maker.centerY.equalTo(containerView)
        }
        
        estimatedTimeLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(estimatedTimeIconImageView.snp.trailing).offset(8)
            maker.trailing.equalTo(containerView).offset(-8)
            maker.top.bottom.equalTo(containerView)
        }
    }
    
    public func populateData() {
        changeVisibility()
        changeColors()
        weightLabel.text = "\(self.weekWeight!).\(self.milestone.weight!)"
        milestoneNameLabel.text = self.milestone.title
        let timeString = "0\(self.milestone.estimated! / 60):00 \("estimatedTime".localized())"
        estimatedTimeLabel.text = timeString
    }
    
    func changeVisibility() {
        if isDone {
            estimatedTimeLabel.isHidden = true
            estimatedTimeIconImageView.isHidden = true
            doneMilestoneImageView.isHidden = false
        } else if isWorkingOn {
            estimatedTimeLabel.isHidden = false
            estimatedTimeIconImageView.isHidden = false
            doneMilestoneImageView.isHidden = true
        } else {
            estimatedTimeLabel.isHidden = false
            estimatedTimeIconImageView.isHidden = false
            doneMilestoneImageView.isHidden = true
        }
    }
    
    func changeColors() {
        weightLabel.sizeToFit()
        weightLabel.layer.masksToBounds = true
        weightLabel.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 8)/2
        
        if isDone {
            self.containerView.backgroundColor = UIColor.white
            self.verticalView1.backgroundColor = UIColor.AppColors.gray
            self.verticalView2.backgroundColor = UIColor.AppColors.gray
            weightLabel.addBorder(width: 2, color: UIColor.AppColors.darkRed)
            weightLabel.textColor = .black
            milestoneNameLabel.textColor = .black
            estimatedTimeLabel.textColor = .black
            estimatedTimeIconImageView.image = UIImage(named: "alarm")
        } else if isWorkingOn {
            self.containerView.backgroundColor = UIColor.AppColors.darkRed
            self.verticalView1.backgroundColor = UIColor.AppColors.red
            self.verticalView2.backgroundColor = UIColor.AppColors.red
            weightLabel.addBorder(width: 2, color: UIColor.white)
            weightLabel.textColor = .white
            milestoneNameLabel.textColor = .white
            estimatedTimeLabel.textColor = .white
            estimatedTimeIconImageView.image = UIImage(named: "alarm_white")
        } else {
            self.containerView.backgroundColor = UIColor.white
            self.verticalView1.backgroundColor = UIColor.AppColors.gray
            self.verticalView2.backgroundColor = UIColor.AppColors.gray
            weightLabel.addBorder(width: 2, color: UIColor.AppColors.darkRed)
            weightLabel.textColor = .black
            milestoneNameLabel.textColor = .black
            estimatedTimeLabel.textColor = .black
            estimatedTimeIconImageView.image = UIImage(named: "alarm")
        }
    }

}
