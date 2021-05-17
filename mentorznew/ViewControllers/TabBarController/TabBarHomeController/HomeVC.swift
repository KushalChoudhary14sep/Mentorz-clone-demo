//
//  HomeVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 07/03/21.
//

import UIKit
import SideMenu
import PagingTableView
import ExpandableLabel



class HomeVC: UIViewController, UITableViewDataSource, UIPopoverPresentationControllerDelegate, PagingTableViewDelegate {
    
    var data = [PostList]()
    private let refreshControl = UIRefreshControl()
    var sideMenu : SideMenuNavigationController?
    
    @IBOutlet weak var tableView: PagingTableView!
    @IBOutlet var sideMenuButton: UIButton!
    @IBOutlet weak var addPostButton: UIButton!
   
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
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .red
        self.tableView.addSubview(self.refreshControl)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh content
        self.data = [PostList]()
        self.tableView.reloadData()
        paginate(self.tableView, to: 0)
        refreshControl.endRefreshing()
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
    
    @IBAction func searchButton(_ sender: Any) {
        
    }
    
    @IBAction func didTapSideMenuButton(_ sender: Any) {
        
        self.present(sideMenu!, animated: true, completion: nil)
        
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
        cell?.postDescriptionLabel.delegate = self
        cell?.commentDelegate = self
        cell?.shareDelegate = self
        return cell!
    }
    
    func paginate(_ tableView: PagingTableView, to page: Int) {
        
        self.tableView.isLoading = true
        if self.tableView.isLoading == true{
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .red
           spinner.startAnimating()
           spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
        }else {
            self.tableView.tableFooterView?.isHidden = true
       
        }
        getStoriesApiCall(page: page)
        self.tableView.isLoading = false
        self.tableView.reloadData()
        
    }
}

extension HomeVC: ShowCommentVC{
    func didShowCommentVC(cell : TableViewCell) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "CommentVC") as? CommentVC
        secondVC?.datasource = cell
        secondVC!.modalPresentationStyle = .fullScreen
        secondVC!.modalTransitionStyle = .crossDissolve
        self.present(secondVC!, animated: true, completion: nil)
    }
}


extension HomeVC: ShowSharePopOver{
    
    
    func didShowSharePopOver(post: PostList) {
        let url = URL(string: "https://www.mentorz.com/stories/\(post.postID!)")
        let content = post.content.contentDescription ?? "null"
        let activityVC = UIActivityViewController(activityItems: [url as Any, content], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = view.self
        present(activityVC, animated: true, completion: nil)
    }
}

extension HomeVC : ExpandableLabelDelegate {
    func willExpandLabel(_ label: ExpandableLabel) {
        tableView.beginUpdates()
    }
    func didExpandLabel(_ label: ExpandableLabel) {
        tableView.endUpdates()
    }
    func willCollapseLabel(_ label: ExpandableLabel) {
        tableView.beginUpdates()
    }
    func didCollapseLabel(_ label: ExpandableLabel) {
        tableView.endUpdates()
    }
}
