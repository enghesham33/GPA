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
    var currentMilestoneIndex: Int!
    var milestones: [Milestone]!
    
    var layout: MilestonesLayout!
    var presenter: MilestonePresenter!
    
    public static func buildVC(weekMaterial: WeekMaterial, project: Project, week: Week, currentMilestone: Milestone, currentMilestoneIndex: Int) -> MilestonesVC {
        let vc = MilestonesVC()
        vc.weekMaterial = weekMaterial
        vc.week = week
        vc.project = project
        vc.currentMilestone = currentMilestone
        vc.currentMilestoneIndex = currentMilestoneIndex
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
        
        applyNextAndPreviousLogic()
    }
    
    func setupTableView() {
        self.layout.milestonesTableView.dataSource = self
        self.layout.milestonesTableView.delegate = self
    }
    
    func applyNextAndPreviousLogic() {
        let firstWeight = weekMaterial.milestones.get(at: 0)?.weight
        let lastWight = weekMaterial.milestones.get(at: weekMaterial.milestones.count - 1)?.weight
        let currentWeight = currentMilestone.weight!
        
        if self.currentMilestone.questions != nil {
            
            if currentWeight > firstWeight! && currentWeight < lastWight! {
                // enable next
                self.layout.nextLabel.textColor = UIColor.AppColors.primaryColor
                self.layout.nextWeightLabel.isHidden = false
                self.layout.nextArrowsImageView.tintColor = UIColor.AppColors.darkRed
                self.layout.nextView.isUserInteractionEnabled = true
                
                // enable prev
                self.layout.previousLabel.textColor = UIColor.AppColors.primaryColor
                self.layout.previousWeightLabel.isHidden = false
                self.layout.previousArrowsImageView.tintColor = UIColor.AppColors.darkRed
                self.layout.previousView.isUserInteractionEnabled = true
                
            } else if currentWeight == firstWeight {
                // disable prev
                self.layout.previousLabel.textColor = UIColor.AppColors.gray
                self.layout.previousWeightLabel.isHidden = true
                self.layout.previousArrowsImageView.tintColor = UIColor.AppColors.gray
                self.layout.previousView.isUserInteractionEnabled = false
                
                // enable next
                self.layout.nextLabel.textColor = UIColor.AppColors.primaryColor
                self.layout.nextWeightLabel.isHidden = false
                self.layout.nextArrowsImageView.tintColor = UIColor.AppColors.darkRed
                self.layout.nextView.isUserInteractionEnabled = true
                
            } else if currentWeight == lastWight {
                // disable next
                self.layout.nextLabel.textColor = UIColor.AppColors.primaryColor
                self.layout.nextWeightLabel.isHidden = true
                self.layout.nextArrowsImageView.isHidden = true
                self.layout.nextLabel.text = "rateTeam".localized()
                self.layout.nextView.isUserInteractionEnabled = true
                self.layout.nextView.addTapGesture { (_) in
                    // go to team rate
                    print("go to team rate")
                    self.navigator.navigateToTeamRating(week: self.week)
                }
                // enable prev
                self.layout.previousLabel.textColor = UIColor.AppColors.primaryColor
                self.layout.previousWeightLabel.isHidden = false
                self.layout.previousArrowsImageView.tintColor = UIColor.AppColors.darkRed
                self.layout.previousView.isUserInteractionEnabled = true
            }
            populateNextAndPrevWeightData()
        }
    }
    
    func populateNextAndPrevWeightData() {
        if !self.layout.previousWeightLabel.isHidden {
            self.layout.previousWeightLabel.text = "\(self.week.weight!).\(self.milestones[self.currentMilestoneIndex - 1].weight!)"
        }
        
        if !self.layout.nextWeightLabel.isHidden {
            self.layout.nextWeightLabel.text = "\(self.week.weight!).\(self.milestones[self.currentMilestoneIndex + 1].weight!)"
        }
    }
}

extension MilestonesVC: MilestonesLayoutDelegate {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.layout.milestonesTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func goNextPageMilestone() {
        if self.milestones != nil {
            self.currentMilestone = self.milestones.get(at: self.currentMilestoneIndex + 1)!
            self.currentMilestoneIndex = self.currentMilestoneIndex + 1
            self.layout.setupTopView(screenTitle: "\("milestone".localized()) \(self.week.weight!).\(self.currentMilestone.weight!)")
            for question in self.currentMilestone.questions {
                self.presenter.getUserAnswers(userId: User.getInstance(dictionary: Defaults[.user]!).id, projectId: self.project.id, weekId: self.week.id, milestoneId: self.currentMilestone.id, questionId: question.id)
            }
            applyNextAndPreviousLogic()
            scrollToFirstRow()
        }
    }
    
