//
//  GameMethodolofyCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift

class GameMethodologyCell: UITableViewCell {

    public static let identifier = "GameMethodolofyCell"
    var superView: UIView!
    var methodologyGameObj: StaticDataObj!
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = AppFont.font(type: .Regular, size: 16)
        return label
    }()
    
    public func setupViews() {
        let views = [containerView, titleLabel, detailsLabel]
        
        superView = self.contentView
        
        superView.addSubviews(views)
        
        containerView.snp.makeConstraints { (maker) in
            maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.bottom.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
        }
        
        containerView.addSubviews([titleLabel, detailsLabel])
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
        }
        
        detailsLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.bottom.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
        }
    }
    
    public func populateData() {    
        self.titleLabel.text = self.methodologyGameObj.title
        self.detailsLabel.text = self.methodologyGameObj.details
    }
}
