//
//  ProgramTopCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/21/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift
import Material

public protocol TopCellDelegate: class {
    func startNow()
    func scrollToBottom()
}

class ProgramTopCell: UITableViewCell {

    public var delegate: TopCellDelegate!
    
    static let identifier = "ProgramTopCell"
    var superView: UIView!

    lazy var programPhotoImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var curveImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "curve")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var programNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 28)
        return label
    }()
    
    lazy var milestoneView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
//         view.backgroundColor = .red
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var milestoneNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        if Localize.currentLanguage() == "ar" {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.font = AppFont.font(type: .Bold, size: 24)
        return label
    }()
    
    lazy var milestoneDetailsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.AppColors.darkGray
        if Localize.currentLanguage() == "ar" {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var milestoneNumberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.clipsToBounds = true
        label.font = AppFont.font(type: .Bold, size: 18)
        return label
    }()
    
    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        if Localize.currentLanguage() == "ar" {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.font = AppFont.font(type: .Bold, size: 18)
        return label
    }()
    
    lazy var startNowButton: RaisedButton = {
        let button = RaisedButton(title: "startNow".localized(), titleColor: .white)
        button.backgroundColor = UIColor.AppColors.darkRed
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 18)
        button.setCornerRadius(radius: 8)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 0.5)
        button.addTapGesture { recognizer in
            self.delegate.startNow()
        }
        return button
    }()
    
    lazy var arrow1ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow_up")
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
            self.delegate.scrollToBottom()
        })
        return imageView
    }()
    
    lazy var arrow2ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow_up")
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
            self.delegate.scrollToBottom()
        })
        return imageView
    }()
    
    lazy var findProjectsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.text = "findProjects".localized()
        label.textColor = UIColor.AppColors.gray
        label.textAlignment = .center
        label.font = AppFont.font(type: .Regular, size: 18)
        label.addTapGesture(action: { (recognizer) in
            self.delegate.scrollToBottom()
        })
        return label
    }()
    
    public func setupViews() {
        superView = self.contentView
        superView.addSubviews([programPhotoImageview, programNameLabel, curveImageView, findProjectsLabel, arrow1ImageView, arrow2ImageView, milestoneView, milestoneNameLabel, milestoneNumberLabel, milestoneDetailsLabel, startNowButton, taskNameLabel])
        
        superView.backgroundColor = .white
        // start of background layer
        programPhotoImageview.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.equalTo(superView)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 70))
        }
       
        curveImageView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superView)
            maker.top.equalTo(programPhotoImageview.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 13) * -1)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 27))
        }
        // end of background layer
        
        // start of first layer
        
        programNameLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.equalTo(superView)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 25))
        }
        
        milestoneView.snp.makeConstraints { (maker) in
            maker.top.equalTo(programNameLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 20))
            
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 25))
        }
        
        startNowButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(milestoneView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3.5) * -1)
            
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 7))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 7) * -1)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
        
        arrow1ImageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(startNowButton.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            
            maker.centerX.equalTo(superView.snp.centerX)
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 12))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        arrow2ImageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(arrow1ImageView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3) * -1)
            
            maker.centerX.equalTo(superView.snp.centerX)
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 12))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        findProjectsLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(arrow2ImageView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5) * -1)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        // end of first layer
        
        // start of second layer
        
        milestoneView.addSubviews([milestoneNameLabel, milestoneNumberLabel, milestoneDetailsLabel, taskNameLabel])
        
        milestoneNameLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(milestoneView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            
            maker.leading.equalTo(milestoneView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5) * -1)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        milestoneDetailsLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(milestoneNameLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            
            maker.leading.equalTo(milestoneView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5) * -1)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        milestoneNumberLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(milestoneDetailsLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.leading.equalTo(milestoneView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        milestoneNumberLabel.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5.5)/2
        milestoneNumberLabel.layer.masksToBounds = true
        milestoneNumberLabel.addBorder(width: 2, color: UIColor.AppColors.darkRed)

        taskNameLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(milestoneDetailsLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.leading.equalTo(milestoneNumberLabel.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.trailing.equalTo(milestoneView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3)  * -1)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
         self.superView.bringSubviewToFront(curveImageView)
         self.superView.bringSubviewToFront(milestoneView)
         self.superView.bringSubviewToFront(startNowButton)
         self.superView.bringSubviewToFront(arrow1ImageView)
         self.superView.bringSubviewToFront(arrow2ImageView)
         self.superView.bringSubviewToFront(findProjectsLabel)
        
        
        // end of second layer
    }
    
    public func populateData(programName: String, programPhotoUrl: String, milestoneName: String, projectTitle: String, milestoneNumber: String, taskName: String) {
        self.programNameLabel.text = "\("program2".localized())\n\(programName)"
        self.programPhotoImageview.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(programPhotoUrl)")!)
        self.milestoneNameLabel.text = milestoneName
        self.milestoneDetailsLabel.text = projectTitle
        self.milestoneNumberLabel.text = milestoneNumber
        self.taskNameLabel.text = taskName
    }
}
