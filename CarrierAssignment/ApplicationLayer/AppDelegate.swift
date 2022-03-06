//
//  AppDelegate.swift
//  CarrierAssignment
//
//  Created by Apple on 05/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var autorizatioToken: String?
    var isServerReachable: Bool = false
    let reachability = try! Reachability()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
        // Override point for customization after application launch.
        return true
    }
    
    //MARK: -->Reachability check
    //----To check the internet connectivity in the app
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        NotificationCenter.default.post(name: .checkForOfflineMode, object: reachability)
        
        switch reachability.connection {
        case .wifi:
            isServerReachable = true
            print("Reachable via WiFi")
        case .cellular:
            isServerReachable = true
            print("Reachable via Cellular")
        case .unavailable:
            isServerReachable = false
            print("Network not reachable")
        }
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
    
    
}

extension Notification.Name {
    static var checkForOfflineMode: Notification.Name {
        return .init(rawValue: "Reachability.checkForOfflineMode")
    }
}
