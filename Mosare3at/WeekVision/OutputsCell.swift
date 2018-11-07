//
//  OutputsCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/1/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

public protocol OutputsCellDelegate: class {
    func outputCellClicked(deliverable: Deliverable)
}

class OutputsCell: UICollectionViewCell {
    
    static let identifier = "TaskCell"
    var superView: UIView!
    var delegate: OutputsCellDelegate!
    
    var deliverable: Deliverable!
    
    lazy var deliverableTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var verticalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.gray
        return view
    }()
    
    lazy var deliverableNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.clipsToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var deliverableDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "date_icon")
        return imageView
    }()
    
    lazy var deliverableDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.clipsToBounds = true
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    public func setupViews() {
        let views = [deliverableTypeImageView, deliverableNameLabel, deliverableDateLabel, verticalView, deliverableDateImageView]
        
        self.superView = self.contentView
        
        self.superView.addSubviews(views)
        
        superView.addTapGesture { (_) in
            self.delegate.outputCellClicked(deliverable: self.deliverable)
        }
        
        self.superView.backgroundColor = UIColor.AppColors.lightGray
        self.superView.addBorder(width: 1, color: UIColor.AppColors.gray)
        self.superView.layer.cornerRadius = 8
        
        self.deliverableTypeImageView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(self.superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(self.superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.bottom.equalTo(self.superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3) * -1)
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
        }
        
        self.verticalView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(self.deliverableTypeImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.width.equalTo(1)
            maker.top.bottom.equalTo(self.superView)
        }
        
        self.deliverableNameLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(self.verticalView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
                maker.top.equalTo(self.deliverableTypeImageView)
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            
                maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
            
        }
        
        self.deliverableDateImageView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(self.verticalView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.top.equalTo(self.deliverableNameLabel.snp.bottom)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3.5))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            
        }
        
        self.deliverableDateLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(self.deliverableDateImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            
            maker.top.equalTo(self.deliverableNameLabel.snp.bottom)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
            
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            
        }
    }
    
    public func populateData() {
        if deliverable.typeTitle == "فيديو" {
            deliverableTypeImageView.image = UIImage(named: "video_icon")
        } else {
            deliverableTypeImageView.image = UIImage(named: "documentation_icon")
        }
        
        deliverableNameLabel.text = deliverable.title
        deliverableDateLabel.text = deliverable.dueDate.components(separatedBy: "T")[0]
    }
}
