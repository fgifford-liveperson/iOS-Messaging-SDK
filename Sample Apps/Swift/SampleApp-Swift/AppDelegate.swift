//
//  AppDelegate.swift
//  SampleApp-Swift
//
//  Created by Nimrod Shai on 2/23/16.
//  Copyright © 2016 LivePerson. All rights reserved.
//

import UIKit
import LPMessagingSDK
import UserNotifications

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Override point for customization after application launch.
        
        // Register for push remote push notifications
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        LPMessagingSDK.instance.registerPushNotifications(token: deviceToken, notificationDelegate: self)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        LPMessagingSDK.instance.handlePush(userInfo)
    }

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    {
        // Get URL components from the incoming user activity
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let incomingURL = userActivity.webpageURL,
            let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
                return false
        }

        // Check for specific URL components that you need
        guard let path = components.path else {
                return false
        }
        debugPrint("path = \(path)")
        return true
    }
}

//MARK: - LPMessagingSDKNotificationDelegate
/*
  For more information on `LPMessagingSDKNotificationDelegate` see:
      https://developers.liveperson.com/mobile-app-messaging-sdk-for-ios-customizing-toast-notifications.html
 */
extension AppDelegate: LPMessagingSDKNotificationDelegate {
    func LPMessagingSDKNotification(shouldShowPushNotification notification: LPNotification) -> Bool {
        return true
    }
    
    func LPMessagingSDKNotification(didReceivePushNotification notification: LPNotification) {
        
    }
    
    func LPMessagingSDKNotification(notificationTapped notification: LPNotification) {
        
    }
}
