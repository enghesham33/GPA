//
//  VideosVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import AVKit
import EzPopup

class VideosVC: BaseVC {

    var layout: VideosLayout!
    var program: Program!
    var programId: Int!
    var videos: [Video]!
    var projects: [Project]!
    var teams: [Team]!
    var presenter: VideosPresenter!
    
    var isFromProfile: Bool!
    
    
    public static func buildVC() -> VideosVC {
        let vc = VideosVC()
        return vc
    }
    
    public static func buildVC(isFromProfile: Bool) -> VideosVC {
        let vc = VideosVC()
        vc.isFromProfile = isFromProfile
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        program = Subscribtion.getInstance(dictionary: Defaults[.subscription]!).program
        
        layout = VideosLayout(superview: self.view, delegate: self)
        layout.setupViews()
        layout.videosTableView.dataSource = self
        layout.videosTableView.delegate = self
        
        if let  _ = isFromProfile {
            layout.topView.leftImageView.isHidden = true
        }
        
        presenter = Injector.provideVideosPresenter()
        presenter.setView(view: self)
        programId = Int(program.requestId.components(separatedBy: "/")[program.requestId.components(separatedBy: "/").count - 1])!
        presenter.getProjects(programId: programId)
        
    }

}

extension VideosVC: VideosLayoutDelegate {
    func showFilters() {
        
        let vc = FiltersVC.buildVC()
        vc.projects = projects
        vc.programs = [program]
        vc.teams = teams
        vc.delegate = self
        
        let popupVC = PopupViewController(contentController: vc, popupWidth: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 90), popupHeight: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 41))
        present(popupVC, animated: true)
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension VideosVC: FiltersDelegate {
    func applyFilters(selectedProgramIndex: Int, selectedProjectIndex: Int, selectedTeamIndex: Int, selectedOrderIndex: Int) {
        var order = ""
        if selectedOrderIndex == 0 {
            order = CommonConstants.ASCENDING
        } else {
            order = CommonConstants.DESCENDING
        }
        var projectId: Int?
        var teamId: Int?
        
        if selectedProjectIndex > -1 {
            projectId = self.projects.get(at: selectedProjectIndex)?.id
        }
        
        if selectedTeamIndex > -1 {
            teamId = self.teams.get(at: selectedTeamIndex)?.id
        }
        
        self.presenter.getVideos(programId: self.programId, projectId: projectId, teamId: teamId, order: order, isFromProfile: self.isFromProfile)
    }
}

extension VideosVC: VideoCellDelegate {
    func playVideo(index: Int) {
        if let link = self.videos.get(at: index)?.videoLink, !link.isEmpty {
            self.getVideoLinkSuccess(videoLink: link, index: index)
        } else {
            self.presenter.getVideoLinks(videoId: (self.videos.get(at: index)?.id)!, index: index)
        }
    }
}

extension VideosVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = videos {
            return videos.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:VideoCell = self.layout.videosTableView.dequeueReusableCell(withIdentifier: VideoCell.identifier, for: indexPath) as! VideoCell
        cell.selectionStyle = .none
        cell.setupViews()
        cell.video = self.videos.get(at: indexPath.row)!
        cell.delegate = self
        cell.populateData()
        cell.index = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 65)
    }
}

extension VideosVC: VideosView {
    
    func opetaionFailed(message: String) {
        self.view.makeToast(message)
    }
    
    func getVideosSuccess(videos: [Video]) {
        if self.videos != nil && self.videos.count > 0 {
            self.videos.removeAll()
        }
        self.videos = videos
        if self.videos.count == 0 {
            self.layout.noVideosLabel.isHidden = false
            self.layout.videosTableView.isHidden = true
        } else {
            self.layout.noVideosLabel.isHidden = true
            self.layout.videosTableView.isHidden = false
            self.layout.videosTableView.reloadData()
        }
        
    }
    
    func getProjectsSuccess(projects: [Project]) {
        self.projects = projects
        self.presenter.getTeams(projectId: nil)
    }
    
    func getTeamsSuccess(teams: [Team]) {
        self.teams = teams
        self.presenter.getVideos(programId: self.programId, projectId: nil, teamId: nil, order: CommonConstants.ASCENDING, isFromProfile: self.isFromProfile)
    }
    
    func getVideoLinkSuccess(videoLink: String, index: Int) {
        self.videos.get(at: index)?.videoLink = videoLink
        let videoURL = URL(string: videoLink)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
}
