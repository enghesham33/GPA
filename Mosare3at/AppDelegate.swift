//
//  AppDelegate.swift
//  Mosare3at
//
//  Created by Hesham Donia on 9/30/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Localize_Swift
import Material
import Firebase
import UserNotifications
import AlamofireNetworkActivityIndicator
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    public static var instance: AppDelegate!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Localize.setCurrentLanguage("ar")
        
        AppDelegate.instance = self
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.startDelay = 0.2
        NetworkActivityIndicatorManager.shared.completionDelay = 0.5
        UIApplication.shared.statusBarStyle = .lightContent
        
        FirebaseApp.configure()
        setUpNotification(application)
        startApplication()
        
        
        return true
    }
    
    /**
     This method called to setup receiving remote notifications from Firebase.
     - Parameter application: The application instance.
     */
    func setUpNotification(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        if let isLoggedIn = Defaults[.isLoggedIn], isLoggedIn {
            if let token = Messaging.messaging().fcmToken {
                sendFCMTokenToServer(fcmToken: token)
            }
        }
    }
    
    /**
     This method set the allignment of all used design components according to current language and set the root viewController according to loggedIn or not.
     */
    func startApplication() {
        
        switch Localize.currentLanguage() {
        case "ar":
            
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            FlatButton.appearance().semanticContentAttribute = .forceRightToLeft
            FlatButton.appearance().contentHorizontalAlignment = .right
            RaisedButton.appearance().semanticContentAttribute = .forceRightToLeft
            RaisedButton.appearance().contentHorizontalAlignment = .right
            Button.appearance().contentHorizontalAlignment = .right
            Button.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
            ErrorTextField.appearance().semanticContentAttribute = .forceRightToLeft
//            DropDown.appearance().semanticContentAttribute = .forceRightToLeft
            TextField.appearance().semanticContentAttribute = .forceRightToLeft
            Switch.appearance().semanticContentAttribute = .forceRightToLeft
            UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UISearchBar.appearance().semanticContentAttribute = .forceRightToLeft
            break
            
        case "en":
            Switch.appearance().semanticContentAttribute = .forceLeftToRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            FlatButton.appearance().semanticContentAttribute = .forceLeftToRight
            FlatButton.appearance().contentHorizontalAlignment = .left
            RaisedButton.appearance().contentHorizontalAlignment = .left
            RaisedButton.appearance().semanticContentAttribute = .forceLeftToRight
            Button.appearance().contentHorizontalAlignment = .left
            Button.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
            ErrorTextField.appearance().semanticContentAttribute = .forceLeftToRight
//            DropDown.appearance().semanticContentAttribute = .forceLeftToRight
            TextField.appearance().semanticContentAttribute = .forceLeftToRight
            UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UISearchBar.appearance().semanticContentAttribute = .forceLeftToRight
            break
            
        default:
            break
        }
        
        // setting the font and text color for tab bar items
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.AppColors.darkGray, NSAttributedString.Key.font: AppFont.font(type: .Bold, size: 12)], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.AppColors.primaryColor, NSAttributedString.Key.font: AppFont.font(type: .Bold, size: 12)], for: .selected)
        
        let navigationController = UINavigationController()
        
        navigationController.navigationBar.setStyle(style: .solid, tintColor: UIColor.white, forgroundColor: .black)
        
        if let loggedIn = Defaults[.isLoggedIn], loggedIn {
            if let userDic = Defaults[.user] {
                let user = User.getInstance(dictionary: userDic)
                if !user.takeTutorial {
                    self.window?.rootViewController = navigationController
                    navigationController.pushViewController(TutorialPagerVC.buildVC(), animated: false)
                } else {
                    self.window?.rootViewController = navigationController
                    navigationController.pushViewController(MainScreenVC.buildVC(), animated: false)
                    // go to main view controller that will contain the bottom tabs
                }
                
            } else {
                self.window?.rootViewController = navigationController
                navigationController.pushViewController(LoginVC.buildVC(), animated: false)
            }
        } else {
            self.window?.rootViewController = navigationController
            navigationController.pushViewController(LoginVC.buildVC(), animated: false)
        }
        
        window?.makeKeyAndVisible()
    }
    
    /**
     This method is called to play a sound when receive notificaion in forground.
     */
    func playSound() {
        // create a sound ID, in this case its the tweet sound.
        let systemSoundID: SystemSoundID = 1007
        
        // to play sound
        AudioServicesPlaySystemSound(systemSoundID)
    }
    
    /**
     This method is called to send the user's current FCM Token to be saved on server.
     */
    func sendFCMTokenToServer(fcmToken: String) {
        if Defaults[.isLoggedIn] != nil && Defaults[.isLoggedIn]! {
            let user: User = User.getInstance(dictionary: Defaults[.user]!)
            let loginPresenter = Injector.provideLoginPresenter()
            
            if let currentFCMToken = Defaults[.fcmToken] {
                loginPresenter.updateFCMToken(id: user.id, oldToken: currentFCMToken, newToken: fcmToken)
            } else {
                loginPresenter.registerFCMToken(id: user.id, token: fcmToken)
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: CommonConstants.backgroundStatus), object: nil)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: CommonConstants.forgroundStatus), object: nil)
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // forground
    // Receive displayed notifications for iOS 10 devices.
    /**
     This method is called when receive remote notification and the app in the forground state.
     - Parameter center: Instance of notification center.
     - Parameter notification: The notification object that contains the needed data.
     - Parameter completionHandler: What will happen after that function called.
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
    }
    
    // de elly sha3`ala m3 l background notifications
    /**
     This method is called when receive remote notification and click on it and the app in the background state.
     - Parameter center: Instance of notification center.
     - Parameter notification: The notification object that contains the needed data.
     - Parameter completionHandler: What will happen after that function called.
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
    }
}

extension AppDelegate : MessagingDelegate {
    
    /**
     This method is called when FCM token is refreshed by Firebase and refresh the server with the new Token.
     - Parameter messaging: Instance of Messaging.
     - Parameter fcmToken: The new FCM token.
     */
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        sendFCMTokenToServer(fcmToken: fcmToken)
    }
    
    /**
     This method is called when receive new message from Fireabse.
     - Parameter messaging: Instance of Messaging.
     - Parameter remoteMessage: The new message object contains the received data.
     */
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        
    }
}


