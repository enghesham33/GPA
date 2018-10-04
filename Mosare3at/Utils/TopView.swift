//
//  TopView.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/3/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Localize_Swift

public protocol TopViewDelegate {
    func goBack()
}

public class TopView: UIView {
    
    public var delegate: TopViewDelegate!
    
    public var screenTitle: String!
    
    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        if Localize.currentLanguage() == "ar" {
            imageView.image = UIImage(named: "back_icon_arabic")
        } else {
           imageView.image = UIImage(named: "back_icon")
        }
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
            self.delegate.goBack()
        })
        return imageView
    }()
    
    lazy var screenTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "forgetPassword".localized()
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setupViews(screenTitle: String) {
        let views = [backImageView, screenTitleLabel]
        self.backgroundColor = .black
        
        self.addSubviews(views)
        
        self.backImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(self.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            
            maker.top.equalTo(self.snp.top).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        self.screenTitleLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(backImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            
            maker.top.height.equalTo(backImageView)
            
            maker.width.equalTo(screenTitle.widthOfString(usingFont: screenTitleLabel.font) + 15)
        }
    }
    
}
