//
//  AppDelegate.swift
//  FlashSwipe
//
//  Created by Moto on 8/13/15.
//  Copyright © 2015 mootoh.net. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func createNotificationAction() -> UIMutableUserNotificationAction {
        let action = UIMutableUserNotificationAction()
        action.identifier = "ANSWER_ACTION"
        action.title = "どれくらい長い文章が書けるものだろうか?"
        action.activationMode = UIUserNotificationActivationMode.Background
        action.authenticationRequired = true
        action.destructive = false
        return action
    }
    
    func createNotificationCategory(action: UIMutableUserNotificationAction) -> UIMutableUserNotificationCategory {
        let category = UIMutableUserNotificationCategory()
        category.identifier = "ANSWER"
        category.setActions([action], forContext: UIUserNotificationActionContext.Default)
        category.setActions([action], forContext: UIUserNotificationActionContext.Minimal)
        return category
    }
    
    func registerNotification(action: UIMutableUserNotificationAction, category: UIMutableUserNotificationCategory) {
        let types : UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Sound]
        let settings = UIUserNotificationSettings(forTypes: types, categories: NSSet(object: category) as? Set<UIUserNotificationCategory>)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
    func scheduleNotification(category: UIMutableUserNotificationCategory) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        if UIApplication.sharedApplication().scheduledLocalNotifications!.count == 0 {
            let notification = UILocalNotification()
            notification.alertBody = "Flash Card"
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.fireDate = NSDate()
            notification.category = category.identifier
            notification.repeatInterval = NSCalendarUnit.Minute
            
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    func setupNotification() {
        let action = createNotificationAction()
        let category = createNotificationCategory(action)
        registerNotification(action, category:category)
        scheduleNotification(category)
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupNotification()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

