//
//  AppDelegate.swift
//  iOS_Challenge
//
//  Created by Viraj Thenuwara on 3/9/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let homeViewController = HomeTableViewController()
        window?.rootViewController = homeViewController
        window?.makeKeyAndVisible()
        return true
    }


}

