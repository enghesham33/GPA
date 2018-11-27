//
//  MemberDetailsLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/25/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public protocol MemberDetailsLayoutDelegate: class {
    func goBack()
}

public class MemberDetailsLayout: BaseLayout {
    
    var delegate: MemberDetailsLayoutDelegate!
    
    init(superview: UIView, delegate: MemberDetailsLayoutDelegate) {
        super.init(superview: superview)
        self.delegate = delegate
    }
    
    lazy var memberDetailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = true
        tableView.register(MemberDetailsCell.self, forCellReuseIdentifier: MemberDetailsCell.identifier)
        return tableView
    }()
    
    public func setupViews() {
        let views = [memberDetailsTableView]
        
        self.superview.addSubviews(views)
        self.memberDetailsTableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(superview)
        }
        
    }
    
}
