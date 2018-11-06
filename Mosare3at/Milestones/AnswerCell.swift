//
//  AnswerCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/4/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

public protocol AnswerCellDelegate: class {
    func answerSelected(index: Int)
}

class AnswerCell: UITableViewCell {

    static let identifier = "AnswerCell"
    var superView: UIView!
    
    var delegate: AnswerCellDelegate!
    var answer: String!
    var questionType: QuestionType!
    var index: Int!
    
    lazy var choiceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "answer_not_selected")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.font = AppFont.font(type: .Regular, size: 14)
        return label
    }()
    
    public func setupViews() {
        let views = [answerLabel, choiceImageView]
        superView = self.contentView
        superView.addSubviews(views)
        superView.addTapGesture { (_) in
            if self.questionType == QuestionType.NOT_ANSWERED || self.questionType == QuestionType.READY_TO_ANSWER {
                self.delegate.answerSelected(index: self.index)
            }
        }
        
        choiceImageView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(8)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.centerY.equalTo(superView)
        }
        
        answerLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(choiceImageView.snp.trailing).offset(8)
            maker.trailing.equalTo(superView).offset(-8)
            maker.top.bottom.equalTo(superView)
        }
    }
    
    public func populateData(choiceType: ChoiceType) {
        answerLabel.text = answer
        switch choiceType {
        case .NOT_SELECTED:
            choiceImageView.image = UIImage(named: "answer_not_selected")
            answerLabel.textColor = UIColor.AppColors.primaryColor
            break
            
        case .RIGHT_CHOICE:
            choiceImageView.image = UIImage(named: "answer_right")
            answerLabel.textColor = UIColor.AppColors.green
            break
            
        case .WRONG_CHOICE:
            choiceImageView.image = UIImage(named: "answer_wrong")
            answerLabel.textColor = UIColor.AppColors.red
            break
            
        case .SELECTED:
            choiceImageView.image = UIImage(named: "answer_selected")
            answerLabel.textColor = UIColor.AppColors.primaryColor
            break
            
        case .RIGHT_CHOICE_IN_WRONG_QUESTION:
            choiceImageView.image = UIImage(named: "answer_not_selected")?.withRenderingMode(.alwaysOriginal)
            choiceImageView.tintColor = UIColor.AppColors.green
            answerLabel.textColor = UIColor.AppColors.green
            break
        }
    }
}
