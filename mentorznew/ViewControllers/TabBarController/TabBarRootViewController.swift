//
//  HomeVCViewController.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 03/03/21.
//

import UIKit

class TabBarRootViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems(self.tabBar)
        // Do any additional setup after loading the view.
    }
    
    private func setTabBarItems(_ tabBar : UITabBar) {
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = true
        tabBar.itemPositioning = .fill
        tabBar.tintColor = UIColor.red
        UITabBar.appearance().tintColor = .red
        tabBar.unselectedItemTintColor = appColor.tabBarItemColor
        tabBar.sizeToFit()
    }
}
