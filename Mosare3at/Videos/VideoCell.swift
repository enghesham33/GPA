//
//  VideoCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

public protocol VideoCellDelegate : class {
    func playVideo(index: Int)
}

class VideoCell: UITableViewCell {
    
    var delegate: VideoCellDelegate!
    var superView: UIView!
    var video: Video!
    var index: Int!
    
    public static let identifier = "VideoCell"
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        return view
    }()
    
    lazy var ownerProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10)/2
        return imageView
    }()
    
    lazy var ownerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.clipsToBounds = true
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    lazy var videoThumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var playIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "play_icon")
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (_) in
            self.delegate.playVideo(index: self.index)
        })
        return imageView
    }()
    
    lazy var playIconView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.addTapGesture(action: { (_) in
            self.delegate.playVideo(index: self.index)
        })
        return view
    }()
    
    lazy var videoTimeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "alarm")
        return imageView
    }()
    
    lazy var videoTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.clipsToBounds = true
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    lazy var videoDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "date_icon")
        return imageView
    }()
    
    lazy var videoDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.clipsToBounds = true
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    lazy var videoDescLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    public func setupViews() {
        let views = [containerView, ownerProfileImageView, ownerNameLabel, videoThumbImageView, playIconImageView, playIconView, videoTimeLabel, videoTimeImageView, videoDateLabel, videoDateImageView, videoDescLabel]
        
        self.superView = self.contentView
        
        self.superView.addSubviews(views)
        
        containerView.snp.makeConstraints { (maker) in
            maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 4))
            maker.bottom.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2) * -1)
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 4) * -1)
        }
        
        containerView.addSubviews([ownerProfileImageView, ownerNameLabel, videoThumbImageView, playIconImageView, playIconView, videoTimeLabel, videoTimeImageView, videoDateLabel, videoDateImageView])
        
        ownerProfileImageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.height.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10))
        }
        
        ownerNameLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(ownerProfileImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.bottom.equalTo(ownerProfileImageView)
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
        }
        
        videoThumbImageView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(containerView)
            maker.top.equalTo(ownerProfileImageView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30))
        }
        
        videoThumbImageView.addSubview(playIconImageView)
        self.playIconImageView.snp.makeConstraints { (maker) in
            maker.center.equalTo(videoThumbImageView)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 20))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10))
        }
        
        self.playIconView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(playIconImageView)
        }
        
        videoDescLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(videoThumbImageView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        videoTimeImageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(videoDescLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.height.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        videoTimeLabel.snp.makeConstraints { (maker) in
            maker.top.bottom.equalTo(videoTimeImageView)
            maker.leading.equalTo(videoTimeImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
        }
        
        videoDateImageView.snp.makeConstraints { (maker) in
            maker.top.bottom.equalTo(videoTimeImageView)
             maker.height.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            maker.leading.equalTo(containerView.snp.centerX)
        }
        
        videoDateLabel.snp.makeConstraints { (maker) in
            maker.top.bottom.equalTo(videoTimeImageView)
            maker.leading.equalTo(videoDateImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 25))
        }
    }
    
    public func populateData() {
        
        if self.video.owner.profilePic != nil && !self.video.owner.profilePic.isEmpty {
           self.ownerProfileImageView.af_setImage(withURL: URL(string: CommonConstants.IMAGES_BASE_URL + self.video.owner.profilePic)!)
        } else {
            self.ownerProfileImageView.image = UIImage(named: "no_pp")!
        }
        
        self.ownerNameLabel.text = self.video.owner.firstName + " " + self.video.owner.lastName
        if self.video.thumbnails != nil && self.video.thumbnails.count > 0 {
            self.videoThumbImageView.af_setImage(withURL: URL(string: (self.video.thumbnails.get(at: 0)?.thumb)!)!)
            self.videoThumbImageView.backgroundColor = .clear
        } else {
            self.videoThumbImageView.backgroundColor = .black
        }
        
        
        let dateTimeString = self.video.uploadDate
        let date = dateTimeString?.components(separatedBy: " ")[0]
        let time = (dateTimeString?.components(separatedBy: " ")[1].components(separatedBy: ":")[0])! + ":" + (dateTimeString?.components(separatedBy: " ")[1].components(separatedBy: ":")[1])!
        
        self.videoDateLabel.text = date
        self.videoTimeLabel.text = time
        self.videoDescLabel.text = self.video.description
    }
}
