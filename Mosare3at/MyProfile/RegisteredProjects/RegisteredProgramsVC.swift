//
//  RegisteredProgramsVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/20/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

class RegisteredProgramsVC: BaseVC {

    var programs: [RegisteredProgram]!
    
    var layout: RegisteredProgramsLayout!
    
    public static func buildVC(programs: [RegisteredProgram]) -> RegisteredProgramsVC {
        let vc = RegisteredProgramsVC()
        vc.programs = programs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = RegisteredProgramsLayout(superview: self.view, delegate: self)
        layout.setupViews()
        
        layout.programsTableView.dataSource = self
        layout.programsTableView.delegate = self
        layout.programsTableView.reloadData()
    }
    
    
}

extension RegisteredProgramsVC: RegisteredProgramsLayoutDelegate {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension RegisteredProgramsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RegisteredProgramCell = layout.programsTableView.dequeueReusableCell(withIdentifier: RegisteredProgramCell.identifier, for: indexPath) as! RegisteredProgramCell
        
        cell.selectionStyle = .none
        
        cell.program = self.programs.get(at: indexPath.row)!
        cell.setupViews()
        cell.populateData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0.0
        
        for program in programs {
            height = height + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30) + CGFloat(program.projects.count) * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15)
        }
        
        return height
    }
}

