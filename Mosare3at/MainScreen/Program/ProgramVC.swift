//
//  ProgramVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SideMenu
import Localize_Swift
import SwiftyUserDefaults

class ProgramVC: BaseVC, UISideMenuNavigationControllerDelegate {
    
    var layout: ProgramLayout!
    var presenter: ProgramPresenter!
    let user = User.getInstance(dictionary: Defaults[.user]!)
    var weekDeliverables: [WeekDeliverable] = []
    
    var subscription: Subscribtion!
    
    static func buildVC() -> ProgramVC {
        return ProgramVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = ProgramLayout(superview: self.view, programLayoutDelegate: self)
        layout.setupViews()
        
        layout.programsTableView.dataSource = self
        layout.programsTableView.delegate = self
        
        presenter = Injector.provideProgramPresenter()
        presenter.setView(view: self)
        
        getSubscriptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UiHelpers.setupSideMenu(delegate: self, viewToPresent: self.layout.topView.backImageView, viewToEdge: self.view, sideMenuCellDelegate: self, sideMenuHeaderDelegate: self)
    }
    
    func getSubscriptions() {
        presenter.getSubscriptions(userId: user.id, token: user.token)
    }
    
    func calculateOutput() {
        var doneTasksCount: Int = 0
        for weekDeliverable in weekDeliverables {
            if weekDeliverable.status == CommonConstants.DELIVERABLE_ACCEPTED || weekDeliverable.status == CommonConstants.DELIVERABLE_DELIVERED {
                doneTasksCount = doneTasksCount + 1
            }
        }
        
        Singleton.getInstance().sideMenuDoneTasksCount = doneTasksCount
        Singleton.getInstance().sideMenuTotalTasksCount = weekDeliverables.count
    }
    
    func getMilestoneName(weight: Int) -> String {
        switch (weight) {
            
        case 1:
            return "الخطوة الأولي"
            
        case 2:
            return "الخطوة الثانية"
            
        case 3:
            return "الخطوة الثالثة"
            
        case 4:
            return "الخطوة الرابعة"
            
        case 5:
            return "الخطوة الخامسة"
            
        case 6:
            return "الخطوة السادسة"
            
        case 7:
            return "الخطوة السابعة"
            
        case 8:
            return "الخطوة الثامنة"
            
            
        default:
            return "الخطوة الأولي"
            
        }
    }
    
    func getProgetTitle(weight: Int) -> String {
        switch (weight) {
            
        case 1:
            return "الاسبوع الأول"
        case 2:
            return "الاسبوع الثاني"
        case 3:
            return "الاسبوع الثالث"
        case 4:
            return "الاسبوع الرابع"
        case 5:
            return "الاسبوع الخامس"
        case 6:
            return "الاسبوع السادس"
        case 7:
            return "الاسبوع السابع"
        case 8:
            return "الاسبوع الثامن"
            
        default:
            return "الاسبوع الأول"
        }
    }
}

extension ProgramVC: SideMenuHeaderDelegate {
    func headerClicked() {
        print("program :: header clicked")
    }
}

extension ProgramVC: SideMenuCellDelegate {
    func sideMenuItemSelected(index: Int) {
        print("program :: item \(index) clicked")
    }
}

extension ProgramVC : ProgramLayoutDelegate {
    func openSideMenu() {
        if Localize.currentLanguage() == "en" {
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        } else {
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
        
    }
    
    func retry() {
        
    }
}

extension ProgramVC : ProgramView {
    func opetaionFailed(message: String) {
        self.view.makeToast(message, duration: 2, position: .center)
    }
    
    func getSubscriptionsSuccess(subscriptionsResponse: SubscribtionsResponse) {
        
        self.subscription = subscriptionsResponse.hydraMember.get(at: 0)!
        
        print("subscription.id :: \(subscription.id)")
        self.layout.programsTableView.reloadData()
        Defaults[.subscriptionId] = subscription.id
        Defaults[.currentWeek] = subscription.week.convertToDictionary()
        presenter.getTeamId(projectId: subscription.project.requestId, userId: user.id, token: user.token)
    }
    
    func getTeamIdSuccess(teamId: String, teamMemberId: String) {
        print("teamId :: \(teamId)")
        print("teamMemberId :: \(teamMemberId)")
        Defaults[.teamId] = teamId
        Defaults[.teamMemberId] = teamMemberId
        let teamIdInt : Int = Int(teamId.components(separatedBy: "/")[teamId.components(separatedBy: "/").count - 1])!
        presenter.getTeam(teamId: teamIdInt, token: user.token)
    }
    
    func getTeamSuccess(team: Team) {
        print("team :: \(team)")
        
        
        presenter.getWeekDeliverables(parameters: ["teamMember":"\(Defaults[.teamMemberId]!)", "week":"\(subscription.week.id!)"], token: user.token)
        
        presenter.getWeekDeliverables(parameters: ["team":"\(Defaults[.teamId]!)", "week":"\(subscription.week.id!)"], token: user.token)
    }
    
    func getWeekDeliverableSuccess(weekDeliverableResponse: WeekDeliverableResponse) {
        self.weekDeliverables.append(contentsOf: weekDeliverableResponse.hydraMember)
        calculateOutput()
    }
    
    
}

extension ProgramVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.subscription != nil {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell:ProgramTopCell = self.layout.programsTableView.dequeueReusableCell(withIdentifier: ProgramTopCell.identifier, for: indexPath) as! ProgramTopCell
            cell.selectionStyle = .none
            cell.setupViews()
            cell.delegate = self
            let milestoneName = self.getMilestoneName(weight: self.subscription.milestone.weight)
            let milestoneNumber = "\(self.subscription.week.weight!).\(self.subscription.milestone.weight!)"
            
            let projectTitle = "\(self.getProgetTitle(weight: self.subscription.week.weight)) \("from".localized()) \(self.subscription.project.title!)"
            
            cell.populateData(programName: self.subscription.program.title, programPhotoUrl: self.subscription.program.bgImage, milestoneName: milestoneName, projectTitle: projectTitle, milestoneNumber: milestoneNumber, taskName: self.subscription.milestone.title)
            return cell
        } else {
//            return UITableViewCell()
            let cell:ProgramBottomCell = self.layout.programsTableView.dequeueReusableCell(withIdentifier: ProgramBottomCell.identifier, for: indexPath) as! ProgramBottomCell
            let programId = self.subscription.program.requestId.components(separatedBy: "/").get(at: self.subscription.program.requestId.components(separatedBy: "/").count - 1)
            cell.programId = Int(programId!)
            cell.selectionStyle = .none
            addChild(cell.vc)
            cell.setupViews()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 90)
    }
}

extension ProgramVC : TopCellDelegate {
    func startNow() {
        
    }
    
    func scrollToBottom() {
        let indexPath = IndexPath(row: 1, section: 0)
        self.layout.programsTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}
