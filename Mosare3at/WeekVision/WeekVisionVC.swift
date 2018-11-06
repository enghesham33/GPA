//
//  WeekVisionVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/1/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Localize_Swift
import AVKit

class WeekVisionVC: BaseVC {
    
    var weekMaterial: WeekMaterial!
    var project: Project!
    var week: Week!
    var videoLink: String!
    var layout: WeekVisionLayout!
    var presenter: WeekVisionPresenter!
    
    public static func buildVC(weekMaterial: WeekMaterial, project: Project, week: Week) -> WeekVisionVC {
        let vc = WeekVisionVC()
        vc.weekMaterial = weekMaterial
        vc.week = week
        vc.project = project
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = WeekVisionLayout(superview: self.view, weekVisionLayoutDelegate: self, screenTitle: getScreenTitle())
        layout.setupViews()
        layout.weekVisionTableView.dataSource = self
        layout.weekVisionTableView.delegate = self
        layout.weekVisionTableView.reloadData()
        
        presenter = Injector.provideWeekVisionPresenter()
        presenter.setView(view: self)
        presenter.getVideoLinks(videoId: self.weekMaterial.video.id)
    }
    
    func getProjectIndexName() -> String{
        switch (self.project.weight) {
            
        case 1:
            return "الأول"
        case 2:
            return "الثاني"
        case 3:
            return "الثالث"
        case 4:
            return "الرابع"
        case 5:
            return "الخامس"
        case 6:
            return "السادس"
        case 7:
            return "السابع"
        case 8:
            return "الثامن"
            
        default:
            return "الأول"
        }
    }
    
    func getWeekIndexName() -> String {
        switch (self.week.weight) {
            
        case 1:
            return "الأول"
        case 2:
            return "الثاني"
        case 3:
            return "الثالث"
        case 4:
            return "الرابع"
        case 5:
            return "الخامس"
        case 6:
            return "السادس"
        case 7:
            return "السابع"
        case 8:
            return "الثامن"
            
        default:
            return "الأول"
        }
    }
    
    func getScreenTitle() -> String {
        switch (self.week.weight) {
            
        case 1:
            return "رؤية الاسبوع الأول"
        case 2:
            return "رؤية الاسبوع الثاني"
        case 3:
            return "رؤية الاسبوع الثالث"
        case 4:
            return "رؤية الاسبوع الرابع"
        case 5:
            return "رؤية الاسبوع الخامس"
        case 6:
            return "رؤية الاسبوع السادس"
        case 7:
            return "رؤية الاسبوع السابع"
        case 8:
            return "رؤية الاسبوع الثامن"
            
        default:
            return "رؤية الاسبوع الأول"
        }
        
    }
    
    func getTeamDeliverables() -> [Deliverable] {
        var result: [Deliverable] = []
        for deliverable in weekMaterial.deliverables {
            if deliverable.collective {
                result.append(deliverable)
            }
        }
        return result
    }
    
    func getIndividualsDeliverables() -> [Deliverable] {
        var result: [Deliverable] = []
        for deliverable in weekMaterial.deliverables {
            if !deliverable.collective {
                result.append(deliverable)
            }
        }
        return result
    }
    
}

extension WeekVisionVC: WeekVisionLayoutDelegate {
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func retry() {
        
    }
}

extension WeekVisionVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WeekVisionCell = self.layout.weekVisionTableView.dequeueReusableCell(withIdentifier: WeekVisionCell.identifier, for: indexPath) as! WeekVisionCell
        cell.selectionStyle = .none
        cell.startWeekButtonText = "\("startWeek".localized()) \(getWeekIndexName())"
        cell.tasks = weekMaterial.expectations
        cell.setupViews()
        cell.delegate = self
        cell.index = indexPath.row
        cell.teamDeliverables = getTeamDeliverables()
        cell.individualsDeliverables = getIndividualsDeliverables()
        cell.populateData(congratulationsText: "\("congratToStart".localized()) \(getWeekIndexName()) \("fromProject".localized()) \(getProjectIndexName())", videoThumbUrl: (self.weekMaterial.video.thumbnails.get(at: 0)?.thumb)!)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 160)
    }
}

extension WeekVisionVC: WeekVisionCellDelegate {
    func goToMilestonesScreen(index: Int) {
        self.navigator.navigateToMilestonesScreen(weekMaterial: self.weekMaterial, project: self.project, week: self.week, clickedMilestone: self.weekMaterial.milestones.get(at: index)!, currentMilestoneIndex: index)
    }
    
    func playVideo() {
        if videoLink != nil {
            let videoURL = URL(string: videoLink)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        } else {
            presenter.getVideoLinks(videoId: self.weekMaterial.video.id)
        }
    }
}

extension WeekVisionVC: WeekVisionView {
    func opetaionFailed(message: String) {
        self.view.makeToast(message)
    }
    
    func getVideoLinksSuccess(link: String) {
        videoLink = link
    }
}
