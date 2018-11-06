//
//  QuestionCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/4/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift
import Material

public protocol QuestionCellDelegate: class {
    func answerTheQuestion(answerIndex: Int, questionIndex: Int)
}

class QuestionCell: UITableViewCell {

   public static let identifier = "QuestionCell"

    var isAnswered: Bool!
    var isAnsweredRight: Bool!
    var question: Question!
    var index: Int!
    var delegate: QuestionCellDelegate!
    
    var superView: UIView!
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = AppFont.font(type: .Bold, size: 15)
        return label
    }()
    
    lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.darkRed
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 15)
        return label
    }()
    
    lazy var answersTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(AnswerCell.self, forCellReuseIdentifier: AnswerCell.identifier)
        return tableView
    }()
    
    lazy var answerTheQuestionButton: RaisedButton = {
        let button = RaisedButton(title: "answerTheQuestion".localized(), titleColor: .white)
        button.backgroundColor = UIColor.AppColors.gray
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 18)
        
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 1)
        button.addTapGesture { recognizer in
            var answerIndex: Int = 0
            for count in 0...self.question.choices.count {
                if self.question.choices.get(at: count)!.isSelected {
                    answerIndex = count
                }
            }
            self.delegate.answerTheQuestion(answerIndex: answerIndex, questionIndex: self.index)
        }
        return button
    }()
    
    lazy var rightAnswerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.green
        label.textAlignment = .center
        label.text = "rightAnswer".localized()
        label.font = AppFont.font(type: .Bold, size: 15)
        return label
    }()
    
    lazy var wrongAnswerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.red
        label.textAlignment = .center
        label.text = "wrongAnswer".localized()
        label.font = AppFont.font(type: .Bold, size: 15)
        return label
    }()
    
    public func setupViews() {
        let views = [questionLabel, pointsLabel, answersTableView, answerTheQuestionButton, rightAnswerLabel, wrongAnswerLabel]
        
        self.superView = self.contentView
        
        superView.addSubviews(views)
        questionLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 70))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 25))
        }
        
        pointsLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(questionLabel.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.top.equalTo(questionLabel)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 25))
        }
        
        answersTableView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            if self.question.question.heightOfString(usingFont: questionLabel.font) > UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 25) {
                maker.top.equalTo(questionLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            } else {
                maker.top.equalTo(pointsLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            }
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5) * CGFloat(self.question.choices.count))
        }
        
        answersTableView.dataSource = self
        answersTableView.delegate = self
        
        answerTheQuestionButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(answersTableView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10) * -1)
        }
        
        rightAnswerLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(answersTableView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10) * -1)
        }
        
        wrongAnswerLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(answersTableView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10) * -1)
        }
        
        superView.bringSubviewToFront(rightAnswerLabel)
        superView.bringSubviewToFront(wrongAnswerLabel)
    }
    
    public func populateData() {
        
        questionLabel.text = question.question
        pointsLabel.text = "\(question.points!) \("points".localized())"
        answersTableView.reloadData()
        
            switch question.questionType {
            case .NOT_ANSWERED:
                rightAnswerLabel.isHidden = true
                wrongAnswerLabel.isHidden = true
                answerTheQuestionButton.isHidden = false
                answerTheQuestionButton.backgroundColor = UIColor.AppColors.gray
                answerTheQuestionButton.addTapGesture { (_) in
                    // nothing to do
                }
                break
                
            case .RIGHT_ANSWER:
                rightAnswerLabel.isHidden = false
                wrongAnswerLabel.isHidden = true
                answerTheQuestionButton.isHidden = true
                break
                
            case .WRONG_ANSWER:
                rightAnswerLabel.isHidden = true
                wrongAnswerLabel.isHidden = false
                answerTheQuestionButton.isHidden = true
                break
                
            case .READY_TO_ANSWER:
                rightAnswerLabel.isHidden = true
                wrongAnswerLabel.isHidden = true
                answerTheQuestionButton.isHidden = false
                answerTheQuestionButton.backgroundColor = UIColor.AppColors.darkRed
                answerTheQuestionButton.addTapGesture { (_) in
                    var answerIndex: Int = 0
                    for count in 0...self.question.choices.count - 1 {
                        if self.question.choices.get(at: count)!.isSelected {
                            answerIndex = count
                        }
                    }
                    self.delegate.answerTheQuestion(answerIndex: answerIndex, questionIndex: self.index)
                }
                break
                
        }
    }
}

extension QuestionCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.question.choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AnswerCell = answersTableView.dequeueReusableCell(withIdentifier: AnswerCell.identifier, for: indexPath) as! AnswerCell
        cell.selectionStyle = .none
        cell.answer = self.question.choices.get(at: indexPath.row)!.answer
        cell.index = indexPath.row
        cell.delegate = self
        cell.questionType = self.question.questionType
        cell.setupViews()
        cell.populateData(choiceType: self.question.choices.get(at: indexPath.row)!.choiceType)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5)
    }
}

extension QuestionCell: AnswerCellDelegate {
    func answerSelected(index: Int) {
        self.question.choices.get(at: index)?.choiceType = .SELECTED
        
        for count in 0...question.choices.count - 1 {
            if count != index {
                question.choices[count].choiceType = .NOT_SELECTED
            }
        }
        self.answersTableView.reloadData()
        self.question.questionType = .READY_TO_ANSWER
        self.populateData()
    }
}
