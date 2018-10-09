//
//  ChooseAvatarLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SnapKit
import UIKit
import Material
import Localize_Swift

protocol ChooseAvatarDelegate: BaseLayoutDelegate {
    func openGallery()
    func updateAvatar()
//    func chooseImage(image: UIImage)
}

public class ChooseAvatarLayout: BaseLayout {
    
    var chooseAvatarDelegate: ChooseAvatarDelegate!
    
    init(superview: UIView, chooseAvatarDelegate: ChooseAvatarDelegate) {
        super.init(superview: superview, delegate: chooseAvatarDelegate)
        self.chooseAvatarDelegate = chooseAvatarDelegate
    }
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.darkGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 24)
        return label
    }()
    
    lazy var avatarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.lightGray
        return view
    }()
    
    lazy var choosenAvatarImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = UIColor.AppColors.gray
        return imageView
    }()
    
    lazy var cameraIconImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "ic_camera")
        imageView.addTapGesture { recognizer in
            self.chooseAvatarDelegate.openGallery()
        }
        return imageView
    }()
    
    lazy var chooseImageLabel: UILabel = {
        let label = UILabel()
        label.text = "chooseAvatar".localized()
        label.textColor = UIColor.AppColors.darkGray
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    var imagesCollectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var joinNowButton: RaisedButton = {
        let button = RaisedButton(title: "joinNow".localized(), titleColor: .white)
        button.backgroundColor = UIColor.AppColors.green
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 18)
        button.layer.cornerRadius = 8
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 0.5)
        button.addTapGesture { recognizer in
            self.chooseAvatarDelegate.updateAvatar()
        }
        return button
    }()
    
    public func setupViews() {
        let views = [welcomeLabel, avatarContainerView, chooseImageLabel, imagesCollectionView, joinNowButton, choosenAvatarImageview, cameraIconImageview]
        
        self.superview.addSubviews(views)
        
        welcomeLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(superview)
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 20))
        }
        
        avatarContainerView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superview)
            maker.top.equalTo(welcomeLabel.snp.bottom)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 55))
        }
        
        avatarContainerView.addSubviews([chooseImageLabel, imagesCollectionView, choosenAvatarImageview, cameraIconImageview])
        
        choosenAvatarImageview.snp.makeConstraints { (maker) in
           
            maker.centerX.equalTo(self.superview.snp.centerX)
            maker.top.equalTo(avatarContainerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30))
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 60))
        }
        
        cameraIconImageview.snp.makeConstraints { (maker) in
            
            maker.centerX.equalTo(self.superview.snp.centerX)
            maker.top.equalTo(choosenAvatarImageview.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 7))
        }
        
        chooseImageLabel.snp.makeConstraints { (maker) in           maker.leading.equalTo(avatarContainerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.top.equalTo(cameraIconImageview.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            
            maker.height.equalTo((self.chooseImageLabel.text?.heightOfString(usingFont: self.chooseImageLabel.font))! + 8)
            
            maker.width.equalTo((self.chooseImageLabel.text?.widthOfString(usingFont: self.chooseImageLabel.font))! + 8)
        }
        
        imagesCollectionView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(avatarContainerView)
            maker.top.equalTo(chooseImageLabel.snp.bottom)
            maker.bottom.equalTo(avatarContainerView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2) * -1)
        }
        
        self.joinNowButton.snp.makeConstraints { maker in
            
            maker.centerX.equalTo(self.superview.snp.centerX)
            maker.bottom.equalTo(superview.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5) * -1)
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 50))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 6))
        }
        
    }
}

