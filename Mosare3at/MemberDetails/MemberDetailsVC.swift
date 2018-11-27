//
//  MemberDetailsVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/25/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import AVKit
import EzPopup

class MemberDetailsVC: BaseVC {

    var layout: MemberDetailsLayout!
    var presenter: MemberDetailsPresenter!
    
    var userInfo: UserInfo!
    var videos: [Video]!
    var member: TeamMember!
    var isTeamMate: Bool!
    
    public static func buildVC(member: TeamMember, isTeamMate: Bool) -> MemberDetailsVC {
        let vc = MemberDetailsVC()
        vc.member = member
        vc.isTeamMate = isTeamMate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = MemberDetailsLayout(superview: self.view, delegate: self)
        layout.setupViews()
        
        presenter = Injector.provideMemberDetailsPresenter()
        presenter.setView(view: self)
        
        presenter.getUserInfo(userId: member.member.id)
    }
}

extension MemberDetailsVC: MemberDetailsLayoutDelegate {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MemberDetailsVC: MemberDetailsView {
    func opetaionFailed(message: String) {
        self.view.makeToast(message)
    }
    
    func getUserInfoSuccess(userInfo: UserInfo) {
        self.userInfo = userInfo
        let programId = Subscribtion.getInstance(dictionary: Defaults[.subscription]!).program.requestId.components(separatedBy: "/")[Subscribtion.getInstance(dictionary: Defaults[.subscription]!).program.requestId.components(separatedBy: "/").count - 1]
        
        presenter.getVideos(programId: Int(programId)!, userId: member.member.id)
    }
    
    func getVideosSuccess(videos: [Video]) {
        self.videos = videos
        
        layout.memberDetailsTableView.dataSource = self
        layout.memberDetailsTableView.delegate = self
        layout.memberDetailsTableView.reloadData()
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

extension MemberDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MemberDetailsCell = layout.memberDetailsTableView.dequeueReusableCell(withIdentifier: MemberDetailsCell.identifier, for: indexPath) as! MemberDetailsCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.member = member
        cell.videos = videos
        cell.userInfo = userInfo
        cell.isTeamMate = isTeamMate
        cell.setupViews()
        cell.populateData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 170)
    }
}

extension MemberDetailsVC: MemberDetailsCellDelegate {
    func playVideo(index: Int) {
        if let link = self.videos.get(at: index)?.videoLink, !link.isEmpty {
            self.getVideoLinkSuccess(videoLink: link, index: index)
        } else {
            self.presenter.getVideoLinks(videoId: (self.videos.get(at: index)?.id)!, index: index)
        }
    }
    
    func badgeClicked(index: Int) {
        let vc = PopupDialogVC.buildVC()
        vc.badge = userInfo.badges.get(at: index)!
        vc.showShare = false
        let popupVC = PopupViewController(contentController: vc, popupWidth: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 90), popupHeight: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 70))
        present(popupVC, animated: true)
    }
    
    func close() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func openSlack() {
//        UIApplication.shared.openURL(URL("https://slack.com/")!)
    }
    
    func openProgramDetails() {
        
    }
    
    func openMoreVideos() {
        
    }
}
