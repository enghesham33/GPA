//
//  MyProfileDetailsCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/18/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

protocol MyProfileDetailsCellDelegate {
    func navigate(index: Int)
}

class MyProfileDetailsCell: UITableViewCell {

    public static let identifier = "MyProfileDetailsCell"
    var superView: UIView!
    var index: Int!
    
    var delegate: MyProfileDetailsCellDelegate!
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.font = AppFont.font(type: .Bold, size: 18)
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "left_arrow")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    public func setupViews() {
        let views = [titleLabel, countLabel, arrowImageView]
        
        self.superView = self.contentView
        
        self.superView.addSubviews(views)
        
        self.arrowImageView.snp.remakeConstraints { (maker) in
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.centerY.equalTo(superView)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        self.countLabel.snp.remakeConstraints { (maker) in
            maker.trailing.equalTo(arrowImageView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.centerY.equalTo(superView)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        self.titleLabel.snp.remakeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(countLabel.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.top.bottom.equalTo(superView)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
    }
    
    public func populateData(title: String, count: String) {
        self.titleLabel.text = title
        self.countLabel.text = count
        superView.addTapGesture { (_) in
            self.delegate.navigate(index: self.index)
        }
    }
}
