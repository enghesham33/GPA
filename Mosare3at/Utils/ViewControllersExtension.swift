//
//  ViewControllersExtension.swift
//  Lafarge Safety
//
//  Created by apple on 3/6/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation
import UIKit
import EZSwiftExtensions
import Toast_Swift

extension UIViewController {
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func hideKeyboardWhenClick() {
        self.view.addTapGesture { [weak self] recognizer in
            self?.dismissKeyboard()
        }
    }

  func setNavBarTitle(title:String,withColor color :UIColor,  tintColor :UIColor ) {
    let titleView = UILabel(frame:CGRect(x: 0, y: 0, width: 34, height: 34))
    titleView.font = AppFont.font(type: .Bold, size: 15)
    titleView.text = title
    titleView.textColor = color
    self.navigationItem.titleView = titleView
    self.navigationController!.navigationBar.tintColor = tintColor
  }
  
  func setStatusBarWithWhiteStyle() {
     self.navigationController?.setNavigationBarHidden(true, animated: true)
     UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
  }
  func setStatusBarWithBlackStyle() {
     self.navigationController?.setNavigationBarHidden(true, animated: true)
     UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
  }
  func setNavigationItemHiddenTitle (title:String) {
    self.navigationItem.title = title
    if let barTintColor = self.navigationController?.navigationBar.barTintColor{
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: barTintColor]
    }
  }
  
  func setSecondStatusBar() {
    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
     statusBar.backgroundColor = UIColor.AppColors.primaryColor
   }
  
  func setBackButton() {
    self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back button")
    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back button")
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    self.navigationController?.navigationBar.setStyle(style: .solidNoShadow, tintColor: UIColor.AppColors.gray, forgroundColor: .white)
    
  }
  
  func setDefaultStatusBar() {
    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
     statusBar.backgroundColor = UIColor.white
  }
  
//  func showSelectionDialog(title: String, items : [CountryKPI], selectionHandler : ((CountryKPI, Int)->Void)? = nil) {
//
//    // Create our custom view controller programatically
//    let vc = PopupTableViewController()
//
//    vc.dialogTitle = title
//
//    // Create the PopupDialog with a completion handler,
//    // called whenever the dialog is dismissed
//    let popup = PopupDialog(viewController: vc, tapGestureDismissal: true) {
//      if (vc.selectedItem != nil && vc.selectedPosition != nil) {
//        selectionHandler?(vc.selectedItem!, vc.selectedPosition!)
//      }
//
//    }
    
//    // Create a cancel button for the dialog,
//    // including a button action
//    let cancel = DefaultButton(title: "cancel".localized()) {
//    }
//    
//    cancel.setTitleColor(UIColor.black, for: .normal)
//    cancel.titleLabel?.font = AppFont.boldFontNormal
//    
//    // Add the cancel button we just created to the dialog
//    popup.addButton(cancel)
//    
    // Moreover, we set a list of cities on our custom view controller
//    vc.items = items
    
    // We also pass a reference to our PopupDialog to our custom view controller
    // This way, we can dismiss and manipulate it from there
//    vc.popup = popup
    
    // Last but not least: present the PopupDialog
//    present(popup, animated: true, completion: nil)
//  }

//  func showOptionsDialog(items : [String], selectionHandler : ((String, Int)->Void)? = nil) {
//
//    // Create our custom view controller programatically
//    let vc = OptionsVC()
//
//
//    // Create the PopupDialog with a completion handler,
//    // called whenever the dialog is dismissed
//    let popup = PopupDialog(viewController: vc, tapGestureDismissal: true) {
//      if (vc.selectedItem != nil && vc.selectedPosition != nil) {
//        selectionHandler?(vc.selectedItem!, vc.selectedPosition!)
//      }
//
//    }

    //    // Create a cancel button for the dialog,
    //    // including a button action
    //    let cancel = DefaultButton(title: "cancel".localized()) {
    //    }
    //
    //    cancel.setTitleColor(UIColor.black, for: .normal)
    //    cancel.titleLabel?.font = AppFont.boldFontNormal
    //
    //    // Add the cancel button we just created to the dialog
    //    popup.addButton(cancel)
    //
    // Moreover, we set a list of cities on our custom view controller
//    vc.items = items
//
//    // We also pass a reference to our PopupDialog to our custom view controller
//    // This way, we can dismiss and manipulate it from there
//    vc.popup = popup
//
//    // Last but not least: present the PopupDialog
//    present(popup, animated: true, completion: nil)
//  }

  
//  func showImageDialog(image :UIImage) {
//
//    // Create our custom view controller programatically
//    let vc = ImageDialog()
//
//
//    // Create the PopupDialog with a completion handler,
//    // called whenever the dialog is dismissed
//    let popup = PopupDialog(viewController: vc, tapGestureDismissal: true)
//
//    // Moreover, we set a list of cities on our custom view controller
//    vc.image = image
//
//    // We also pass a reference to our PopupDialog to our custom view controller
//    // This way, we can dismiss and manipulate it from there
//    vc.popup = popup
//
//    // Last but not least: present the PopupDialog
//    present(popup, animated: true, completion: nil)
//  }
//
//
//  func showImageDialog(with url :String) {
//
//    // Create our custom view controller programatically
//    let vc = ImageDialog()
//
//
//    // Create the PopupDialog with a completion handler,
//    // called whenever the dialog is dismissed
//    let popup = PopupDialog(viewController: vc, tapGestureDismissal: true)
//
//    // Moreover, we set a list of cities on our custom view controller
//    vc.imageURL = url
//
//    // We also pass a reference to our PopupDialog to our custom view controller
//    // This way, we can dismiss and manipulate it from there
//    vc.popup = popup
//
//    // Last but not least: present the PopupDialog
//    present(popup, animated: true, completion: nil)
//  }

}

extension UIImageView {
  // function to get the proper height of image relative to the image width of screen
  //then update the constraint of height of UIImageview to the returned value
  
  func GetApectRatioHeight(ImageView:UIImageView)->CGFloat{
    let screenWidth = UIScreen.main.bounds.width
    
    if ImageView.image == nil {
      
      return 0
      
    }else {
      let ImageWidth = ImageView.image?.size.width
      let AspectRatio = (screenWidth/ImageWidth!) * (ImageView.image?.size.height)!
      return AspectRatio
    }
    
  }
}
extension Date {
  var millisecondsSince1970:Int {
    return Int((self.timeIntervalSince1970 * 1000.0).rounded())
  }
  
  init(milliseconds:Int) {
    self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
  }
}
extension UIView {
  public func makeToast(_ message: String,duration:TimeInterval, myCompletion:(() -> Void)?) {
    self.makeToast(message, duration: duration, position: .bottom, title: nil, image: nil, style: nil) { (_) in
           myCompletion?()
    }
  }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
