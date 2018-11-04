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
            var count = 0
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
        label.font = AppFont.font(type: .Bold, size: 15)
        return label
    }()
    
    lazy var wrongAnswerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.red
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 15)
        return label
    }()
    
    public func setupViews() {
        let views = [questionLabel, pointsLabel, answersTableView, answerTheQuestionButton, rightAnswerLabel, wrongAnswerLabel]
    }
    
}

extension QuestionCell: AnswerCellDelegate {
    func answerSelected(index: Int) {
        self.question.choices.get(at: index)?.isSelected = true
        for choice in question.choices {
            choice.isSelected = false
        }
        self.answersTableView.reloadData()
    }
}
