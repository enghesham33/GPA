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

class VideosVC: BaseVC {

    var layout: VideosLayout!
    var program: Program!
    var programId: Int!
    var videos: [Video]!
    var projects: [Project]!
    var team: [Team]!
    var presenter: VideosPresenter!
    
    
    public static func buildVC() -> VideosVC {
        let vc = VideosVC()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        program = Subscribtion.getInstance(dictionary: Defaults[.subscription]!).program
        
        layout = VideosLayout(superview: self.view, delegate: self)
        layout.setupViews()
        layout.videosTableView.dataSource = self
        layout.videosTableView.delegate = self
        
        presenter = Injector.provideVideosPresenter()
        presenter.setView(view: self)
        programId = Int(program.requestId.components(separatedBy: "/")[program.requestId.components(separatedBy: "/").count - 1])!
        presenter.getProjects(programId: programId)
        
    }

}

extension VideosVC: VideosLayoutDelegate {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension VideosVC: VideoCellDelegate {
    func playVideo(index: Int) {
        self.presenter.getVideoLinks(videoId: (self.videos.get(at: index)?.id)!, index: index)
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
        self.videos = videos
        self.layout.videosTableView.reloadData()
    }
    
    func getProjectsSuccess(projects: [Project]) {
        self.projects = projects
        self.presenter.getTeams(projectId: nil)
    }
    
    func getTeamsSuccess(teams: [Team]) {
        self.presenter.getVideos(programId: self.programId, projectId: nil, teamId: nil, order: CommonConstants.ASCENDING)
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
