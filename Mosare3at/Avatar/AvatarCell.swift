//
//  AvatarCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ChooseImageDelegat : class {
    func chooseImage(image: UIImage, imageName: String)
}

public class AvatarCell: UICollectionViewCell {
    
    static let identifier = "AvatarCell"
    var superView: UIView!
    var raduis: CGFloat!
    var delegate: ChooseImageDelegat!
    var imageName: String!
    
    lazy var avatarImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleToFill
        imageView.addTapGesture(action: { (recognizer) in
            self.delegate.chooseImage(image: imageView.image!, imageName: self.imageName)
        })
        return imageView
    }()
    
    public func setupViews() {
        superView = self.contentView
        superView.addSubviews([avatarImageview])
        avatarImageview.layer.cornerRadius = raduis
        
        avatarImageview.snp.makeConstraints { (maker) in
            maker.edges.equalTo(superView)
        }
    }
    
    public func populateImage(imageName: String) {
        self.avatarImageview.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(imageName)")!, placeholderImage: UIImage(named: "placeholder"))
        self.imageName = imageName
    }
}
