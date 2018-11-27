//
//  MemberBadgeCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/27/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

class MemberBadgeCell: UICollectionViewCell {
    static let identifier = "MemberBadgeCell"
    var superView: UIView!
    var delegate: BadgeDelegate!
    var badge: Badge!
    var index: Int!
    
    lazy var badgeImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 18)/2
        imageView.addTapGesture(action: { (recognizer) in
            if self.delegate != nil {
                self.delegate.badgeSelected(index: self.index)
            }
            
        })
        return imageView
    }()
    
    lazy var badgeNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.primaryColor
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 15)
        return label
    }()
    
    lazy var badgeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.AppColors.darkRed
        label.font = AppFont.font(type: .Regular, size: 12)
        label.clipsToBounds = true
        label.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1.5)
        return label
    }()
    
    public func setupViews() {
        superView = self.contentView
        superView.addSubviews([badgeImageview, badgeNameLabel, badgeCountLabel])
        
        badgeImageview.snp.makeConstraints { (maker) in
            maker.top.equalTo(superView)
            maker.centerX.equalTo(superView)
            maker.height.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 18))
        }
        
        badgeNameLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(badgeImageview.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.trailing.equalTo(superView)
            maker.bottom.equalTo(superView)
        }
                
        self.badgeCountLabel.snp.makeConstraints { (maker) in
            maker.leading.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.height.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        superView.bringSubviewToFront(badgeCountLabel)
    }
    
    public func populateImage() {
        
        self.badgeImageview.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(badge.image!)")!, placeholderImage: UIImage(named: "placeholder"))
        
        self.badgeNameLabel.text = badge.name
        
        if let count = badge.count {
            self.badgeCountLabel.text = "\(count)"
        }
    }
}
