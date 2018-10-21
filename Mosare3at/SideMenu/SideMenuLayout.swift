//
//  SideMenuLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

protocol SideMenuLayoutDelegate: BaseLayoutDelegate {
    func closeSideMenu()
}

protocol SideMenuHeaderDelegate: class {
    func headerClicked()
}

public class SideMenuLayout: BaseLayout {
    
    var sideMenuLayoutDelegate: SideMenuLayoutDelegate!
    var sideMenuHeaderDelegate: SideMenuHeaderDelegate!
    
    init(superview: UIView, sideMenuLayoutDelegate: SideMenuLayoutDelegate) {
        super.init(superview: superview, delegate: sideMenuLayoutDelegate)
        self.sideMenuLayoutDelegate = sideMenuLayoutDelegate
    }
    
    lazy var menuHeaderView: UIView = {
        let view = UIView()
        view.addTapGesture(action: { (recognizer) in
            self.sideMenuHeaderDelegate.headerClicked()
        })
        return view
    }()
    
    lazy var closeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "close")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
            self.sideMenuLayoutDelegate.closeSideMenu()
        })
        return imageView
    }()
    
    lazy var outputsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "المخرجات"
        label.lineBreakMode = .byWordWrapping
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var userProfilePicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var mainUserProfilePicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var curveImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "curve")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: SideMenuCell.identifier)
        return tableView
    }()
    
    lazy var copyRightsLabel: UILabel = {
        let label = UILabel()
        label.text = "copyRights".localized()
        label.backgroundColor = UIColor.AppColors.lightGray
        label.textColor = UIColor.AppColors.darkGray
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    public func setupViews() {
        let views = [menuHeaderView, menuTableView, closeImageView, outputsLabel, userProfilePicImageView, usernameLabel, mainUserProfilePicImageView, curveImageView, copyRightsLabel]
        
        self.superview.addSubviews(views)
        
        self.menuHeaderView.addSubviews([closeImageView, outputsLabel, userProfilePicImageView, usernameLabel, mainUserProfilePicImageView, curveImageView])
        
        self.menuHeaderView.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.equalTo(superview)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 50))
        }
        
        self.mainUserProfilePicImageView.snp.makeConstraints { maker in
            maker.leading.trailing.top.equalTo(self.menuHeaderView)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 45))
        }

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = mainUserProfilePicImageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainUserProfilePicImageView.addSubview(blurEffectView)
        
         menuHeaderView.bringSubviewToFront(closeImageView)
         menuHeaderView.bringSubviewToFront(userProfilePicImageView)
         menuHeaderView.bringSubviewToFront(outputsLabel)
         menuHeaderView.bringSubviewToFront(usernameLabel)
         menuHeaderView.bringSubviewToFront(curveImageView)
        
        
        self.closeImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(self.menuHeaderView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(self.menuHeaderView.snp.top).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))

            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))

            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }

        self.userProfilePicImageView.snp.makeConstraints { maker in

            maker.centerX.centerY.equalTo(self.menuHeaderView)

            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 23))

            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 23))
        }

        self.outputsLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(self.menuHeaderView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
            maker.trailing.equalTo(self.userProfilePicImageView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
           maker.centerY.equalTo(self.menuHeaderView.snp.centerY)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10))
        }

        self.usernameLabel.snp.makeConstraints { maker in

            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))

           maker.leading.trailing.equalTo(self.menuHeaderView)
            maker.top.equalTo(self.userProfilePicImageView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
        }

        self.curveImageView.snp.makeConstraints { maker in

            maker.leading.trailing.bottom.equalTo(self.menuHeaderView)
            maker.top.equalTo(usernameLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
        }
        
        self.menuTableView.snp.makeConstraints { maker in
            
            maker.leading.trailing.equalTo(self.superview)
            maker.top.equalTo(self.menuHeaderView.snp.bottom)
            maker.bottom.equalTo(self.superview.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10) * -1)
        }
        
        self.copyRightsLabel.snp.makeConstraints { maker in
            
            maker.leading.trailing.equalTo(self.superview)
            maker.top.equalTo(self.menuTableView.snp.bottom)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10))
        }
    }
    
}
