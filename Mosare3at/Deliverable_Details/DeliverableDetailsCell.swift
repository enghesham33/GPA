//
//  DeliverableDetailsCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/7/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift

class DeliverableDetailsCell: UITableViewCell {

    public static let identifier = "DeliverableDetailsCell"
    
    var superView: UIView!
    var describtion: Description!

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
        label.backgroundColor = .white
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
        label.backgroundColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        
        label.font = AppFont.font(type: .Regular, size: 15)
        return label
    }()
    
    public func setupViews() {
        let views = [containerView, titleLabel, detailsLabel]
        
        superView = self.contentView
        superView.addSubviews(views)
        
        containerView.snp.makeConstraints { (maker) in
            maker.leading.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.bottom.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
        }
        containerView.addSubviews([titleLabel, detailsLabel])
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.leading.top.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        detailsLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.top.equalTo(titleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.bottom.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
        }
    }
    
    public func populateData() {
        self.titleLabel.text = self.describtion.title
        self.detailsLabel.text = self.describtion.description.byConvertingHTMLToPlainText()
    }
}
