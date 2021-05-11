//
//  HomeVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 07/03/21.
//

import UIKit
import SideMenu
import PagingTableView

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, PagingTableViewDelegate {
    
    var data = [PostList]()
    
    @IBOutlet weak var tableView: PagingTableView!
    
    @IBOutlet var sideMenuButton: UIButton!
    @IBOutlet weak var addPostButton: UIButton!
    @IBAction func searchButton(_ sender: Any) {
    }
    
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
        sideMenu?.presentDuration = 0.5
        self.tableView.pagingDelegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
    }
    func getStoriesApiCall(page: Int){
        GetStoriesRestManager.shared.getStories(page: page) { (response) in
            switch response{
            
            case .success(let response):
                let count = response.postList.count
                var startIndex = 0
                if self.data.count != 0 {
                    startIndex = self.data.count - 1
                }
                let endIndex = count + startIndex
                var indices = [IndexPath]()
                for i in startIndex..<endIndex {
                    indices.append(IndexPath(row: i, section: 0))
                }
                self.data.append(contentsOf: response.postList)
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indices, with: .none)
                self.tableView.endUpdates()
                self.tableView.scrollToRow(at: indices[0], at: UITableView.ScrollPosition.none, animated: false)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func didTapSideMenuButton(_ sender: Any) {
        
        self.present(sideMenu!, animated: true, completion: nil)
        
    }
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        
    }
    @IBAction func didTapAddPostButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddPostViewController") as! AddPostViewController
        let alertController = CustomAlertController(title: "Add post", message: nil, preferredStyle: .alert)
        alertController.preferredContentSize = UIApplication.shared.keyWindow?.frame.offsetBy(dx: 50, dy: 50).size ?? CGSize.zero
        alertController.setValue(controller, forKey: "contentViewController")
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        alertController.view.addConstraint(height)
        alertController.modalPresentationStyle = .overFullScreen
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alertController.addAction(UIAlertAction(title: "Publish", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        cell?.setData(data: data[indexPath.row])
        cell?.commentDelegate = self
        return cell!
    }
    
    func paginate(_ tableView: PagingTableView, to page: Int) {
        self.tableView.isLoading = true
        getStoriesApiCall(page: page)
        self.tableView.isLoading = false
    }
}

extension HomeVC: ShowCommentVC{
    func didShowCommentVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "CommentVC")
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        self.present(secondVC, animated: true, completion: nil)
    }
}


