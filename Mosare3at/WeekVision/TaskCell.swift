//
//  TaskCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/1/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    static let identifier = "TaskCell"
    var superView: UIView!
    
    var task: String!
    
    lazy var dotLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .right
        label.text = "."
        label.clipsToBounds = true
        label.font = AppFont.font(type: .Regular, size: 16)
        return label
    }()
    
    lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.clipsToBounds = true
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    public func setupViews() {
        let views = [taskLabel, dotLabel]
        superView = self.contentView
        superView.addSubviews(views)
        
        dotLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(8)
            maker.width.equalTo(dotLabel.text!.widthOfString(usingFont: dotLabel.font))
            maker.top.bottom.equalTo(superView)
        }
        
        taskLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(dotLabel.snp.trailing).offset(8)
            maker.trailing.equalTo(superView).offset(-8)
            maker.top.bottom.equalTo(superView)
        }
    }
    
    public func populateData() {
        taskLabel.text = task
    }
    
    public func populateCustomData(index: Int, taskString: String) {
        dotLabel.addBorder(width: 1, color: .gray)
        dotLabel.text = "\(index)"
        dotLabel.layer.cornerRadius = 4
        taskLabel.text = taskString
        
        
        taskLabel.numberOfLines = 0
        taskLabel.lineBreakMode = .byWordWrapping
        dotLabel.textAlignment = .center
        dotLabel.textColor = .black
        
        dotLabel.snp.remakeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(8)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.centerY.equalTo(superView)
        }
    }

}
