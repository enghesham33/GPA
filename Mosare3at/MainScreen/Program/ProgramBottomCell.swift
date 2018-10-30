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
    }
    
}
