//
//  FiltersLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/19/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import DropDown
import UIKit
import Material

public protocol FiltersLayoutDelegate: class {
    func applyFilters()
    func cancel()
}

public class FiltersLayout: BaseLayout {
    
    var delegate: FiltersLayoutDelegate!
    
//    var selectedProgramIndex: Int = 0
//    var selectedProjectsIndex: Int = 0
//    var selectedOrderIndex: Int = 0
//    var selectedTeamIndex: Int = 0
    
    init(superview: UIView, delegate: FiltersLayoutDelegate) {
        super.init(superview: superview)
        self.delegate = delegate
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "filter".localized()
        label.font = AppFont.font(type: .Bold, size: 24)
        return label
    }()
    
    lazy var programLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.text = "program".localized()
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var programTextField: ErrorTextField = {
        let field = UiHelpers.textField(placeholder: "")
        field.returnKeyType = UIReturnKeyType.next
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.textColor = UIColor.AppColors.gray
        field.isEnabled = false
        field.textAlignment = .center
        return field
    }()
    
    lazy var programArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "down_arrow")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var projectLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.text = "project".localized()
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var projectTextField: ErrorTextField = {
        let field = UiHelpers.textField(placeholder: "")
        field.returnKeyType = UIReturnKeyType.next
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.textColor = UIColor.AppColors.gray
        field.isEnabled = false
        field.textAlignment = .center
        return field
    }()
    
    lazy var projectArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "down_arrow")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.text = "order".localized()
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var orderTextField: ErrorTextField = {
        let field = UiHelpers.textField(placeholder: "")
        field.returnKeyType = UIReturnKeyType.next
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.textColor = UIColor.AppColors.gray
        field.isEnabled = false
        field.textAlignment = .center
        return field
    }()
    
    lazy var orderArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "down_arrow")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var teamLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.text = "team".localized()
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var teamTextField: ErrorTextField = {
        let field = UiHelpers.textField(placeholder: "")
        field.returnKeyType = UIReturnKeyType.next
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.textColor = UIColor.AppColors.gray
        field.isEnabled = false
        field.textAlignment = .center
        return field
    }()
    
    lazy var teamArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "down_arrow")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var applyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "apply".localized()
        label.addTapGesture(action: { (_) in
            self.delegate.applyFilters()
        })
        label.font = AppFont.font(type: .Bold, size: 14)
        return label
    }()
    
    lazy var cancelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "cancel".localized()
        label.font = AppFont.font(type: .Bold, size: 14)
        label.addTapGesture(action: { (_) in
            self.delegate.cancel()
        })
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
        let views = [titleLabel, programLabel, programTextField, programArrowImageView, projectLabel, projectTextField, projectArrowImageView, orderLabel, orderTextField, orderArrowImageView, teamLabel, teamTextField, teamArrowImageView, applyLabel, cancelLabel, verticalView, horizontalView]
        
        self.superview.addSubviews(views)
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            maker.centerX.equalTo(superview)
        }
        
        programLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(titleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        programArrowImageView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.top.equalTo(programLabel).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 0.5))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        programTextField.snp.makeConstraints { (maker) in
            maker.top.equalTo(programLabel)
            maker.leading.equalTo(programLabel.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.trailing.equalTo(programArrowImageView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        projectLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(programLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        projectArrowImageView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.top.equalTo(projectLabel).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 0.5))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        projectTextField.snp.makeConstraints { (maker) in
            maker.top.equalTo(projectLabel)
            maker.leading.equalTo(projectLabel.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.trailing.equalTo(projectArrowImageView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        orderLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(projectLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        orderArrowImageView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.top.equalTo(orderLabel).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 0.5))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        orderTextField.snp.makeConstraints { (maker) in
            maker.top.equalTo(orderLabel)
            maker.leading.equalTo(orderLabel.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.trailing.equalTo(orderArrowImageView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        teamLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(orderLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        teamArrowImageView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.top.equalTo(teamLabel).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 0.5))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        teamTextField.snp.makeConstraints { (maker) in
            maker.top.equalTo(teamLabel)
            maker.leading.equalTo(teamLabel.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.trailing.equalTo(teamArrowImageView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        horizontalView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superview)
            maker.height.equalTo(2)
            maker.top.equalTo(teamLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
        }
        
        applyLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superview)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
            maker.top.equalTo(horizontalView.snp.bottom)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 49))
        }
        
        verticalView.snp.makeConstraints { (maker) in
            maker.top.equalTo(horizontalView.snp.bottom)
            maker.leading.equalTo(applyLabel.snp.trailing)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
            maker.width.equalTo(2)
        }
        
        cancelLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(verticalView.snp.trailing)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
            maker.top.equalTo(horizontalView.snp.bottom)
            maker.trailing.equalTo(superview)
        }
    }
    
}
