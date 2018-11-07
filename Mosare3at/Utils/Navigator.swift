//
//  Navigator.swift
//  Mosare3at
//
//  Created by Hesham Donia on 9/30/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public class Navigator {
    
    var navigationController: UINavigationController!
    
    public init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    public func navigateToLogin() {
        let vc = LoginVC.buildVC()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func navigateToForgetPassword() {
        let vc = ForgetPasswordVC.buildVC()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func navigateToTutorial() {
        let vc = TutorialPagerVC.buildVC()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func navigateToChooseAvatar() {
        let vc = ChooseAvatarVC.buildVC()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func navigateToJoinSuccess() {
        let vc = JoinSuccessVC.buildVC()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func navigateToMainScreen() {
        let vc = MainScreenVC.buildVC()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func navigateToWeekDetailsScreen(screenTitle: String, weekTitle: String, week: Week, project: Project, isWorkingOn: Bool) {
        let vc = WeekDetailsVC.buildVC(screenTitle: screenTitle, weekTitle: weekTitle, week: week, project: project, isWorkingOn: isWorkingOn)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func navigateToWeekVisionScreen(weekMaterial: WeekMaterial, project: Project, week: Week) {
        let vc = WeekVisionVC.buildVC(weekMaterial: weekMaterial, project: project, week: week)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func navigateToMilestonesScreen(weekMaterial: WeekMaterial, project: Project, week: Week, clickedMilestone: Milestone, currentMilestoneIndex: Int) {
        let vc = MilestonesVC.buildVC(weekMaterial: weekMaterial, project: project, week: week, currentMilestone: clickedMilestone, currentMilestoneIndex: currentMilestoneIndex)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func navigateToDeliverableDetailsScreen(week: Week, deliverable: Deliverable) {
        let vc = DeliverableDetailsVC.buildVC(week: week, deliverable: deliverable)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
