//
//  RegisteredProgramCell.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/20/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

class RegisteredProgramCell: UITableViewCell {

    public static let identifier = "RegisteredProgramCell"

    var program: RegisteredProgram!
    var superView: UIView!
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var programNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 18)
        return label
    }()
    
    lazy var programPhotoImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var projectsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = false
        tableView.register(RegisteredProjectCell.self, forCellReuseIdentifier: RegisteredProjectCell.identifier)
        return tableView
    }()
    
    
    
    public func setupViews() {
        let views = [programNameLabel, programPhotoImageview, containerView, projectsTableView]

        superView = self.contentView

        superView.addSubviews(views)
        
        containerView.addSubviews([programNameLabel, programPhotoImageview, projectsTableView])
        
        containerView.snp.makeConstraints { (maker) in
            maker.top.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(superView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superView).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30) + CGFloat(program.projects.count) * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 15))
        }
        
        programPhotoImageview.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.equalTo(containerView)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30))
        }
        
        programNameLabel.snp.makeConstraints { (maker) in
            maker.center.equalTo(programPhotoImageview)
            maker.width.equalTo(programPhotoImageview)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        projectsTableView.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalTo(containerView)
            maker.top.equalTo(programPhotoImageview.snp.bottom)
        }
        
        containerView.bringSubviewToFront(programNameLabel)
    }
    
    public func populateData() {
        
        programNameLabel.text = program.title
        
        programPhotoImageview.af_setImage(withURL: URL(string: CommonConstants.IMAGES_BASE_URL + program.image)!)
        
        projectsTableView.dataSource = self
        projectsTableView.delegate = self
        projectsTableView.reloadData()
    }
}

extension RegisteredProgramCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return program.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RegisteredProjectCell = projectsTableView.dequeueReusableCell(withIdentifier: RegisteredProjectCell.identifier, for: indexPath) as! RegisteredProjectCell
        
        cell.selectionStyle = .none
        
        cell.project = self.program.projects.get(at: indexPath.row)!
        cell.setupViews()
        cell.populateData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 12)
    }
}
