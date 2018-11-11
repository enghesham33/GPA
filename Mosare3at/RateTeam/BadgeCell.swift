//
//  BadgeCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

public protocol BadgeDelegate: class {
    func badgeSelected(index: Int)
}

class BadgeCell: UICollectionViewCell {
    static let identifier = "BadgeCell"
    var superView: UIView!
    var delegate: BadgeDelegate!
    var badge: Badge!
    var index: Int!
    
    lazy var badgeImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 23)/2
        imageView.addTapGesture(action: { (recognizer) in
            self.delegate.badgeSelected(index: self.index)
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
    
    public func setupViews() {
        superView = self.contentView
        superView.addSubviews([badgeImageview, badgeNameLabel])
        
        badgeImageview.snp.makeConstraints { (maker) in
            maker.top.equalTo(superView)
            maker.centerX.equalTo(superView)
            maker.height.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 23))
        }
        
        badgeNameLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(badgeImageview.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.trailing.equalTo(superView)
            maker.bottom.equalTo(superView)
        }
    }
    
    public func populateImage() {
        if badge.id == nil {
            self.badgeImageview.image = UIImage(named: "no_badge")
        } else {
            self.badgeImageview.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(badge.image!)")!, placeholderImage: UIImage(named: "placeholder"))
        }
        
        self.badgeNameLabel.text = badge.name
        if badge.isSelected {
            self.badgeImageview.addBorder(width: 2, color: UIColor.AppColors.green)
        } else {
            self.badgeImageview.addBorder(width: 2, color: UIColor.AppColors.gray)
        }
    }
}
