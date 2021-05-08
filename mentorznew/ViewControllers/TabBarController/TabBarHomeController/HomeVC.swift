//
//  HomeVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 07/03/21.
//

import UIKit
import SideMenu

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
   func numberOfSections(in tableView: UITableView) -> Int {
          return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
            // cell?.cellLabel?.text = cellLabelText[indexPath.row]
            return cell!
    }
    @IBOutlet var tableView: UITableView!
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
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
}




