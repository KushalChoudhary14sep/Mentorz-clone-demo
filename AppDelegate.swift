//
//  AppDelegate.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 20/02/21.
//
import IQKeyboardManagerSwift
import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        let storyboard = UIStoryboard(name: "Main", bundle:.main)
        if UserManager.shared.isUserLoggedin {
            let vc = storyboard.instantiateViewController(identifier: "TabBarRootViewController") as! TabBarRootViewController
            self.shared().window?.rootViewController = vc
            self.shared().window?.makeKeyAndVisible()
        }else{
            let vc = storyboard.instantiateViewController(identifier: "SplashViewController") as! ViewController
            self.shared().window?.rootViewController = vc
            self.shared().window?.makeKeyAndVisible()
        }
        ImageViewerDataSource.shared.createDirectory()
        return true
    }
    func shared() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }


}

