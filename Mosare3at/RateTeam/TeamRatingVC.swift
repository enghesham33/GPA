//
//  TeamRatingVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class TeamRatingVC: BaseVC {
    
    var layout: TeamRatingLayout!
    
    var team: Team!
    var teacherAssistantMarks: [TeacherAssistantMark]!
    var currentTeamMemberIndex: Int = -1 // -1 means the TA is selected
    var presenter: TeamRatingPresenter!
    var week: Week!
    var isTeamRated: Bool = false, isTARated: Bool = false
    
    public static func buildVC(week: Week) -> TeamRatingVC {
        let vc = TeamRatingVC()
        vc.week = week
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = TeamRatingLayout(superview: self.view, teamRatingLayoutDelegate: self)
        layout.setupViews()
        layout.progrssBar.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        layout.progrssBar.value = 5
        self.layout.currentProgressLabel.text = "5/10"
        setupScrollableViews()
        
        presenter = Injector.provideTeamRatingPresenter()
        presenter.setView(view: self)
        let teamRequestId = Defaults[.teamId]!
        presenter.getTeam(teamId: Int(teamRequestId.components(separatedBy: "/")[teamRequestId.components(separatedBy: "/").count - 1])!)
    }
    
    func setupScrollableViews() {
        self.layout.teacherAssistantMarksTableView.dataSource = self
        self.layout.teacherAssistantMarksTableView.delegate = self
        
        self.layout.badgesCollectionView.dataSource = self
        self.layout.badgesCollectionView.delegate = self
        self.layout.badgesCollectionView.register(BadgeCell.self, forCellWithReuseIdentifier: BadgeCell.identifier)
        self.layout.badgesCollectionView.showsHorizontalScrollIndicator = false
        self.layout.badgesCollectionView.isScrollEnabled = true
        self.layout.badgesCollectionView.contentSize = CGSize(width: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 100), height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 300))
        if let layout = self.layout.badgesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 30), height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 30))
        }
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!) {
        print("Slider value changed")
        self.team.teacherAssistant.points = Int(sender.value)
        self.layout.currentProgressLabel.text = "\(Int(sender.value))/10"
    }
    
    func applyNextAndPrevLogic() {
        if currentTeamMemberIndex == -1 {
            // disable prev
            self.layout.previousLabel.textColor = UIColor.AppColors.gray
            self.layout.previousArrowsImageView.tintColor = UIColor.AppColors.gray
            self.layout.previousView.isUserInteractionEnabled = false
            self.layout.nextLabel.text = "previous".localized()
            
            // enable next
            self.layout.nextLabel.textColor = UIColor.AppColors.primaryColor
            self.layout.nextArrowsImageView.tintColor = UIColor.AppColors.darkRed
            self.layout.nextView.isUserInteractionEnabled = true
            self.layout.nextLabel.text = "next".localized()
            self.layout.nextArrowsImageView.isHidden = false
            self.layout.nextView.addTapGesture { (_) in
                self.goToNextUser()
            }
        } else if currentTeamMemberIndex > -1 && currentTeamMemberIndex < self.team.teamMembers.count - 1 {
            // enable prev
            self.layout.previousLabel.textColor = UIColor.AppColors.primaryColor
            self.layout.previousArrowsImageView.tintColor = UIColor.AppColors.darkRed
            self.layout.previousView.isUserInteractionEnabled = true
            self.layout.nextLabel.text = "previous".localized()
            
            // enable next
            self.layout.nextLabel.textColor = UIColor.AppColors.primaryColor
            self.layout.nextArrowsImageView.tintColor = UIColor.AppColors.darkRed
            self.layout.nextArrowsImageView.isHidden = false
            self.layout.nextView.isUserInteractionEnabled = true
            self.layout.nextLabel.text = "next".localized()
            self.layout.nextView.addTapGesture { (_) in
                self.goToNextUser()
            }
        } else if currentTeamMemberIndex == self.team.teamMembers.count - 1 {
            // enable prev
            self.layout.previousLabel.textColor = UIColor.AppColors.primaryColor
            self.layout.previousArrowsImageView.tintColor = UIColor.AppColors.darkRed
            self.layout.nextLabel.text = "previous".localized()
            self.layout.previousView.isUserInteractionEnabled = true
            
            // disable next
            self.layout.nextLabel.textColor = UIColor.AppColors.primaryColor
            self.layout.nextLabel.text = "end".localized()
            self.layout.nextArrowsImageView.isHidden = true
            self.layout.nextView.isUserInteractionEnabled = true
            self.layout.nextView.addTapGesture { (_) in
                print("rate the team")
                self.presenter.rateTheTeam(teamMembers: self.team.teamMembers, weekRequestId: self.week.requestId)
                self.presenter.rateTA(teacherAssistant: self.team.teacherAssistant, weekRequestId: self.week.requestId)
            }
        }
    }
    
    func populateCurrentSelectedUserData() {
        if currentTeamMemberIndex == -1 {
            let profilePic = self.team.teacherAssistant.profilePic
            self.layout.userProfileImageView.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(profilePic!)")!, placeholderImage: UIImage(named: "no_pp")!)
            self.layout.usernameLabel.text = "\(self.team.teacherAssistant.firstname!) \(self.team.teacherAssistant.lastname!)"
            self.layout.userPositionLabel.text = "teacherAssistant".localized()
            self.layout.evaluateTeacherAssistantLabel.text = "rateTeacherAssistant".localized()
            self.layout.progrssBar.isHidden = false
            self.layout.startProgressLabel.isHidden = false
            self.layout.currentProgressLabel.isHidden = false
            self.layout.endProgressLabel.isHidden = false
            self.layout.teacherAssistantMarksTableView.isHidden = false
            self.layout.badgesCollectionView.isHidden = true
            self.layout.teacherAssistantMarksTableView.reloadData()
        } else {
            let profilePic = self.team.teamMembers.get(at: currentTeamMemberIndex)?.member.profilePic
            self.layout.userProfileImageView.af_setImage(withURL: URL(string: "\(CommonConstants.IMAGES_BASE_URL)\(profilePic!)")!, placeholderImage: UIImage(named: "no_pp")!)
            let firstname = self.team.teamMembers.get(at: currentTeamMemberIndex)?.member.firstname
            let lastname = self.team.teamMembers.get(at: currentTeamMemberIndex)?.member.lastname
            self.layout.usernameLabel.text = "\(firstname!) \(lastname!)"
            self.layout.userPositionLabel.text = "teamMember".localized()
            self.layout.evaluateTeacherAssistantLabel.text = "giveTheBadge".localized()
            self.layout.progrssBar.isHidden = true
            self.layout.startProgressLabel.isHidden = true
            self.layout.currentProgressLabel.isHidden = true
            self.layout.endProgressLabel.isHidden = true
            self.layout.teacherAssistantMarksTableView.isHidden = true
            self.layout.badgesCollectionView.isHidden = false
            self.layout.badgesCollectionView.reloadData()
        }
        
        if self.team != nil {
            self.layout.usersNumberLabel.text = "\(currentTeamMemberIndex + 2)/\(self.team.teamMembers.count + 1)"
        }
    }

}

