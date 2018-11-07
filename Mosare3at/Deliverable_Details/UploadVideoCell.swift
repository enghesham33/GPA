//
//  UploadVideoCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/7/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift

public protocol UploadVideoCellDelegate: class {
    func cameraVideoIconClicked()
    func galleryIconClicked()
}

class UploadVideoCell: UITableViewCell {

    public static let identifier = "UploadVideoCell"

    var superView: UIView!
    var delegate: UploadVideoCellDelegate!
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        return view
    }()
    
    lazy var videoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "mabrook")
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (_) in
            self.delegate.cameraVideoIconClicked()
        })
        return imageView
    }()
    
    lazy var galleryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "mabrook")
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (_) in
            self.delegate.galleryIconClicked()
        })
        return imageView
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
        label.text = "recordAndAttachVideo".localized()
        
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var verticalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.lightGray
        return view
    }()
    
    lazy var horizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.lightGray
        return view
    }()
    
    public func setupViews() {
        let views = [containerView, titleLabel, videoImageView, galleryImageView, verticalView, horizontalView]
        
        superView = self.contentView
        superView.addSubviews(views)
        
        containerView.snp.makeConstraints { (maker) in
            maker.leading.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.bottom.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
        }
        containerView.addSubviews([titleLabel, videoImageView, galleryImageView, verticalView, horizontalView])
        
        videoImageView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView)
            maker.top.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 20))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        horizontalView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView)
            maker.top.equalTo(videoImageView.snp.bottom)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 20))
            maker.height.equalTo(1)
        }
        
        galleryImageView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView)
            maker.top.equalTo(horizontalView.snp.bottom)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 20))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        verticalView.snp.makeConstraints { (maker) in
            maker.top.bottom.equalTo(containerView)
            maker.trailing.equalTo(horizontalView.snp.leading)
            maker.width.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.leading.top.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(verticalView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.bottom.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
        }
    }
}
