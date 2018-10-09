//
//  JoinSuccessLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/9/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import Material
import SnapKit
import Localize_Swift

protocol JoinSuccessDelegate: BaseLayoutDelegate {
    func goToProgram()
    func share()
}

public class JoinSuccessLayout: BaseLayout {
    
    var joinSuccessDelegate: JoinSuccessDelegate!
    
    init(superview: UIView, joinSuccessDelegate: JoinSuccessDelegate) {
        super.init(superview: superview, delegate: joinSuccessDelegate)
        self.joinSuccessDelegate = joinSuccessDelegate
    }
    
    lazy var congratLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.darkGray
        label.text = "congrat".localized()
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 24)
        return label
    }()
    
    lazy var avatarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.lightGray
        return view
    }()
    
    lazy var avatarImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.darkGray
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 24)
        return label
    }()
    
    lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.darkGray
        label.text = "badgeCongrat".localized()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 24)
        return label
    }()
    
    lazy var badgeImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = UIColor.AppColors.gray
        return imageView
    }()
    
    lazy var shareImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "ic_share")
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
            self.joinSuccessDelegate.share()
        })
        return imageView
    }()
    
    lazy var shareLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.primaryColor
        label.text = "share".localized()
        if Localize.currentLanguage() == "ar" {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.font = AppFont.font(type: .Bold, size: 14)
        label.isUserInteractionEnabled = true
        label.addTapGesture(action: { (recognizer) in
            self.joinSuccessDelegate.share()
        })
        return label
    }()
    
    lazy var startLearnButton: RaisedButton = {
        let button = RaisedButton(title: "startLearn".localized(), titleColor: .white)
        button.backgroundColor = UIColor.AppColors.green
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 18)
        button.layer.cornerRadius = 8
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 0.5)
        button.addTapGesture { recognizer in
            self.joinSuccessDelegate.goToProgram()
        }
        return button
    }()
    
    public func setupViews() {
        let views = [congratLabel, avatarContainerView, avatarImageview, usernameLabel, badgeLabel, badgeImageview, shareLabel, shareImageview, startLearnButton]
        
        self.superview.addSubviews(views)
        
        congratLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(superview)
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 13))
        }
        
        avatarContainerView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superview)
            maker.top.equalTo(congratLabel.snp.bottom)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15))
        }
        
        avatarContainerView.addSubviews([avatarImageview, usernameLabel])
        
        avatarImageview.snp.makeConstraints { (maker) in
            
           maker.leading.equalTo(avatarContainerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.top.equalTo(avatarContainerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 13))
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 20))
        }
        
        usernameLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(avatarImageview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.top.equalTo(congratLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 13))
        }
        
        badgeLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(avatarContainerView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.leading.equalTo(superview)
            maker.trailing.equalTo(superview)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 18))
        }
        
        badgeImageview.snp.makeConstraints { (maker) in
            maker.top.equalTo(badgeLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.centerX.equalTo(self.superview.snp.centerX)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 40))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 20))
        }
        
        shareImageview.snp.makeConstraints { (maker) in
            maker.top.equalTo(badgeImageview.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 30))
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        shareLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(badgeImageview.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            
            maker.leading.equalTo(shareImageview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 70))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        self.startLearnButton.snp.makeConstraints { maker in
            
            maker.centerX.equalTo(self.superview.snp.centerX)
            maker.bottom.equalTo(superview.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5) * -1)
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 50))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 6))
        }
    }
}
