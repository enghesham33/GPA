//
//  AvatarCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import AlamofireImage

class AvatarCell: UICollectionViewCell {
    
    static let identifier = "CountrykpisCell"
    public var avatarLink: String!
    var superView: UIView!
    var raduis: CGFloat!
    
    var avatarImageview: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    public func setupViews() {
        superView = self.contentView
        superView.addSubviews([avatarImageview])
        avatarImageview.layer.cornerRadius = raduis
    }
}
