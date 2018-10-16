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
    
    static func buildVC() -> ProgramVC {
        return ProgramVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = ProgramLayout(superview: self.view, programLayoutDelegate: self)
        layout.setupViews()
        
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
        
        let subscription: Subscribtion = subscriptionsResponse.hydraMember.get(at: 0)!
        
        print("subscription.id :: \(subscription.id)")
        
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
