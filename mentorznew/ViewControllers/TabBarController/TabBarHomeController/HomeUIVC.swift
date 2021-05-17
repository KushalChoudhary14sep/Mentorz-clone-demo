////
////  HomeUIVC.swift
////  mentorznew
////
////  Created by Kushal Choudhary on 14/05/21.
////
//
//import Foundation
//import  UIKit
//import SideMenu
//import PagingTableView
//import ExpandableLabel
//
//class HomeUIVC: NSObject, UITableViewDataSource, UIPopoverPresentationControllerDelegate, PagingTableViewDelegate {
//    weak var view: HomeController!{
//        didSet{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                 
//            let sideBar = storyboard.instantiateViewController(identifier: "SideMenuViewController")
//            sideMenu = SideMenuNavigationController(rootViewController: sideBar)
//            sideMenu?.navigationBar.isHidden = true
//            sideMenu?.leftSide = true
//            SideMenuManager.default.addPanGestureToPresent(toView: self.view as! UIView)
//            SideMenuManager.default.leftMenuNavigationController = sideMenu
//            
//            sideMenu?.menuWidth = self.view.superView.frame.size.width * 3/4
//            sideMenu?.presentDuration = 0.5
//            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//            refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
//            refreshControl.tintColor = .red
//            view.tableView.addSubview(self.refreshControl)
//            view.tableView.pagingDelegate = self
//            view.tableView.dataSource = self
//            view.tableView.separatorStyle = .none
//            view.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
//            view.tableView.rowHeight = UITableView.automaticDimension
//            view.tableView.bounces = false
//        }
//    }
//    private let refreshControl = UIRefreshControl() 
//    var sideMenu : SideMenuNavigationController?
//    @objc func refresh(_ sender: AnyObject) {
//        // Code to refresh content
//        self.data = [PostList]()
//        view.tableView.reloadData()
//        paginate(self.tableView, to: 0)
//        refreshControl.endRefreshing()
//    }
//    
//}
