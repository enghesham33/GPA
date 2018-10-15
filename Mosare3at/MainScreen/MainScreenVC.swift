//
//  MainProgramScreenVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit


class MainScreenVC: UITabBarController {
    
    var programTabBarItem: UITabBarItem!
    var dashboardTabBarItem: UITabBarItem!
    var teamTabBarItem: UITabBarItem!
    var scheduleTabBarItem: UITabBarItem!
    
    var programVC: ProgramVC!
    var dashboardVC:DashboardVC!
    var teamVC: TeamVC!
    var scheduleVC: ScheduleVC!

    private var selectedTab = 0
    
    static func buildVC() -> MainScreenVC {
        return MainScreenVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isHidden = true
        setupTabBarItems()
    }
    
    func setupTabBarItems() {
        
        programVC = ProgramVC.buildVC()
        dashboardVC = DashboardVC.buildVC()
        teamVC = TeamVC.buildVC()
        scheduleVC = ScheduleVC.buildVC()
        
        programTabBarItem = UITabBarItem(title: "program".localized(), image: UIImage(named: "program_deselcted")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "program_selected")?.withRenderingMode(.alwaysOriginal))
        programVC.tabBarItem = programTabBarItem
        
        dashboardTabBarItem = UITabBarItem(title: "dashboard".localized(), image: UIImage(named: "program_deselcted")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "program_selected")?.withRenderingMode(.alwaysOriginal))
        dashboardVC.tabBarItem = dashboardTabBarItem

        teamTabBarItem = UITabBarItem(title: "team".localized(), image: UIImage(named: "program_deselcted")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "program_selected")?.withRenderingMode(.alwaysOriginal))
        teamVC.tabBarItem = teamTabBarItem

        scheduleTabBarItem = UITabBarItem(title: "schedule".localized(), image: UIImage(named: "program_deselcted")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "program_selected")?.withRenderingMode(.alwaysOriginal))
        scheduleVC.tabBarItem = scheduleTabBarItem
        
        self.viewControllers = [programVC , dashboardVC , teamVC , scheduleVC]

        

    }
    
    
}


