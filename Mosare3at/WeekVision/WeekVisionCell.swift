//
//  WeekVisionCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/1/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Material
import Localize_Swift


public protocol WeekVisionCellDelegate: class {
    func goToMilestonesScreen()
    func playVideo()
}


class WeekVisionCell: UITableViewCell {
    
    public static let identifier = "WeekVisionCell"
    var tasks: [String]!
    var delegate:WeekVisionCellDelegate!
    var superView: UIView!
    var startWeekButtonText: String!
    var teamDeliverables: [Deliverable]!
    var individualsDeliverables: [Deliverable]!
    
    lazy var congratulationsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "mabrook")
        return imageView
    }()
    
    lazy var congratulationsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 15)
        return label
    }()
    
    lazy var videoThumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var playIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "play_icon")
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (_) in
            self.delegate.playVideo()
        })
        return imageView
    }()
    
    lazy var playIconView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.addTapGesture(action: { (_) in
            self.delegate.playVideo()
        })
        return view
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
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        return tableView
    }()
    
    lazy var teamOutputsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        return view
    }()
    
    lazy var teamOutputsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "teamOutputs".localized()
        label.backgroundColor = .white
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    var teamOutputsCollectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    
    var teamOutputsPageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
    
    lazy var individualsOutputsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        return view
    }()
    
    lazy var individualsOutputsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.text = "individualsOutputs".localized()
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    var individualsOutputsCollectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    
    var individualsOutputsPageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
    
    lazy var startWeekButton: RaisedButton = {
        let button = RaisedButton(title: startWeekButtonText, titleColor: .white)
        button.backgroundColor = UIColor.AppColors.darkRed
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 18)
        
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 1)
        button.addTapGesture { recognizer in
            self.delegate.goToMilestonesScreen()
        }
        return button
    }()
    
    public func setupViews() {
        let views = [congratulationsImageView, congratulationsLabel, videoThumbImageView, playIconImageView, tasksView, tasksTableView, teamOutputsView, teamOutputsLabel, teamOutputsCollectionView, teamOutputsPageControl, individualsOutputsView, individualsOutputsLabel, individualsOutputsCollectionView, individualsOutputsPageControl, startWeekButton, playIconView]
        superView = self.contentView
        self.superView.addSubviews(views)
        self.congratulationsImageView.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(superView)
            maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 60))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
        }
        
        self.congratulationsLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superView)
            maker.top.equalTo(congratulationsImageView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        self.videoThumbImageView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superView)
            maker.top.equalTo(congratulationsLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30))
        }
        
        videoThumbImageView.addSubview(playIconImageView)
        self.playIconImageView.snp.makeConstraints { (maker) in
            maker.center.equalTo(videoThumbImageView)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 20))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10))
        }
        
        self.playIconView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(playIconImageView)
        }
        self.tasksView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.top.equalTo(videoThumbImageView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            
            maker.height.equalTo((UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3.5) * CGFloat(tasks.count)) + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        self.tasksView.addSubview(self.tasksTableView)
        self.tasksTableView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(tasksView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3))
            maker.trailing.equalTo(tasksView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            maker.top.equalTo(tasksView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            
            maker.bottom.equalTo(tasksView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3) * -1)
        }
        
        self.teamOutputsView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.top.equalTo(tasksView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30))
        }
        self.teamOutputsView.addSubviews([teamOutputsLabel, teamOutputsCollectionView, teamOutputsPageControl])
        
        self.teamOutputsLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(teamOutputsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(teamOutputsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.trailing.equalTo(teamOutputsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        self.teamOutputsCollectionView.snp.makeConstraints { (maker) in
            maker.top.equalTo(teamOutputsLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.leading.equalTo(teamOutputsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            
            maker.trailing.equalTo(teamOutputsView)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 18))
        }
        
        self.teamOutputsPageControl.snp.makeConstraints { (maker) in            maker.top.equalTo(teamOutputsCollectionView.snp.bottom)
            
            maker.centerX.equalTo(teamOutputsView)
            maker.height.equalTo(30)
            maker.width.equalTo(self.superView.frame.width)
        }
        
        self.individualsOutputsView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.top.equalTo(teamOutputsView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30))
        }
        
        self.individualsOutputsView.addSubviews([individualsOutputsLabel, individualsOutputsCollectionView, individualsOutputsPageControl])
        
        self.individualsOutputsLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(individualsOutputsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(individualsOutputsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.trailing.equalTo(individualsOutputsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        self.individualsOutputsCollectionView.snp.makeConstraints { (maker) in
            maker.top.equalTo(individualsOutputsLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.leading.equalTo(individualsOutputsView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            
            maker.trailing.equalTo(individualsOutputsView)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 18))
        }
        
        self.individualsOutputsPageControl.snp.makeConstraints { (maker) in            maker.top.equalTo(individualsOutputsCollectionView.snp.bottom)
            
            maker.centerX.equalTo(individualsOutputsView)
            maker.height.equalTo(30)
            maker.width.equalTo(self.superView.frame.width)
        }
        
        self.startWeekButton.snp.makeConstraints { maker in
            maker.leading.equalTo(superView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10))
            maker.trailing.equalTo(superView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 10) * -1)
            maker.bottom.equalTo(superView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5) * -1)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
    }
    
    public func populateData(congratulationsText: String, videoThumbUrl: String) {
        congratulationsLabel.text = congratulationsText
        videoThumbImageView.af_setImage(withURL: URL(string: videoThumbUrl)!)
        
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.reloadData()
        
        self.teamOutputsCollectionView.register(OutputsCell.self, forCellWithReuseIdentifier: OutputsCell.identifier)
        self.teamOutputsCollectionView.showsHorizontalScrollIndicator = false
        if let layout = self.teamOutputsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 80) , height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 16))
            layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0.0
        }
        teamOutputsCollectionView.backgroundColor = .clear
        teamOutputsCollectionView.dataSource = self
        teamOutputsCollectionView.delegate = self
        teamOutputsCollectionView.reloadData()
        
        self.individualsOutputsCollectionView.register(OutputsCell.self, forCellWithReuseIdentifier: OutputsCell.identifier)
        self.individualsOutputsCollectionView.showsHorizontalScrollIndicator = false
        if let layout = self.individualsOutputsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 80) , height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 16))
            layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0.0
        }
        individualsOutputsCollectionView.backgroundColor = .clear
        individualsOutputsCollectionView.dataSource = self
        individualsOutputsCollectionView.delegate = self
        individualsOutputsCollectionView.reloadData()
        
        
        
        self.teamOutputsPageControl.numberOfPages = teamDeliverables.count
        self.teamOutputsPageControl.currentPage = 0
        self.teamOutputsPageControl.tintColor = UIColor.black
        self.teamOutputsPageControl.pageIndicatorTintColor = UIColor.gray
        self.teamOutputsPageControl.currentPageIndicatorTintColor = UIColor.AppColors.darkRed
        
        self.individualsOutputsPageControl.numberOfPages = individualsDeliverables.count
        self.individualsOutputsPageControl.currentPage = 0
        self.individualsOutputsPageControl.tintColor = UIColor.black
        self.individualsOutputsPageControl.pageIndicatorTintColor = UIColor.gray
        self.individualsOutputsPageControl.currentPageIndicatorTintColor = UIColor.AppColors.darkRed
    }
    
}