extension TeamRatingVC: TeamRatingView {
    func updateUserBadgeSuccess() {
        // go to main project screen
        self.navigator.navigationController.viewControllers.removeAll()
        self.navigator.navigationController.pushViewController(MainScreenVC.buildVC(), animated: true)
    }
    
    func rateTeamMembersSuccess() {
        isTeamRated = true
        if isTeamRated && isTARated {
            // call user badges
            self.presenter.updateTeamBadges(teamMembers: self.team.teamMembers, weekRequestId: self.week.requestId)
        }
    }
    
    func rateTeacherAssistantSuccess() {
        isTARated = true
        if isTeamRated && isTARated {
            // call user badges
            self.presenter.updateTeamBadges(teamMembers: self.team.teamMembers, weekRequestId: self.week.requestId)
        }
    }
    
    func getTAMarksSuccess(marks: [TeacherAssistantMark]) {
        self.teacherAssistantMarks = marks
        applyNextAndPrevLogic()
        populateCurrentSelectedUserData()
    }
    
    func getBadgesSuccess(badges: [Badge]) {
        for member in self.team.teamMembers {
            member.badges = [Badge]()
            let noBadge = Badge()
            noBadge.name = "noBadge".localized()
            noBadge.image = "noBadge".localized()
            member.badges.append(noBadge)
            for badge in badges {
                let newBadge = Badge()
                newBadge.requestId = badge.requestId
                newBadge.id = badge.id
                newBadge.name = badge.name
                newBadge.image = badge.image
                newBadge.weight = badge.weight
                newBadge.description = badge.description
                newBadge.isSelected = badge.isSelected
                member.badges.append(newBadge)
            }
        }
        
        self.presenter.getTAMarks()
    }
    
    func opetaionFailed(message: String) {
        self.view.makeToast(message)
    }
    
    func getTeamSuccess(team: Team) {
        let user = User.getInstance(dictionary:  Defaults[.user]!)
        var counter = 0
        for teamMember in team.teamMembers {
            if teamMember.member.id == user.id {
                team.teamMembers.remove(at: counter)
            }
            counter = counter + 1
        }
        self.team = team
        self.team.teacherAssistant.points = 5
        self.presenter.getBadges()
    }
}

