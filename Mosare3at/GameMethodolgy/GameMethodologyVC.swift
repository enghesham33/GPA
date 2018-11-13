//
//  GameMethodologyVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

class GameMethodologyVC: BaseVC {

    var layout: GameMethodologyLayout!
    var dataSource: [StaticDataObj] = [StaticDataObj(title: "game1Title".localized(), details: "game1Details".localized()), StaticDataObj(title: "game2Title".localized(), details: "game2Details".localized()), StaticDataObj(title: "game3Title".localized(), details: "game3Details".localized()), StaticDataObj(title: "game4Title".localized(), details: "game4Details".localized())]
    
    public static func buildVC() -> GameMethodologyVC {
        let vc = GameMethodologyVC()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = GameMethodologyLayout(superview: self.view, delegate: self)
        layout.setupViews()

        layout.itemsTableView.dataSource = self
        layout.itemsTableView.delegate = self
        layout.itemsTableView.reloadData()
    }
}

extension GameMethodologyVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:GameMethodologyCell = self.layout.itemsTableView.dequeueReusableCell(withIdentifier: GameMethodologyCell.identifier, for: indexPath) as! GameMethodologyCell
        cell.selectionStyle = .none
        cell.setupViews()
        cell.methodologyGameObj = self.dataSource.get(at: indexPath.row)!
        cell.populateData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (dataSource.get(at: indexPath.row)?.details.height(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 80), font: AppFont.font(type: .Regular, size: 16), lineBreakMode: .byWordWrapping))! + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7)
    }
}

extension GameMethodologyVC: GameMethodologyLayoutDelegate {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
