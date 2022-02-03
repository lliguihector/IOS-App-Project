//
//  AppDelegate.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/10/21.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications





@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        
        ///Notifications Code
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {success, _ in
            
            
            guard success else{
                return
            }
            
            
            print("Success in APNS registry")
        }
       
        
        application.registerForRemoteNotifications()
            
            
        Thread.sleep(forTimeInterval: 0.5)
        
        
        var initialViewController: UIViewController?
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
      
        if UserDefaults.standard.object(forKey: constant.token) != nil{
            print("State: Loged In")
            
            
         
       
        }else{
            initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC")
            print("State: Not Loged In")
           
        }
        
        
         self.window = UIWindow(frame: UIScreen.main.bounds)
         self.window?.rootViewController = initialViewController
         self.window?.makeKeyAndVisible()
        
        NetworkMonitor.shared.startMonitoring()
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token,  _ in
            
            guard let token = token else{
                return
            }
            print("Token: \(token)")
        }
    }
    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        print("new scene")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        
        print("User Discarded Scene")
    }


}

