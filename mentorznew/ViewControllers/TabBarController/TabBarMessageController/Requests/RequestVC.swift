//
//  RequestViewController.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 17/03/21.
//

import UIKit
import PageMenu

class RequestVC: UIViewController, CAPSPageMenuDelegate {

    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var controllerArray : [UIViewController] = []
        
        let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
        let sentRequest = storyboard1.instantiateViewController(identifier: "SentRequestViewController")
        let storyboard2 = UIStoryboard(name: "Main", bundle: nil)
        let recievedRequest = storyboard2.instantiateViewController(identifier: "RecievedRequestViewController")
       
      
        controllerArray.append(sentRequest)
        controllerArray.append(recievedRequest)
        
        let parameters: [CAPSPageMenuOption] = [
            .menuHeight(60),
            .scrollMenuBackgroundColor(UIColor.white),
            .selectionIndicatorColor(UIColor.red),
            .selectedMenuItemLabelColor(UIColor.black),
            .unselectedMenuItemLabelColor(UIColor.lightGray),
            .addBottomMenuHairline(true),
            .bottomMenuHairlineColor(UIColor.red),
            .menuItemSeparatorColor(UIColor.lightGray),
            .useMenuLikeSegmentedControl(true),
            .menuItemFont(UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)),
            .menuItemSeparatorWidth(1.5),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.3)
        
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)

        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.delegate = self
        
       
    }
    
    private func willMoveToPage(controller: UIViewController, index: Int){}

    private func didMoveToPage(controller: UIViewController, index: Int){}
    

}
