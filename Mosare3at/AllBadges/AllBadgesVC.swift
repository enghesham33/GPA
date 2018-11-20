//
//  AllBadgesVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/18/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

class AllBadgesVC: BaseVC {

    var layout: AllBadgesLayout!
    
    var badges: [Badge]!
    
    public static func buildVC(badges: [Badge]) -> AllBadgesVC {
        let vc = AllBadgesVC()
        vc.badges = badges
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = AllBadgesLayout(superview: self.view, delegate: self)
        layout.setupViews()
        
        self.layout.imagesCollectionView.dataSource = self
        self.layout.imagesCollectionView.delegate = self
        self.layout.imagesCollectionView.register(BadgeCell.self, forCellWithReuseIdentifier: BadgeCell.identifier)
        self.layout.imagesCollectionView.showsHorizontalScrollIndicator = false
        self.layout.imagesCollectionView.isScrollEnabled = true
        self.layout.imagesCollectionView.contentSize = CGSize(width: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 100), height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 300))
        if let layout = self.layout.imagesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 30), height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 30))
        }
        
        self.layout.imagesCollectionView.reloadData()
    }
}

extension AllBadgesVC: AllBadgesLayoutDelegate {
    func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AllBadgesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.badges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCell.identifier, for: indexPath) as! BadgeCell
        cell.badge = Singleton.getInstance().badges.get(at: indexPath.row)
        cell.setupViews()
        cell.populateImage()
        return cell
    }
}
