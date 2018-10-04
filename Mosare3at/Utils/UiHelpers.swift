//
//  UiHelpers.swift
//  Mosare3at
//
//  Created by Hesham Donia on 9/30/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import Material
import Localize_Swift
import SystemConfiguration

class UiHelpers {
    
    class func textField(placeholder: String) -> ErrorTextField {
        let field = ErrorTextField()
        field.placeholder = placeholder
        field.placeholderActiveColor = field.placeholderNormalColor
        field.dividerActiveColor = UIColor.AppColors.gray
        field.placeholderVerticalOffset = 10
        if Localize.currentLanguage() == "en" {
            field.placeholderLabel.textAlignment = .left
            field.textAlignment = .left
        } else {
            field.textAlignment = .right
            field.placeholderLabel.textAlignment = .right
        }
        field.detailColor = UIColor.AppColors.gray
        return field
    }
    
    class func showLoader() {
        let activityData = ActivityData(size: nil, message: nil, messageFont: nil, messageSpacing: nil, type: nil, color: UIColor.AppColors.darkGray, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    class func hideLoader() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
    class func getLengthAccordingTo(relation: LengthRelation, relativeView: UIView?, percentage: CGFloat) -> CGFloat {
        
        switch relation {
        case .SCREEN_WIDTH:
            return UIScreen.main.bounds.width * (percentage / 100)
            
        case .SCREEN_HEIGHT:
            return UIScreen.main.bounds.height * (percentage / 100)
            
        case .VIEW_WIDTH:
            if let view = relativeView {
                return view.size.width * (percentage / 100)
            }
            return 0
            
        case .VIEW_HEIGHT:
            if let view = relativeView {
                return view.size.height * (percentage / 100)
            }
            return 0
        }
    }
    
    class func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let isConnected = (isReachable && !needsConnection)
        return isConnected
        
    }
}

public enum LengthRelation: Int {
    case SCREEN_WIDTH = 0
    case SCREEN_HEIGHT = 1
    case VIEW_WIDTH = 2
    case VIEW_HEIGHT = 3
}

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width + 10
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height + 10
    }
}
