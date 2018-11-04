//
//  MilestonesVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/4/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class MilestonesVC: BaseVC {

    var weekMaterial: WeekMaterial!
    var project: Project!
    var week: Week!
    var currentMilestone: Milestone!
    var milestones: [Milestone]!
    
    var layout: MilestonesLayout!
    var presenter: MilestonePresenter!
    
    public static func buildVC(weekMaterial: WeekMaterial, project: Project, week: Week, currentMilestone: Milestone) -> MilestonesVC {
        let vc = MilestonesVC()
        vc.weekMaterial = weekMaterial
        vc.week = week
        vc.project = project
        vc.currentMilestone = currentMilestone
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenTitle = "\("milestone".localized()) \(self.week.weight!).\(self.currentMilestone.weight!)"
        
        layout = MilestonesLayout(superview: self.view, milestonesLayoutDelegate: self, screenTitle: screenTitle)
        layout.setupViews()
        setupTableView()
        
        presenter = Injector.provideMilestonesPresenter()
        presenter.setView(view: self)
        presenter.getMilestones(weekMaterialId: self.weekMaterial.id)
    }
    
    func setupTableView() {
        self.layout.milestonesTableView.dataSource = self
        self.layout.milestonesTableView.delegate = self
    }
}

extension MilestonesVC: MilestonesLayoutDelegate {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func goNextPageMilestone() {
        
    }
    
    func goPreviousMilestone() {
        
    }
    
    func retry() {
        
    }
}

extension MilestonesVC: MilestoneView {
    func updateUserAnswerSuccess(userAnswer: UserAnswer) {
        
    }
    
    func opetaionFailed(message: String) {
        self.view.makeToast(message)
    }
    
    func getMilestonesSuccess(milestones: [Milestone]) {
        self.milestones = milestones
    }
    
    func getUserAnswersSuccess(userAnswers: [UserAnswer]) {
        
    }
}

extension MilestonesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MilestonesCell = self.layout.milestonesTableView.dequeueReusableCell(withIdentifier: MilestonesCell.identifier, for: indexPath) as! MilestonesCell
        cell.selectionStyle = .none
        
        cell.milestone = currentMilestone
        cell.tasksNumber = currentMilestone.tasks.count
        cell.delegate = self
        
        return cell
    }
    
    
}

extension MilestonesVC: MilestonesCellDelegate {
    func answerTheQuestion(answerIndex: Int, questionIndex: Int) {
        let userId = User.getInstance(dictionary: Defaults[.user]!).id
        self.presenter.updateUserAnswers(userId: userId!, projectId: self.project.id, weekId: self.week.id, milestoneId: self.currentMilestone.id, questionId: self.currentMilestone.questions.get(at: questionIndex)!.id, userChoice: answerIndex)
    }
}
