//
//  MilestonesCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/4/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift

public protocol MilestonesCellDelegate: class {
    func answerTheQuestion(answerIndex: Int, questionIndex: Int)
}

class MilestonesCell: UITableViewCell {

    public static let identifier = "MilestonesCell"
    public var delegate: MilestonesCellDelegate!
    
    var superView: UIView!
    var tasksNumber: Int = 0
    var milestone: Milestone!
    
    lazy var milestoneNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
          label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    lazy var tasksView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        return view
    }()
    
    lazy var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = false
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        return tableView
    }()
    
    lazy var questionsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        return view
    }()
    
    lazy var questionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = false
        tableView.register(QuestionCell.self, forCellReuseIdentifier: QuestionCell.identifier)
        return tableView
    }()
    
    public func setupViews() {
        let views = [milestoneNameLabel, tasksView, tasksTableView, questionsView, questionsTableView]
        
        superView = self.contentView
        
        superView.addSubviews(views)
        
        milestoneNameLabel.snp.makeConstraints { (maker) in
            maker.leading.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        tasksView.snp.remakeConstraints { (maker) in
            maker.top.equalTo(milestoneNameLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 8) * CGFloat(tasksNumber) + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        tasksView.addSubview(tasksTableView)
        tasksTableView.snp.remakeConstraints { (maker) in
            maker.top.equalTo(tasksView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(tasksView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(tasksView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9) * CGFloat(tasksNumber))
        }
        
        questionsView.snp.remakeConstraints { (maker) in
            maker.top.equalTo(tasksView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
            if milestone.questions != nil {
                maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 61) * CGFloat(milestone.questions.count))
            }
        }
        
        self.questionsView.addSubview(questionsTableView)
        questionsTableView.snp.remakeConstraints { (maker) in
            maker.top.equalTo(questionsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(questionsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(questionsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            if milestone.questions != nil {
                 maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 60) * CGFloat(milestone.questions.count))
            }
           
        }
    }
    
    func calculateQuestionsTableHeight() -> CGFloat {
        var height: CGFloat = 0.0
        if milestone.questions != nil {
            for question in milestone.questions {
                height = height + question.question.heightOfString(usingFont: AppFont.font(type: .Bold, size: 18))
                if question.choices != nil {
                    for answer in question.choices {
                        height = height + answer.answer.heightOfString(usingFont: AppFont.font(type: .Regular, size: 18))
                    }
                }
            }
        }
        
        height = height + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10)
        return height
    }
    
    public func populateData() {
        
        milestoneNameLabel.text = milestone.title
        
        self.tasksTableView.dataSource = self
        self.tasksTableView.delegate = self
        self.tasksTableView.reloadData()
        
        self.questionsTableView.dataSource = self
        self.questionsTableView.delegate = self
        self.questionsTableView.reloadData()
    }
}

extension MilestonesCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tasksTableView {
            return tasksNumber
        } else {
            if milestone.questions != nil {
                return milestone.questions.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tasksTableView {
            let cell:TaskCell = tasksTableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
            cell.selectionStyle = .none
            cell.setupViews()
            cell.populateCustomData(index: indexPath.row + 1, taskString: milestone.tasks.get(at: indexPath.row)!)
            return cell
        } else {
            let cell:QuestionCell = questionsTableView.dequeueReusableCell(withIdentifier: QuestionCell.identifier, for: indexPath) as! QuestionCell
            cell.selectionStyle = .none
            cell.question = self.milestone.questions.get(at: indexPath.row)
            cell.setupViews()
            cell.populateData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor.clear
        let label = UILabel()
        label.textColor = .black
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        if tableView == tasksTableView {
            label.text = "tasksNeeded".localized()
        } else {
            label.text = "answerThefollowing".localized()
        }
        
        label.font = AppFont.font(type: .Bold, size: 20)
        
        view.addSubview(label)
        
        label.snp.makeConstraints { (maker) in
            maker.leading.equalTo(view).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.trailing.equalTo(view).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.top.bottom.equalTo(view)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == self.tasksTableView {
            return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 8)
        } else {
            return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 60)// + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9) + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3) * CGFloat(tasksNumber) + calculateQuestionsTableHeight() + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9) + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10) // last 10% is for spacing not for components
        }
    }
}

extension MilestonesCell: QuestionCellDelegate {
    func answerTheQuestion(answerIndex: Int, questionIndex: Int) {
        self.delegate.answerTheQuestion(answerIndex: answerIndex, questionIndex: questionIndex)
    }
}
