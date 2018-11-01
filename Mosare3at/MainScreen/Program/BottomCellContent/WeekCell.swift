//
//  WeekCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/22/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift

public protocol WeekCellDelegate: class {
    func weekCellClicked(index: Int, isOpened: Bool, screenTitle: String, weekTitle: String, week: Week, project: Project, isWorkingOn: Bool)
}

class WeekCell: UITableViewCell {

    static let identifier = "WeekCell"
    var superView: UIView!
    
    public var week: Week!
    public var index: Int!
    public var isOpened: Bool!
    public var isWorkingOn: Bool!
    public var delegate: WeekCellDelegate!
    public var currentWeekStatus: CurrentWeekStatus!
    public var project: Project!
    
    lazy var outputsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "outputs".localized()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = AppFont.font(type: .Regular, size: 16)
        return label
    }()
    
    lazy var tasksLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "tasks".localized()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = AppFont.font(type: .Regular, size: 16)
        return label
    }()
    
    lazy var timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "alarm")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.numberOfLines = 1
        label.font = AppFont.font(type: .Regular, size: 16)
        return label
    }()
    
    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.numberOfLines = 1
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var tasksPercentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = AppFont.font(type: .Regular, size: 16)
        return label
    }()
    
    lazy var outputsPercentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = AppFont.font(type: .Bold, size: 14)
        return label
    }()
    
    lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = AppFont.font(type: .Bold, size: 18)
        return label
    }()
    
    public func setupViews() {
        self.superView = self.contentView
        
        self.superView.addSubviews([titleLabel, summaryLabel, outputsLabel, tasksLabel, timeImageView, tasksPercentLabel, outputsPercentLabel, startDateLabel])
        
        titleLabel.snp.makeConstraints { (maker) in
           maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            
            maker.height.equalTo(self.week.title.heightOfString(usingFont: self.titleLabel.font) + 4)
        }
        
        summaryLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.width.equalTo(self.week.summary.widthOfString(usingFont: self.summaryLabel.font) + 4)
            maker.height.equalTo(self.week.summary.heightOfString(usingFont: self.summaryLabel.font) + 4)
        }
        
        outputsLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(self.superView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.width.equalTo(outputsLabel.text!.widthOfString(usingFont: outputsLabel.font))
            maker.height.equalTo(outputsLabel.text!.heightOfString(usingFont: outputsLabel.font))
            
        }

        outputsPercentLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(outputsLabel.snp.bottom)
            maker.trailing.equalTo(self.superView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            
            maker.width.equalTo(outputsLabel)
            maker.height.equalTo("0/10".heightOfString(usingFont: self.outputsPercentLabel.font))
            
        }
        
        tasksLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(self.outputsLabel.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.width.equalTo(tasksLabel.text!.widthOfString(usingFont: tasksLabel.font))
            maker.height.equalTo(tasksLabel.text!.heightOfString(usingFont: tasksLabel.font))
        }

        tasksPercentLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(outputsLabel.snp.bottom)
            maker.trailing.equalTo(self.outputsLabel.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            
            maker.width.equalTo(tasksLabel)
            maker.height.equalTo("0/10".heightOfString(usingFont: self.tasksPercentLabel.font))
        }

        startDateLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(summaryLabel)
            maker.trailing.equalTo(self.superView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.width.equalTo(self.week.startDate.components(separatedBy: "T")[0].widthOfString(usingFont: self.startDateLabel.font))
            maker.height.equalTo(self.week.startDate.heightOfString(usingFont: self.startDateLabel.font) + 4)
        }

        timeImageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(startDateLabel).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1.5))
            maker.trailing.equalTo(startDateLabel.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
        }
    }
    
    public func populateCellData() {
        
        var title: String = "الاسبوع الاول"
        switch self.week.weight {
        case 1:
            title = "الاسبوع الاول"
            break
            
        case 2:
            title = "الاسبوع الثاني"
            break
            
        case 3:
            title = "الاسبوع الثالث"
            break
            
        case 4:
            title = "الاسبوع الرابع"
            break
            
        case 5:
            title = "الاسبوع الخامس"
            break
            
        case 6:
            title = "الاسبوع السادس"
            break
            
        case 7:
            title = "الاسبوع السابع"
            break
            
        case 8:
            title = "الاسبوع الثامن"
            break
            
        default:
            break
        }
        
        self.titleLabel.text = title
        self.summaryLabel.text = self.week.title
        
        if isOpened {
            self.superView.addTapGesture { (_) in
                self.delegate.weekCellClicked(index: self.index, isOpened: self.isOpened, screenTitle: title, weekTitle: self.week.title, week: self.week, project: self.project, isWorkingOn: self.isWorkingOn)
            }
        } else {
            self.superView.addTapGesture(action: nil)
        }
        changeLabelsColor()
        changeVisibility()
        //let weekStartDate = Date(fromString: self.week.startDate, format: "yyyy-MM-ddT")
        self.startDateLabel.text = self.week.startDate.components(separatedBy: "T")[0]
        if self.currentWeekStatus != nil {
            self.outputsPercentLabel.text = "\(self.currentWeekStatus.deliveredDeliverables!)/\(self.currentWeekStatus.allDeliverables!)"
            self.tasksPercentLabel.text = "\(self.currentWeekStatus.finishedMilestones!)/\(self.currentWeekStatus.allMilestones!)"
        }
    }
    
    func changeLabelsColor() {
        if isWorkingOn {
            self.superView.backgroundColor = UIColor.AppColors.darkRed
            self.titleLabel.textColor = .white
            self.summaryLabel.textColor = .white
            self.outputsPercentLabel.textColor = .white
            self.tasksPercentLabel.textColor = .white
            self.outputsLabel.textColor = .white
            self.tasksLabel.textColor = .white
            self.timeImageView.image = UIImage(named: "alarm")
        } else {
            self.superView.backgroundColor = .white
            if isOpened {
                self.titleLabel.textColor = .black
                self.summaryLabel.textColor = .black
                self.outputsPercentLabel.textColor = .black
                self.tasksPercentLabel.textColor = .black
                self.outputsLabel.textColor = .black
                self.tasksLabel.textColor = .black
                self.startDateLabel.textColor = .black
                self.timeImageView.image = UIImage(named: "alarm")
            } else {
                self.titleLabel.textColor = UIColor.AppColors.gray
                self.summaryLabel.textColor = UIColor.AppColors.gray
                self.outputsPercentLabel.textColor = UIColor.AppColors.gray
                self.tasksPercentLabel.textColor = UIColor.AppColors.gray
                self.outputsLabel.textColor = UIColor.AppColors.gray
                self.tasksLabel.textColor = UIColor.AppColors.gray
                self.startDateLabel.textColor = UIColor.AppColors.gray
                self.timeImageView.image = UIImage(named: "alarm_disabled")
            }
        }
    }
    
    func changeVisibility() {
        self.tasksLabel.isHidden = !isWorkingOn
        self.outputsPercentLabel.isHidden = !isWorkingOn
        self.outputsLabel.isHidden = !isWorkingOn
        self.tasksPercentLabel.isHidden = !isWorkingOn
        self.timeImageView.isHidden = isWorkingOn
        self.startDateLabel.isHidden = isWorkingOn
    }
    
}
