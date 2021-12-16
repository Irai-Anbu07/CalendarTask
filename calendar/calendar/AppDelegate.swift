//
//  AppDelegate.swift
//  calendar
//
//  Created by iraiAnbu on 29/11/21.
//

import UIKit
import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        // Do whatever you want when the user tapped on a notification
        // If you are waiting for specific data from the notification
        // (e.g., key: "target" and associated with "value"),
        // you can capture it as follows then do the navigation:
        
        // You may print `userInfo` dictionary, to see all data received with the notification.
        let userInfo = response.notification.request.content.userInfo as? [String:[String]]
        
        let values = userInfo?.values.first
        
        coordinateToSomeVC(data: values ?? ["","",""])
        
        
        completionHandler()
    }
    
    
    
    private func coordinateToSomeVC(data:[String])
    {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        
        
        let calendarViewController = calendarViewController()
        
        let secound = newEventViewController()
        
        let title = data[0]
        let eventTime = data[1]
        let alert = data[2]
        
        secound.textFieldTitle = title
        secound.eventTime = eventTime
        secound.alert = alert
        
        
        let controller = UINavigationController(rootViewController: calendarViewController)
        
        controller.viewControllers = [calendarViewController,secound ]
        
        controller.modalPresentationStyle = .overCurrentContext
        
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
    
    
}

