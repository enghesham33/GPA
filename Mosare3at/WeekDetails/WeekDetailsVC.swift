//
//  WeekDetailsVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/1/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift
import SwiftyUserDefaults

class WeekDetailsVC: BaseVC {

    var layout: WeekDetailsLayout!
    var screenTitle: String!
    var weekTitle: String!
    var week: Week!
    var projectImageUrl: String!
    var isWorkingOn: Bool!
    var weekMaterial: WeekMaterial!
    var project: Project!
    
    var presenter: WeekDetailsPresenter!
    
    static func buildVC(screenTitle: String, weekTitle: String, week: Week, project: Project, isWorkingOn: Bool) -> WeekDetailsVC {
        let vc = WeekDetailsVC()
        vc.screenTitle = screenTitle
        vc.weekTitle = weekTitle
        vc.week = week
        vc.projectImageUrl = "\(CommonConstants.IMAGES_BASE_URL)\(project.bgImage!)"
        vc.isWorkingOn = isWorkingOn
        vc.project = project
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout = WeekDetailsLayout(superview: self.view, weekDetailsLayoutDelegate: self, screenTitle: screenTitle)
        layout.setupViews()
        populateData()
        
        presenter = Injector.provideWeekDetailsPresenter()
        presenter.setView(view: self)
        presenter.getWeekMaterials(weekId: self.week.id)
    }
    
    func populateData() {
        layout.weekTitleLabel.text = weekTitle
        layout.mainImageView.af_setImage(withURL: URL(string: projectImageUrl)!)
        layout.milestonesTableView.delegate = self
        layout.milestonesTableView.dataSource = self
    }

}

extension WeekDetailsVC: WeekDetailsLayoutDelegate {
    func goToWeekVisionScreen() {
        self.navigator.navigateToWeekVisionScreen(weekMaterial: self.weekMaterial, project: self.project, week: self.week)
        print("go to week vision screen")
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func retry() {
        
    }
}

extension WeekDetailsVC: WeekDetailsView {
    func opetaionFailed(message: String) {
        self.view.makeToast(message)
    }
    
    func getWeekMaterialSuccess(weekMaterials: [WeekMaterial]) {
        self.weekMaterial = weekMaterials.get(at: 0)
        let subscription = Subscribtion.getInstance(dictionary: Defaults[.subscription]!)
        if !isWorkingOn {
            for milestone in self.weekMaterial.milestones {
                milestone.isWorkingOn = false
                milestone.isDone = false
            }
        } else {
            for milestone in self.weekMaterial.milestones {
                if subscription.milestone.weight > milestone.weight {
                    milestone.isWorkingOn = false
                    milestone.isDone = true
                } else if subscription.milestone.weight == milestone.weight {
                    milestone.isWorkingOn = true
                    milestone.isDone = false
                } else {
                    milestone.isWorkingOn = false
                    milestone.isDone = false
                }
            }
        }
        self.layout.milestonesTableView.reloadData()
        
    }
}

extension WeekDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.weekMaterial != nil {
            return weekMaterial.milestones.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MilestoneCell = self.layout.milestonesTableView.dequeueReusableCell(withIdentifier: MilestoneCell.identifier, for: indexPath) as! MilestoneCell
        
        let milestone = self.weekMaterial.milestones.get(at: indexPath.row)
        cell.selectionStyle = .none
        cell.setupViews()
        cell.milestone = milestone
        cell.isWorkingOn = milestone?.isWorkingOn
        cell.isDone = milestone?.isDone
        cell.weekWeight = self.week.weight
        cell.populateData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        let label = UILabel()
        label.textColor = .black
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "tasks".localized()
        label.font = AppFont.font(type: .Bold, size: 20)
        
        view.addSubview(label)
        
        label.snp.makeConstraints { (maker) in
            maker.leading.equalTo(view).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.trailing.equalTo(view).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.top.bottom.equalTo(view)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 100/6)
    }
}
