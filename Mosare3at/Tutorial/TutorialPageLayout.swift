//
//  TutorialPageLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/4/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SnapKit
import UIKit
import Material
import Localize_Swift

protocol TutorialDelegate: BaseLayoutDelegate {
    func goToChooseAvatar()
}

public class TutorialLayout: BaseLayout {

    var tutorialDelegate: TutorialDelegate!
    
    init(superview: UIView, tutorialDelegate: TutorialDelegate) {
        super.init(superview: superview, delegate: tutorialDelegate)
        self.tutorialDelegate = tutorialDelegate
    }
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = AppFont.font(type: .Regular, size: 16)
        return label
    }()
    
    lazy var startSuccessButton: RaisedButton = {
        let button = RaisedButton(title: "startSuccess".localized(), titleColor: .white)
        button.backgroundColor = UIColor.AppColors.green
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 18)
        
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 0.5)
        button.addTapGesture { recognizer in
            self.tutorialDelegate.goToChooseAvatar()
        }
        return button
    }()
    
    public func setupViews(index: Int, title: String, message: String) {
        let views = [mainImageView, messageLabel, startSuccessButton, titleLabel]
        
        self.superview.addSubviews(views)
        self.superview.backgroundColor = UIColor(hexString: "#191919")!
        
        self.mainImageView.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(superview)
            
            maker.top.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 55))
        }
        
        self.titleLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(superview)
            maker.top.equalTo(self.mainImageView.snp.bottom)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        mainImageView.image = UIImage(named: "\(index)")
        titleLabel.text = title
        messageLabel.text = message
        
        if index == 5 {
            self.messageLabel.snp.makeConstraints { maker in
                maker.leading.trailing.equalTo(superview)
                maker.top.equalTo(self.titleLabel.snp.bottom)
                
                maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15))
            }
            
            self.startSuccessButton.snp.makeConstraints { maker in
                
                maker.centerX.equalTo(self.superview.snp.centerX)
                maker.top.equalTo(messageLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
                
                maker.width.equalTo("startSuccess".localized().widthOfString(usingFont: (startSuccessButton.titleLabel?.font)!) + 8)
                
                maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            }
        } else {
            self.messageLabel.snp.makeConstraints { maker in
                maker.leading.trailing.equalTo(superview)
                maker.top.equalTo(self.titleLabel.snp.bottom)
                
                maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 25))
            }
        }
        
        
    }
}

