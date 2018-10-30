//
//  ProjectPageVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/22/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class ProjectPageVC: BaseVC {

    
    var presenter: ProjectPagerPresenter!
    var layout: ProjectPageLayout!
    var weeks: [Week] = []
    var currentWeekStatus: CurrentWeekStatus!
    var projectId: Int!
    var project: Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Injector.provideProjectPagerPresenter()
        presenter.setView(view: self)
        
        layout = ProjectPageLayout(superview: self.view, projectPageLayoutDelegate: self)
        layout.setupViews()
        self.layout.weeksTableView.dataSource = self
        self.layout.weeksTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.getWeeks(projectId: projectId)
        
        
        var title: String = "المشروع الاول"
        switch project.weight {
        case 1:
            title = "المشروع الاول"
            break
            
        case 2:
            title = "المشروع الثاني"
            break
            
        case 3:
            title = "المشروع الثالث"
            break
            
        case 4:
            title = "المشروع الرابع"
            break
            
        case 5:
            title = "المشروع الخامس"
            break
            
        case 6:
            title = "المشروع السادس"
            break
            
        case 7:
            title = "المشروع السابع"
            break
            
        case 8:
            title = "المشروع الثامن"
            break
            
        default:
            break
        }
        
        self.layout.titleLabel.text = title
        self.layout.summaryLabel.text = project.title
        self.layout.mainImageView.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(project.bgImage!)")!)
    }
    
    func getIsOpened(week: Week) -> Bool {
        let currentDate = Date()
        let startDate = UiHelpers.convertStringToDate(dateString: week.startDate)
        if UiHelpers.compareDates(date1: currentDate, date2: startDate) == .FIRST_GREATER {
            return true
        } else {
            return false
        }
    }
    
    func getIsWorkingOn(week: Week) -> Bool {
        if !getIsOpened(week: week) {
            return false
        } else {
            if week.requestId == Week.getInstance(dictionary: Defaults[.currentWeek]!).requestId {
                return true
            } else {
                return false
            }
        }
    }
}

extension ProjectPageVC : ProjectPageView {
    
    func opetaionFailed(message: String) {
        self.view.makeToast(message)
    }
    
    func getProjectsSuccess(projects: [Project]) {
        // nothing to do
    }
    
    func getWeeksSuccess(weeks: [Week]) {
        self.weeks.removeAll()
        self.weeks = weeks
        
        presenter.getCurrentWeekStatus(weekId: Week.getInstance(dictionary: Defaults[.currentWeek]!).id)
    }
    
    func getCurrentWeekStatusSuccess(currentWeekStatus: CurrentWeekStatus) {
        self.currentWeekStatus = currentWeekStatus
        self.layout.weeksTableView.reloadData()
    }
}

extension ProjectPageVC : ProjectPageLayoutDelegate {
    func retry() {
        
    }
}

extension ProjectPageVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WeekCell = self.layout.weeksTableView.dequeueReusableCell(withIdentifier: WeekCell.identifier, for: indexPath) as! WeekCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.index = indexPath.row
        cell.week = weeks.get(at: indexPath.row)!
        cell.isWorkingOn = getIsWorkingOn(week: weeks.get(at: indexPath.row)!)
        if cell.isWorkingOn {
            cell.currentWeekStatus = self.currentWeekStatus
        }
        cell.isOpened = getIsOpened(week: weeks.get(at: indexPath.row)!)
        cell.setupViews()
        cell.populateCellData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15)
    }
}

extension ProjectPageVC: WeekCellDelegate {
    func weekCellClicked(index: Int) {
        
    }
}