    func goPreviousMilestone() {
         if self.milestones != nil {
            self.currentMilestone = self.milestones.get(at: self.currentMilestoneIndex - 1)!
            self.currentMilestoneIndex = self.currentMilestoneIndex - 1
            self.layout.setupTopView(screenTitle: "\("milestone".localized()) \(self.week.weight!).\(self.currentMilestone.weight!)")
            for question in self.currentMilestone.questions {
                self.presenter.getUserAnswers(userId: User.getInstance(dictionary: Defaults[.user]!).id, projectId: self.project.id, weekId: self.week.id, milestoneId: self.currentMilestone.id, questionId: question.id)
            }
            applyNextAndPreviousLogic()
            scrollToFirstRow()
        }
    }
    
    func retry() {
        
    }
}

extension MilestonesVC: MilestoneView {
    func updateUserAnswerSuccess(userAnswer: UserAnswer) {
        for question in currentMilestone.questions {
            if "/questions/\(question.id!)" == userAnswer.question {
                if question.rightChoice == userAnswer.userChoice {
                    // right answer
                    question.questionType = QuestionType.RIGHT_ANSWER
                    
                    for count in 0...question.choices.count - 1 {
                        if count == question.rightChoice {
                            question.choices[count].choiceType = ChoiceType.RIGHT_CHOICE
                        } else {
                            question.choices[count].choiceType = ChoiceType.NOT_SELECTED
                        }
                    }
                } else {
                    // wrong answer
                    question.questionType = QuestionType.WRONG_ANSWER
                    
                    for count in 0...question.choices.count - 1 {
                        if count == question.rightChoice {
                            question.choices[count].choiceType = ChoiceType.RIGHT_CHOICE_IN_WRONG_QUESTION
                        } else if count == userAnswer.userChoice {
                            question.choices[count].choiceType = ChoiceType.WRONG_CHOICE
                        } else {
                            question.choices[count].choiceType = ChoiceType.NOT_SELECTED
                        }
                    }
                }
                
                break
            }
        }
        self.layout.milestonesTableView.reloadData()
    }
    
    func opetaionFailed(message: String) {
        self.view.makeToast(message)
    }
    
    func getMilestonesSuccess(milestones: [Milestone]) {
        self.milestones = milestones
        for index in 0...milestones.count - 1 {
            if currentMilestone.id == milestones[index].id {
                self.currentMilestone = milestones[index]
                self.currentMilestoneIndex = index
            }
        }
        applyNextAndPreviousLogic()
        
        for question in self.currentMilestone.questions {
            self.presenter.getUserAnswers(userId: User.getInstance(dictionary: Defaults[.user]!).id, projectId: self.project.id, weekId: self.week.id, milestoneId: self.currentMilestone.id, questionId: question.id)
        }
    }
    
    func getUserAnswersSuccess(userAnswers: [UserAnswer]) {
        if userAnswers.count == 0 {
            for question in currentMilestone.questions {
                question.questionType = QuestionType.NOT_ANSWERED
                for choice in question.choices {
                    choice.choiceType = .NOT_SELECTED
                }
                break
            }
        } else {
            let userAnswer = userAnswers[0]
            for question in currentMilestone.questions {
                if "/questions/\(question.id!)" == userAnswer.question {
                    if question.rightChoice == userAnswer.userChoice {
                        // right answer
                        question.questionType = QuestionType.RIGHT_ANSWER
                        
                        for count in 0...question.choices.count - 1 {
                            if count == question.rightChoice {
                                question.choices[count].choiceType = ChoiceType.RIGHT_CHOICE
                            } else {
                                question.choices[count].choiceType = ChoiceType.NOT_SELECTED
                            }
                        }
                    } else {
                        // wrong answer
                        question.questionType = QuestionType.WRONG_ANSWER
                        
                        for count in 0...question.choices.count - 1 {
                            if count == question.rightChoice {
                                question.choices[count].choiceType = ChoiceType.RIGHT_CHOICE_IN_WRONG_QUESTION
                            } else if count == userAnswer.userChoice {
                                question.choices[count].choiceType = ChoiceType.WRONG_CHOICE
                            } else {
                                question.choices[count].choiceType = ChoiceType.NOT_SELECTED
                            }
                        }
                    }
                    
                    break
                }
            }
        }
        
        self.layout.milestonesTableView.reloadData()
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
        cell.setupViews()
        cell.populateData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 200)
    }
    
}

extension MilestonesVC: MilestonesCellDelegate {
    func answerTheQuestion(answerIndex: Int, questionIndex: Int) {
        let userId = User.getInstance(dictionary: Defaults[.user]!).id
        self.presenter.updateUserAnswers(userId: userId!, projectId: self.project.id, weekId: self.week.id, milestoneId: self.currentMilestone.id, questionId: self.currentMilestone.questions.get(at: questionIndex)!.id, userChoice: answerIndex)
    }
}
