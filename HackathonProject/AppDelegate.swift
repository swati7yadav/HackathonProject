//
//  AppDelegate.swift
//  HackathonProject
//
//  Created by Swati Yadav on 13/08/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let feedListViewController = FeedListViewController()
        let navigationController = UINavigationController(rootViewController: feedListViewController)
        window?.rootViewController = navigationController
        return true
    }
}

