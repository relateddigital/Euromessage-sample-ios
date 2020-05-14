//
//  AppDelegate.swift
//  EuromsgTest
//
//  Created by Egemen on 29.04.2020.
//  Copyright © 2020 Egemen. All rights reserved.
//

import UIKit
import Euro_IOS


//var lo : [UIApplication.LaunchOptionsKey: Any]? = nil
//var ui = [AnyHashable : Any]()
//var ui2 = [AnyHashable : Any]()
//var ui3 = [AnyHashable : Any]()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var deviceTokenString = ""

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        EuroManager.sharedManager("EuromsgTest")?.setDebug(true)
        EuroManager.sharedManager("EuromsgTest")?.registerForPush()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print(deviceToken)
        deviceTokenString = deviceToken.map{ String(format: "%02x", $0) }.joined().replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "");
        print("Got token data! \(deviceTokenString)")
        
        ///Burada bulunan setUserKey ve setUserEmail ilk başta boş gelebilir. Kullanıcı anonim olarak sisteme kayıt olur. Daha sonra login veya signup işleminde dolu gönderdiğinizde kayıtlı kullanıcı olarak değiştirilir.
        EuroManager.sharedManager("EuromsgTest")?.setUserKey("umut@visilabs.com")
        EuroManager.sharedManager("EuromsgTest")?.setUserEmail("umut@visilabs.com")
        EuroManager.sharedManager("EuromsgTest")?.addParams("emailPermit", value: "Y")
        EuroManager.sharedManager("EuromsgTest")?.addParams("gsmPermit", value: "Y")
        EuroManager.sharedManager("EuromsgTest")?.addParams("pushPermit", value: "Y")
        EuroManager.sharedManager("EuromsgTest").registerToken(deviceToken)
        EuroManager.sharedManager("EuromsgTest").synchronize()

    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification fetchCompletionHandler userInfo \(userInfo)")
        EuroManager.sharedManager("EuromsgTest")?.handlePush(userInfo)
    }
    
    
    // MARK: UISceneSession Lifecycle

    /*
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
*/

}

