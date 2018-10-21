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
        
        Defaults[.currentWeek] = team.currentWeek.convertToDictionary()
        presenter.getWeekDeliverables(parameters: ["teamMember":"\(Defaults[.teamMemberId]!)", "week":"\(team.currentWeek.id!)"], token: user.token)
        presenter.getWeekDeliverables(parameters: ["team":"\(Defaults[.teamId]!)", "week":"\(team.currentWeek.id!)"], token: user.token)
    }
    
    func getWeekDeliverableSuccess(weekDeliverableResponse: WeekDeliverableResponse) {
        self.weekDeliverables.append(contentsOf: weekDeliverableResponse.hydraMember)
        calculateOutput()
    }
    
    
}

extension ProgramVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.subscription != nil {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell:ProgramTopCell = self.layout.programsTableView.dequeueReusableCell(withIdentifier: ProgramTopCell.identifier, for: indexPath) as! ProgramTopCell
            cell.selectionStyle = .none
            cell.setupViews()
            cell.delegate = self
            var milestoneName = ""
            let milestoneNumber = "\(self.subscription.week.weight!).\(self.subscription.milestone.weight!)"
            
            switch (self.subscription.milestone.weight) {
                
            case 1:
                milestoneName = "الخطوة الأولي"
                break
                
            case 2:
                milestoneName = "الخطوة الثانية"
                break
            case 3:
                milestoneName = "الخطوة الثالثة"
                break
            case 4:
                milestoneName = "الخطوة الرابعة"
                break
            case 5:
                milestoneName = "الخطوة الخامسة"
                break
            case 6:
                milestoneName = "الخطوة السادسة"
                break
            case 7:
                milestoneName = "الخطوة السابعة"
                break
            case 8:
                milestoneName = "الخطوة الثامنة"
                break
                
            default:
                milestoneName = "الخطوة الأولي"
                break
            }
            
            var projectTitle = ""
            
            switch (self.subscription.week.weight) {
                
            case 1:
                projectTitle = "الاسبوع الأول"
                break
                
            case 2:
                projectTitle = "الاسبوع الثاني"
                break
            case 3:
                projectTitle = "الاسبوع الثالث"
                break
            case 4:
                projectTitle = "الاسبوع الرابع"
                break
            case 5:
                projectTitle = "الاسبوع الخامس"
                break
            case 6:
                projectTitle = "الاسبوع السادس"
                break
            case 7:
                projectTitle = "الاسبوع السابع"
                break
            case 8:
                projectTitle = "الاسبوع الثامن"
                break
                
            default:
                break
            }
            
            projectTitle = "\(projectTitle) \("from".localized()) \(self.subscription.project.title!)"
            
            cell.populateData(programName: self.subscription.program.title, programPhotoUrl: self.subscription.program.bgImage, milestoneName: milestoneName, projectTitle: projectTitle, milestoneNumber: milestoneNumber, taskName: self.subscription.milestone.title)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ProgramVC : TopCellDelegate {
    func startNow() {
        
    }
    
    func scrollToBottom() {
        
    }
    
    
}