extension TeamRatingVC: TeamRatingLayoutDelegate {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func goToNextUser() {
        if currentTeamMemberIndex == -1 {
            currentTeamMemberIndex = currentTeamMemberIndex + 1
            applyNextAndPrevLogic()
            populateCurrentSelectedUserData()
            if self.layout.addCommentField.text != nil && !(self.layout.addCommentField.text?.isEmpty)! {
                self.team.teacherAssistant.comment = self.layout.addCommentField.text!
            } else {
                self.team.teacherAssistant.comment = " "
            }
            self.layout.addCommentField.text = ""
        } else {
            if let _ = self.team.teamMembers[currentTeamMemberIndex].badge {
                if self.layout.addCommentField.text != nil && !(self.layout.addCommentField.text?.isEmpty)! {
                    self.team.teamMembers.get(at: currentTeamMemberIndex)?.comment = self.layout.addCommentField.text!
                } else {
                    self.team.teamMembers.get(at: currentTeamMemberIndex)?.comment = " "
                }
                self.team.teamMembers.get(at: currentTeamMemberIndex)?.comment = self.layout.addCommentField.text!
                currentTeamMemberIndex = currentTeamMemberIndex + 1
                applyNextAndPrevLogic()
                populateCurrentSelectedUserData()
                self.layout.addCommentField.text = ""
            } else {
                self.view.makeToast("selectBadge".localized())
            }
        }
    }
    
    func goToPreviousUser() {
        currentTeamMemberIndex = currentTeamMemberIndex - 1
        applyNextAndPrevLogic()
        populateCurrentSelectedUserData()
        if currentTeamMemberIndex == -1 {
            self.layout.addCommentField.text = self.team.teacherAssistant.comment
        } else {
            self.layout.addCommentField.text = self.team.teamMembers.get(at: currentTeamMemberIndex)?.comment
        }
    }
    
    func retry() {
        
    }
}

extension TeamRatingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if teacherAssistantMarks != nil {
            return teacherAssistantMarks.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TeacherAssitantMarksCell = self.layout.teacherAssistantMarksTableView.dequeueReusableCell(withIdentifier: TeacherAssitantMarksCell.identifier, for: indexPath) as! TeacherAssitantMarksCell
        cell.selectionStyle = .none
        cell.setupViews()
        cell.index = indexPath.row
        cell.mark = teacherAssistantMarks.get(at: indexPath.row)!
        cell.delegate = self
        cell.populateData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5)
    }
    
}

extension TeamRatingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.team != nil &&  currentTeamMemberIndex != -1 {
            return (self.team.teamMembers.get(at: currentTeamMemberIndex)?.badges.count)!
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCell.identifier, for: indexPath) as! BadgeCell
        cell.delegate = self
        cell.badge = self.team.teamMembers.get(at: currentTeamMemberIndex)?.badges.get(at: indexPath.row)
        cell.index = indexPath.row
        cell.setupViews()
        cell.populateImage()
        return cell
    }
}

extension TeamRatingVC: TeacherAssitantMarksCellDelegate {
    func checked(ischecked: Bool, index: Int) {
        if ischecked {
            self.team.teacherAssistant.selectedMarks.append((self.teacherAssistantMarks.get(at: index)?.requestId)!)
            self.teacherAssistantMarks.get(at: index)?.isSelected = true
        } else {
            self.team.teacherAssistant.selectedMarks.remove(at: self.team.teacherAssistant.selectedMarks.firstIndex(of: (self.teacherAssistantMarks.get(at: index)?.requestId)!)!)
            self.teacherAssistantMarks.get(at: index)?.isSelected = false
        }
        self.layout.teacherAssistantMarksTableView.reloadData()
    }
}

extension TeamRatingVC: BadgeDelegate {
    func badgeSelected(index: Int) {
        self.team.teamMembers.get(at: currentTeamMemberIndex)?.badge = self.team.teamMembers.get(at: currentTeamMemberIndex)?.badges.get(at: index)?.image
        self.team.teamMembers.get(at: currentTeamMemberIndex)?.badges.get(at: index)?.isSelected = true
        let arrayCount = (self.team.teamMembers.get(at: currentTeamMemberIndex)?.badges.count)!
        for counter in 0...arrayCount {
            if counter != index {
                self.team.teamMembers.get(at: currentTeamMemberIndex)?.badges.get(at: counter)?.isSelected = false
            }
        }
        self.layout.badgesCollectionView.reloadData()
    }
}
