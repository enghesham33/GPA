//
//  AllBadgesLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/18/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public protocol AllBadgesLayoutDelegate : class {
    func goBack()
}

public class AllBadgesLayout: BaseLayout {
    
    public var delegate: AllBadgesLayoutDelegate!
    
    var topView: TopView = TopView()
    var screenTitle = "allBadges".localized()
    
    init(superview: UIView, delegate: AllBadgesLayoutDelegate) {
        super.init(superview: superview)
        self.delegate = delegate
    }
    
    var imagesCollectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    
    public func setupViews() {
        let views = [topView, imagesCollectionView]
        
        superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        setupTopView(screenTitle: screenTitle)
        
        self.imagesCollectionView.snp.makeConstraints { (maker) in
            maker.top.equalTo(topView.snp.bottom)
            maker.leading.trailing.bottom.equalTo(superview)
        }
        imagesCollectionView.backgroundColor = .white
    }
    
    public func setupTopView(screenTitle: String) {
        self.topView.setupViews(screenTitle: screenTitle)
        self.topView.screenTitleLabel.isHidden = false
        self.topView.backImageView.image = UIImage(named: "close")
        self.topView.delegate = self
    }
}

extension AllBadgesLayout: TopViewDelegate {
    public func goBack() {
        self.delegate.goBack()
    }
    
    public func goToNotifications() {
        
    }
}
