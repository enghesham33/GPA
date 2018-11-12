//
//  TopView.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/3/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Localize_Swift

public protocol TopViewDelegate {
    func goBack()
    func goToNotifications()
}

public class TopView: UIView {
    
    public var delegate: TopViewDelegate!
    
    public var screenTitle: String!
    
    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        if Localize.currentLanguage() == "ar" {
            imageView.image = UIImage(named: "back_icon_arabic")
        } else {
           imageView.image = UIImage(named: "back_icon")
        }
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
            self.delegate.goBack()
        })
        return imageView
    }()
    
    lazy var notificationsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_notifications")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.isHidden = true
        imageView.addTapGesture(action: { (recognizer) in
            self.delegate.goToNotifications()
        })
        return imageView
    }()
    
    lazy var screenTitleLabel: UILabel = {
        let label = UILabel()
        //label.text = "forgetPassword".localized()
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var notificationsNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.AppColors.red
        label.isHidden = true
        label.font = AppFont.font(type: .Regular, size: 12)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1)
        return label
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo_white")
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        return imageView
    }()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setupViews(screenTitle: String) {
        let views = [backImageView, screenTitleLabel, logoImageView, notificationsImageView, notificationsNumberLabel]
        self.backgroundColor = .black
        
        self.addSubviews(views)
        
        self.backImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(self.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            
            maker.top.equalTo(self.snp.top).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        self.notificationsImageView.snp.makeConstraints { maker in
            maker.trailing.equalTo(self.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            
            maker.top.equalTo(self.snp.top).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        notificationsImageView.addSubview(notificationsNumberLabel)
        
        self.notificationsNumberLabel.snp.makeConstraints { (maker) in
            maker.leading.top.equalTo(notificationsImageView)
            maker.height.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
        }
        
        self.screenTitleLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(backImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            
            maker.top.height.equalTo(backImageView)
            
            maker.width.equalTo(screenTitle.widthOfString(usingFont: screenTitleLabel.font) + 15)
        }
        self.screenTitleLabel.text = screenTitle
        self.logoImageView.snp.makeConstraints { maker in
            maker.centerX.equalTo(self.snp.centerX)
            maker.top.height.equalTo(backImageView)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 30))
        }
    }
    
}