extension WeekVisionCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tasks != nil && tasks.count > 0 {
            return tasks.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TaskCell = self.tasksTableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        cell.selectionStyle = .none
        cell.task = self.tasks.get(at: indexPath.row)
        cell.setupViews()
        cell.populateData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3)
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
        label.text = "neededThisWeek".localized()
        label.font = AppFont.font(type: .Bold, size: 20)
        
        view.addSubview(label)
        
        label.snp.makeConstraints { (maker) in
            maker.leading.equalTo(view).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.trailing.equalTo(view).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.top.bottom.equalTo(view)
        }
        return view
    }
    
    func getVisiableItemIndexPath(collectionView: UICollectionView) -> IndexPath? {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        return visibleIndexPath
    }
}

extension WeekVisionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.teamOutputsCollectionView {
            if self.teamDeliverables != nil && self.teamDeliverables.count > 0 {
                return self.teamDeliverables.count
            }
            return 0
        } else if collectionView == self.individualsOutputsCollectionView {
            if self.individualsDeliverables != nil && self.individualsDeliverables.count > 0 {
                return self.individualsDeliverables.count
            }
            return 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OutputsCell.identifier, for: indexPath) as! OutputsCell
        cell.setupViews()
        if collectionView == self.teamOutputsCollectionView {
            cell.deliverable = self.teamDeliverables.get(at: indexPath.row)
        } else if collectionView == self.individualsOutputsCollectionView {
            cell.deliverable = self.individualsDeliverables.get(at: indexPath.row)
        }
        cell.populateData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 80) , height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 16))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 //between item in row
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        chooseImageFromAvatars(index: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView as! UICollectionView == teamOutputsCollectionView {
            if let index = getVisiableItemIndexPath(collectionView: teamOutputsCollectionView) {
                teamOutputsPageControl.currentPage = index.row
            }
        } else if scrollView as! UICollectionView == individualsOutputsCollectionView  {
            if let index = getVisiableItemIndexPath(collectionView: individualsOutputsCollectionView) {
                individualsOutputsPageControl.currentPage = index.row
            }
        }
        
    }
    
}
