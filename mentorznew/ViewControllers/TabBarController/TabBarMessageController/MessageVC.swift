//
//  MessageVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 08/03/21.
//

import UIKit
import SideMenu
import PageMenu




class MessageVC: UIViewController, CAPSPageMenuDelegate {
   

    var pageMenu : CAPSPageMenu?
    
    var sideMenu : SideMenuNavigationController?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sideBar = storyboard.instantiateViewController(identifier: "SideMenuViewController")
        sideMenu = SideMenuNavigationController(rootViewController: sideBar)
        sideMenu?.navigationBar.isHidden = true
        sideMenu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        
        sideMenu?.menuWidth = self.view.frame.size.width * 3/4
        
        
        var controllerArray : [UIViewController] = []
        
       // Instantiate View Controllers - 3
        let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
        let chats = storyboard1.instantiateViewController(identifier: "ConnectingVC")
        let storyboard2 = UIStoryboard(name: "Main", bundle: nil)
        let requests = storyboard2.instantiateViewController(identifier: "RequestVC")
        let storyboard3 = UIStoryboard(name: "Main", bundle: nil)
        let session = storyboard3.instantiateViewController(identifier: "SessionVC")
        
        controllerArray.append(chats)
        controllerArray.append(requests)
        controllerArray.append(session)

        let parameters: [CAPSPageMenuOption] = [
            .menuHeight(65),
            .scrollMenuBackgroundColor(UIColor.white),
            .selectionIndicatorColor(UIColor.red),
            .selectedMenuItemLabelColor(UIColor.black),
            .unselectedMenuItemLabelColor(UIColor.lightGray),
            .menuItemSeparatorColor(UIColor.lightGray),
            .useMenuLikeSegmentedControl(true),
            .menuItemFont(UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)),
            .menuItemSeparatorWidth(1.5),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.3)
        
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 107.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)

        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.delegate = self
        
        
    }
    
    
    @IBAction func didTapSideMenuButton(_ sender: Any) {
   
        self.present(sideMenu!, animated: true, completion: nil)

    
    }
    private func willMoveToPage(controller: UIViewController, index: Int){}

    private func didMoveToPage(controller: UIViewController, index: Int){}

}
