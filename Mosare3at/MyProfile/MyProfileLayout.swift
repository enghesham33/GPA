//
//  MyProfileLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/18/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import Material

public protocol MyProfileLayoutDelegate: BaseLayoutDelegate {
    func goBack()
}

public class MyProfileLayout: BaseLayout {
    
    var delegate: MyProfileLayoutDelegate!
    
    init(superview: UIView, delegate: MyProfileLayoutDelegate) {
        super.init(superview: superview)
        self.delegate = delegate
    }
    
    lazy var myProfileTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = true
        tableView.register(MyProfileCell.self, forCellReuseIdentifier: MyProfileCell.identifier)
        return tableView
    }()
    
    public func setupViews() {
        let views = [myProfileTableView]
        
        self.superview.addSubviews(views)
        self.myProfileTableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(superview)
        }
        
    }
    
}
