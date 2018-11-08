//
//  NotificationCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift

class NotificationCell: UITableViewCell {

    public static let identifier = "NotificationCell"
    
    public var notification: Notification!
    
    var superView: UIView!
    
    lazy var notificationTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "mabrook")
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10)/2
        imageView.addBorderRight(size: 2, color: UIColor.AppColors.gray)
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
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.darkGray
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
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.gray
        label.backgroundColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.font = AppFont.font(type: .Regular, size: 12)
        return label
    }()
    
    public func setupViews() {
        let views = [titleLabel, detailsLabel, notificationTypeImageView, dateLabel]
        
        superView = self.contentView
        superView.addSubviews(views)
        
        notificationTypeImageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(notificationTypeImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        detailsLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(notificationTypeImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
            maker.top.equalTo(titleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(notification.data.message.byConvertingHTMLToPlainText().height(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 80), font: detailsLabel.font, lineBreakMode: .byWordWrapping))
        }
        
        dateLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(notificationTypeImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
            maker.top.equalTo(detailsLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.bottom.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
        }
    }
    
    public func populateData() {
        self.titleLabel.text = notification.data.title
        self.detailsLabel.text = notification.data.message.byConvertingHTMLToPlainText()
        let date = UiHelpers.convertStringToDate(dateString: notification.createdAt)
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: date)
        var dayName = ""
        switch weekDay {
        case 1:
            dayName = "sunday".localized()
        case 2:
            dayName = "monday".localized()
        case 3:
            dayName = "tuesday".localized()
        case 4:
            dayName = "wednesday".localized()
        case 5:
            dayName = "thursday".localized()
        case 6:
            dayName = "friday".localized()
        case 7:
            dayName = "saturday".localized()
        default:
            dayName = ""
        }
        let time = notification.createdAt.split("T")[1]
        let splittedTime = time.split(":")
        dateLabel.text = "\(dayName) \("in".localized()) \(splittedTime[0]):\(splittedTime[1])"
        
        if notification.seen {
            superView.backgroundColor = .white
        } else {
            superView.backgroundColor = UIColor.AppColors.lightGray
        }
        
        // TODO: set the image of image view according to type
        
        // TODO: set the click navigation according to type
        
        switch notification.type {
        case "deliverable_accepted":
            notificationTypeImageView.image = UIImage(named: "deliverable_accepted")
            break
            
        case "deliverable_rejected":
            notificationTypeImageView.image = UIImage(named: "deliverable_rejected")
            break
            
        case "new_points":
            notificationTypeImageView.image = UIImage(named: "new_points")
            break
            
        case "week_summary":
            notificationTypeImageView.image = UIImage(named: "week_summary")
            break
            
        case "new_badge":
            notificationTypeImageView.image = UIImage(named: "new_badge")
            break
            
        case "WeekSummary":
            notificationTypeImageView.image = UIImage(named: "message")?.withRenderingMode(.alwaysTemplate)
            notificationTypeImageView.tintColor = UIColor.AppColors.darkRed
            break
        default:
            break
        }
    }

}
