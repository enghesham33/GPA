//
//  ProgramBottomCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/22/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift
import Material

public protocol BottomCellDelegate: class {
    
}

class ProgramBottomCell: UITableViewCell {
    
    var delegate: BottomCellDelegate!
    var programId: Int!
    
    static let identifier = "ProgramBottomCell"
    var superView: UIView!
    
    var vc: ProjectsPagerVC = ProjectsPagerVC.buildVC()
    
    public func setupViews() {
        vc.programId = programId
        self.superView = self.contentView
        self.superView.addSubview(vc.view)
        self.vc.view.snp.makeConstraints { (maker) in
            maker.leading.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            
            maker.trailing.bottom.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2) * -1)
        }
    }
    
    func dropShadow(scale: Bool = true, view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 1
        
        view.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}
