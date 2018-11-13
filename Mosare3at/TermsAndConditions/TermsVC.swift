//
//  TermsVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

class TermsVC: BaseVC {

    var layout: TermsLayout!
    var dataSource: [StaticDataObj] = [StaticDataObj(title: "terms1Title".localized(), details: "terms1Details".localized()), StaticDataObj(title: "terms2Title".localized(), details: "terms2Details".localized())]
    
    public static func buildVC() -> TermsVC {
        let vc = TermsVC()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = TermsLayout(superview: self.view, delegate: self)
        layout.setupViews()

        layout.itemsTableView.dataSource = self
        layout.itemsTableView.delegate = self
        layout.itemsTableView.reloadData()
    }
}

extension TermsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TermsCell = self.layout.itemsTableView.dequeueReusableCell(withIdentifier: TermsCell.identifier, for: indexPath) as! TermsCell
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

extension TermsVC: TermsLayoutDelegate {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
