//
//  PopupDialogLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/18/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

public protocol PopupDialogLayoutDelegate: BaseLayoutDelegate {
    func close()
    func share()
}

public class PopupDialogLayout: BaseLayout {
    
    public var delegate: PopupDialogLayoutDelegate!
    
    public var badge: Badge!
    
    init(superview: UIView, delegate: PopupDialogLayoutDelegate) {
        super.init(superview: superview)
        self.delegate = delegate
    }
    
    lazy var exitImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
            self.delegate.close()
        })
        return imageView
    }()
    
    lazy var badgeImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (_) in
            print("badge1Imageview clicked")
        })
        return imageView
    }()
    
    lazy var badgeNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Regular, size: 18)
        return label
    }()
    
    lazy var badgeDescLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = AppFont.font(type: .Regular, size: 13)
        return label
    }()
    
    lazy var shareImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "ic_share")
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
            self.delegate.share()
        })
        return imageView
    }()
    
    lazy var shareLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.primaryColor
        label.text = "share5".localized()
        if Localize.currentLanguage() == "ar" {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.font = AppFont.font(type: .Bold, size: 14)
        label.isUserInteractionEnabled = true
        label.addTapGesture(action: { (recognizer) in
            self.delegate.share()
        })
        return label
    }()
    
    public func setupViews() {
        let views = [exitImageView, badgeImageview, badgeNameLabel, badgeDescLabel, shareLabel, shareImageview]
        
        self.superview.addSubviews(views)
        
        self.exitImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.top.equalTo(superview.snp.top).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        self.badgeImageview.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(superview)
            maker.top.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 50))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30))
        }
        
        self.badgeNameLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(superview)
            maker.top.equalTo(badgeImageview.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 50))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        self.badgeDescLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.top.equalTo(badgeNameLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
        
        shareImageview.snp.makeConstraints { (maker) in
            maker.top.equalTo(badgeDescLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 30))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        shareLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(badgeDescLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.leading.equalTo(shareImageview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 70))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
    }
    
    public func populateData() {
        badgeImageview.af_setImage(withURL: URL(string: CommonConstants.IMAGES_BASE_URL + badge.image)!)
        badgeNameLabel.text = badge.name
        badgeDescLabel.text = badge.description
    }
}
