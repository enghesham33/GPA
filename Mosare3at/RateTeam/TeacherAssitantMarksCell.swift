//
//  TeacherAssitantMarksCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift

public protocol TeacherAssitantMarksCellDelegate {
    func checked(ischecked: Bool, index: Int)
}

class TeacherAssitantMarksCell: UITableViewCell {

    public static let identifier = "TeacherAssitantMarksCell"

    var superView: UIView!
    var index: Int!
    var delegate: TeacherAssitantMarksCellDelegate!
    var mark: TeacherAssistantMark!
    
    lazy var checkBoxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "not_checked")
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (_) in
            if imageView.image == UIImage(named: "not_checked") {
                self.delegate.checked(ischecked: true, index: self.index)
            } else {
                self.delegate.checked(ischecked: false, index: self.index)
            }
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
        label.text = "importantNote".localized()
        
        label.font = AppFont.font(type: .Regular, size: 15)
        return label
    }()
    
    public func setupViews() {
        let views = [titleLabel, checkBoxImageView]
        
        superView = self.contentView
        superView.addSubviews(views)
        
        checkBoxImageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.bottom.trailing.equalTo(superView)
            maker.leading.equalTo(checkBoxImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
        }
    }
    
    public func populateData() {
        titleLabel.text = self.mark.mark
        if self.mark.isSelected {
            self.checkBoxImageView.image = UIImage(named: "checked")
        } else {
            self.checkBoxImageView.image = UIImage(named: "not_checked")
        }
    }
    
}
