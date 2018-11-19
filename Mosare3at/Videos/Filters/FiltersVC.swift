//
//  FiltersVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/19/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import DropDown

public protocol FiltersDelegate: class {
    func applyFilters(selectedProgramIndex: Int, selectedProjectIndex: Int, selectedTeamIndex: Int, selectedOrderIndex: Int)
}

class FiltersVC: BaseVC {

    var delegate: FiltersDelegate!
    
    var programs: [Program]!
    var selectedProgramIndex: Int = 0
    
    var projects: [Project]!
//    var filteredProjects: [Project]!
    var selectedProjectIndex: Int = 0
    
    var teams: [Team]!
//    var filteredTeams: [Team]!
    var selectedTeamIndex: Int = 0
    
    var orders: [String] = ["asc".localized(), "desc".localized()]
    var selectedOrderIndex: Int = 0
    
    var layout: FiltersLayout!
    
    public static func buildVC() -> FiltersVC {
        let vc = FiltersVC()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = FiltersLayout(superview: self.view, delegate: self)
        layout.setupViews()
        
        setupProgramsDropDown()
        setupProjectsDropDown()
        setupOrderDropDown()
        setupTeamsDropDown()
    }
    
    func setupProgramsDropDown() {
        let dropDown = DropDown()
        dropDown.anchorView = self.layout.programTextField
        dropDown.bottomOffset = CGPoint(x: 0, y: self.layout.programTextField.bounds.height)
        var dataSource = [String]()
        for program in programs {
            dataSource.append(program.title)
        }
        dropDown.dataSource = dataSource
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedProgramIndex = index
            self.layout.programTextField.text = self.programs.get(at: self.selectedProgramIndex)?.title
        }
        dropDown.show()
    }
    
    func setupProjectsDropDown() {
        let dropDown = DropDown()
        dropDown.anchorView = self.layout.projectTextField
        dropDown.bottomOffset = CGPoint(x: 0, y: self.layout.projectTextField.bounds.height)
        
        var dataSource = ["allProjects".localized()]
        for project in projects {
            dataSource.append(project.title)
        }
        
        dropDown.dataSource = dataSource
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedProjectIndex = index - 1
            self.layout.projectTextField.text = self.projects.get(at: self.selectedProjectIndex)?.title
        }
        dropDown.show()
    }
    
    func setupOrderDropDown() {
        let dropDown = DropDown()
        dropDown.anchorView = self.layout.orderTextField
        dropDown.bottomOffset = CGPoint(x: 0, y: self.layout.orderTextField.bounds.height)
        dropDown.dataSource = orders
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedOrderIndex = index
            self.layout.orderTextField.text = self.orders.get(at: self.selectedOrderIndex)!
        }
        dropDown.show()
    }
    
    func setupTeamsDropDown() {
         let dropDown = DropDown()
        dropDown.anchorView = self.layout.teamTextField
        dropDown.bottomOffset = CGPoint(x: 0, y: self.layout.teamTextField.bounds.height)
        var dataSource = ["allTeams".localized()]
        for team in teams {
            dataSource.append(team.name)
        }
        
        dropDown.dataSource = dataSource
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedTeamIndex = index - 1
            self.layout.teamTextField.text = self.teams.get(at: self.selectedProjectIndex)?.name
        }
         dropDown.show()
    }

}

extension FiltersVC: FiltersLayoutDelegate {
    func applyFilters() {
        self.delegate.applyFilters(selectedProgramIndex: self.selectedProgramIndex, selectedProjectIndex: self.selectedProjectIndex, selectedTeamIndex: self.selectedTeamIndex, selectedOrderIndex: self.selectedOrderIndex)
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
