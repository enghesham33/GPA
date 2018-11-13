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
import SideMenu

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
    
    class func share(textToShare: String, sourceView: UIView, vc: BaseVC) {
        
        // set up activity view controller
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sourceView // so that iPads won't crash
        
        // present the view controller
        vc.present(activityViewController, animated: true, completion: nil)
    }
    
    class func setupSideMenu(delegate: UISideMenuNavigationControllerDelegate, viewToPresent: UIView, viewToEdge: UIView, sideMenuCellDelegate: SideMenuCellDelegate, sideMenuHeaderDelegate: SideMenuHeaderDelegate) -> SideMenuVC {
        
        let sideMenuVC = SideMenuVC.buildVC()
        sideMenuVC.sideMenuCellDelegate = sideMenuCellDelegate
        sideMenuVC.sideMenuHeaderDelegate = sideMenuHeaderDelegate
        
        let menuNavigationController = UISideMenuNavigationController(rootViewController: sideMenuVC)
        menuNavigationController.sideMenuDelegate = delegate
        menuNavigationController.menuWidth = UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 90)
        if Localize.currentLanguage() == "ar" {
            SideMenuManager.default.menuRightNavigationController = menuNavigationController
            SideMenuManager.default.menuLeftNavigationController = nil
        } else {
            SideMenuManager.default.menuLeftNavigationController = menuNavigationController
            SideMenuManager.default.menuRightNavigationController = nil
        }
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: viewToPresent)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: viewToEdge)
        return sideMenuVC
    }
    
    public class func convertStringToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: dateString)!
    }
    
    public class func compareDates(date1: Date, date2: Date) -> DateComparisonResult {
        if date1 > date2 {
            return .FIRST_GREATER
        } else if date2 > date1 {
            return .SECOND_GREATER
        } else {
            return .EQUAL
        }
    }
    
    public class func convertDateToString(date: Date, dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat        
        return formatter.string(from: date)
    }
}

public enum LengthRelation: Int {
    case SCREEN_WIDTH = 0
    case SCREEN_HEIGHT = 1
    case VIEW_WIDTH = 2
    case VIEW_HEIGHT = 3
}

public enum DateComparisonResult: Int {
    case FIRST_GREATER = 0
    case SECOND_GREATER = 1
    case EQUAL = 2
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
    
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
    
    func byConvertingHTMLToPlainText() -> String {
        
        let stopCharacters = CharacterSet(charactersIn: "< \t\n\r\(0x0085)\(0x000C)\(0x2028)\(0x2029)")
        let newLineAndWhitespaceCharacters = CharacterSet(charactersIn: " \t\n\r\(0x0085)\(0x000C)\(0x2028)\(0x2029)")
        let tagNameCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        
        let result = NSMutableString(capacity: length)
        let scanner = Scanner(string: self as String)
        scanner.charactersToBeSkipped = nil
        scanner.caseSensitive = true
        var str: NSString? = nil
        var tagName: NSString? = nil
        var dontReplaceTagWithSpace = false
        
        repeat {
            // Scan up to the start of a tag or whitespace
            if scanner.scanUpToCharacters(from: stopCharacters, into: &str), let s = str {
                result.append(s as String)
                str = nil
            }
            // Check if we've stopped at a tag/comment or whitespace
            if scanner.scanString("<", into: nil) {
                // Stopped at a comment, script tag, or other tag
                if scanner.scanString("!--", into: nil) {
                    // Comment
                    scanner.scanUpTo("-->", into: nil)
                    scanner.scanString("-->", into: nil)
                } else if scanner.scanString("script", into: nil) {
                    // Script tag where things don't need escaping!
                    scanner.scanUpTo("</script>", into: nil)
                    scanner.scanString("</script>", into: nil)
                } else {
                    // Tag - remove and replace with space unless it's
                    // a closing inline tag then dont replace with a space
                    if scanner.scanString("/", into: nil) {
                        // Closing tag - replace with space unless it's inline
                        tagName = nil
                        dontReplaceTagWithSpace = false
                        if scanner.scanCharacters(from: tagNameCharacters, into: &tagName), let t = tagName {
                            tagName = t.lowercased as NSString
                            dontReplaceTagWithSpace =
                                tagName == "a" ||
                                tagName == "b" ||
                                tagName == "i" ||
                                tagName == "q" ||
                                tagName == "span" ||
                                tagName == "em" ||
                                tagName == "strong" ||
                                tagName == "cite" ||
                                tagName == "abbr" ||
                                tagName == "acronym" ||
                                tagName == "label"
                        }
                        // Replace tag with string unless it was an inline
                        if !dontReplaceTagWithSpace && result.length > 0 && !scanner.isAtEnd {
                            result.append(" ")
                        }
                    }
                    // Scan past tag
                    scanner.scanUpTo(">", into: nil)
                    scanner.scanString(">", into: nil)
                }
            } else {
                // Stopped at whitespace - replace all whitespace and newlines with a space
                if scanner.scanCharacters(from: newLineAndWhitespaceCharacters, into: nil) {
                    if result.length > 0 && !scanner.isAtEnd {
                        result.append(" ") // Dont append space to beginning or end of result
                    }
                }
            }
        } while !scanner.isAtEnd
        
        // Cleanup
        
        // Decode HTML entities and return (this isn't included in this gist, but is often important)
        // let retString = (result as String).stringByDecodingHTMLEntities
        
        // Return
        return result as String // retString;
    }
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
