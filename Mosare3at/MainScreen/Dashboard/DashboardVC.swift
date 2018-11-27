//
//  DashboardVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SideMenu
import Localize_Swift
import SwiftyUserDefaults
import EzPopup

class DashboardVC: BaseVC, UISideMenuNavigationControllerDelegate {
    
    var layout : DashboardLayout!
    var sideMenuVC: SideMenuVC!
    
    var user: User!
    var userInfo: UserInfo!
    var myTeamMembers: [TeamMember]!
    var allMembers: [TeamMember]!
    var allTeams: [Team]!
    
    var presenter: DashboardPresenter!
    
    static func buildVC() -> DashboardVC {
        return DashboardVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout = DashboardLayout(superview: self.view, dashboardLayoutDelegate: self)
        layout.setupViews()
        user = User.getInstance(dictionary: Defaults[.user]!)
        presenter = Injector.provideDashboardPresenter()
        presenter.setView(view: self)
        presenter.getUser(userId: user.id)
        
        if AppDelegate.instance.unreadNotificationsNumber > 0 {
            self.layout.topView.notificationsNumberLabel.isHidden = false
            self.layout.topView.notificationsNumberLabel.text = "\(AppDelegate.instance.unreadNotificationsNumber)"
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: CommonConstants.NOTIFICATIONS_UPDATED),
                                               object: self,
                                               queue: OperationQueue.main,
                                               using: notificationsUpdated(noti:))
    }
    
    func notificationsUpdated(noti: Notification) {
        self.layout.topView.notificationsNumberLabel.text = "\(AppDelegate.instance.unreadNotificationsNumber)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
         sideMenuVC = UiHelpers.setupSideMenu(delegate: self, viewToPresent: self.layout.topView.backImageView, viewToEdge: self.view, sideMenuCellDelegate: self, sideMenuHeaderDelegate: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func calculateCellHeight(selection: Int) {
        var height:CGFloat = 0.0
        
        switch selection {
        case 0:
            height = CGFloat(myTeamMembers.count) * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 12)
            break
            
        case 1:
            height = CGFloat(allMembers.count) *  UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 12)
            break
            
        case 2:
            height = CGFloat(allTeams.count) * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 12)
            break
            
        default:
            break
        }
        
        DashboardCell.cellHeight = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 70) + height
    }
}

extension DashboardVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DashboardCell = self.layout.dashboardTableView.dequeueReusableCell(withIdentifier: DashboardCell.identifier, for: indexPath) as! DashboardCell
        
        cell.selectionStyle = .none
        
        cell.user = user
        cell.userInfo = userInfo
        cell.myTeamMembers = myTeamMembers
        cell.allMembers = allMembers
        cell.allTeams = allTeams
        cell.delegate = self
        cell.setupViews()
        cell.populateData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DashboardCell.cellHeight
    }
}

extension DashboardVC: DashboardCellDelegate {
    
    func refreshTableViewHeight(selection: Int) {
        calculateCellHeight(selection: selection)
        layout.dashboardTableView.reloadData()
    }
    
    func openMyProfile() {
        self.navigator.navigateToMyProfile()
    }
    
    func openBadgeDialog(badge: Badge) {
        let vc = PopupDialogVC.buildVC()
        vc.badge = badge
        let popupVC = PopupViewController(contentController: vc, popupWidth: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 90), popupHeight: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 70))
        present(popupVC, animated: true)
    }
    
    func openAllBadges() {
        self.navigationController?.presentVC(AllBadgesVC.buildVC(badges: Singleton.getInstance().badges))
    }
    
    func goToMyTeam(index: Int) {
        
    }
    
    func goToMemberDetails(index: Int, isTeamMate: Bool) {
        var member: TeamMember!
        if isTeamMate {
            member = myTeamMembers.get(at: index)!
        } else {
            member = allMembers.get(at: index)!
        }
        self.navigator.navigateToMemberDetails(member: member, isTeamMate: isTeamMate)
    }
    
    func goToTeamDetails(index: Int) {
        
    }
}

extension DashboardVC: DashboardView {
    func opetaionFailed(message: String) {
        self.view.makeToast(message, duration: 2, position: .center)
    }
    
    func getUserSuccess(user: User) {
        self.user = user
        Defaults[.user] = user.convertToDictionary()
        if Singleton.getInstance().badges != nil && Singleton.getInstance().badges.count > 0 {
             presenter.getUserInfo()
        } else {
            presenter.getBadges()
        }
    }
    
    func getBadgesSuccess(badges: [Badge]) {
        Singleton.getInstance().badges = badges
        presenter.getUserInfo()
    }
    
    func getUserInfoSuccess(userInfo: UserInfo) {
        self.userInfo = userInfo
        presenter.getTeamMembers(teamId: userInfo.currentTeamId)
    }
    
    func getTeamMembersSuccess(members: [TeamMember]) {
        myTeamMembers = members
        for count in 0...myTeamMembers.count {
            myTeamMembers.get(at: count)?.rank = count + 1
        }
        presenter.getAllMembers()
    }
    
    func getAllMembersSuccess(members: [TeamMember]) {
        allMembers = members
        for count in 0...allMembers.count {
            allMembers.get(at: count)?.rank = count + 1
        }
        presenter.getAllTeams()
    }
    
    func getAllTeamsSuccess(teams: [Team]) {
        self.allTeams = teams
        for count in 0...allTeams.count {
            allTeams.get(at: count)?.rank = count + 1
        }
        
        calculateCellHeight(selection: 0)
        layout.dashboardTableView.dataSource = self
        layout.dashboardTableView.delegate = self
        self.layout.dashboardTableView.reloadData()
    }
    
    
}

extension DashboardVC: SideMenuHeaderDelegate {
    func headerClicked() {
        sideMenuVC.closeSideMenu()
        self.navigator = Navigator(navController: self.navigationController!)
        self.navigator.navigateToMyProfile()
    }
}

extension DashboardVC: SideMenuCellDelegate {
    func sideMenuItemSelected(index: Int) {
        sideMenuVC.closeSideMenu()
        self.navigator = Navigator(navController: self.navigationController!)
        switch index {
        case 0:
            self.navigator.navigateToMyProfile()
            break
            
        case 1:
            self.navigator.navigateToVideos()
            break
            
        case 2:
            self.navigator.navigateToGameMethodology()
            break
            
        case 3:
            self.navigator.navigateToTerms()
            break
            
        case 4:
            self.navigator.navigateToSettings()
            break
            
        default:
            break
        }
         print("dashboard :: item \(index) clicked")
    }
}

extension DashboardVC : DashboardLayoutDelegate {
    func goToNotificationsScreen() {
        self.navigator = Navigator(navController: self.navigationController!)
        self.navigator.navigateToNotifications()
    }
    
    func retry() {
        
    }
    
    func openSideMenu() {
        if Localize.currentLanguage() == "en" {
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        } else {
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
        
    }
}
