//
//  MemberVideoCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/27/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

public protocol MemberVideoCellDelegate: class {
    func playVideo(index: Int)
}

class MemberVideoCell: UICollectionViewCell {
    
    static let identifier = "MemberVideoCell"
    var superView: UIView!
    var delegate: MemberVideoCellDelegate!
    
    var video: Video!
    var index: Int!
    
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
    
    public func setupView() {
        let views = [videoThumbImageView, playIconView, playIconImageView]
        
        self.superView = self.contentView
        self.superView.addSubviews(views)
        
        self.videoThumbImageView.snp.makeConstraints { (maker) in
            maker.leading.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.bottom.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
        }
        
        self.playIconImageView.snp.makeConstraints { (maker) in
            maker.center.equalTo(superView)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 18))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
        
        self.playIconView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(playIconImageView)
        }
    }
    
    public func populateData() {
        if let thumbnails = video.thumbnails, thumbnails.count > 0 {
            if thumbnails.count == 1 {
                videoThumbImageView.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(thumbnails.get(at: 0)!.thumb!)")!)
            } else {
                videoThumbImageView.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(thumbnails.get(at: 1)!.thumb!)")!)
            }
            
        } else {
            videoThumbImageView.image = UIImage(named: "placeholder")
        }
        
    }
}
