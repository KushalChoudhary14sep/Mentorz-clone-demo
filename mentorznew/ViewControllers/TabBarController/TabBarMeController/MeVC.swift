//
//  MeVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 08/03/21.
//

import UIKit
import SideMenu

class MeVC: UIViewController {

    var cellLabelText =
        ["No posts available"]
        
   
    @IBOutlet weak var meSceneTableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var headerImageView: UIImageView!
    

    @IBOutlet weak var profileImageButton: UIButton!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    @IBOutlet weak var personDeatilLabel: UILabel!
    
    @IBOutlet weak var personalSkillButton: UIButton!
    
    
    @IBOutlet weak var profileReviewButton: UIButton!
    
    @IBOutlet weak var myScheduleBUTTON: UIButton!
    
    @IBOutlet weak var followerButton: UIButton!
    
    @IBOutlet weak var followingButton: UIButton!
    
    @IBOutlet weak var mentorButton: UIButton!
    
    @IBOutlet weak var menteeButon: UIButton!
    
  var sideMenu : SideMenuNavigationController?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false

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
           
        self.meSceneTableView.delegate = self
        self.meSceneTableView.dataSource = self
        self.meSceneTableView.register(UINib(nibName: "MeSceneTableViewCell", bundle: nil), forCellReuseIdentifier: "MeSceneTableViewCell")
        self.meSceneTableView.rowHeight = 600
        let header = headerView
        meSceneTableView.tableHeaderView = header
        myScheduleBUTTON.layer.cornerRadius = 5
        
        self.tabBarController?.tabBar.isHidden = false

}
    
    @IBAction func didTapSideMenuButton(_ sender: Any) {
        self.present(sideMenu!, animated: true, completion: nil)
    
    }
    @IBAction func didTapEditButton(_ sender: Any) {
   
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let secondVC = storyboard.instantiateViewController(identifier: "EditProfileVC")
        secondVC.modalPresentationStyle = .fullScreen
              secondVC.modalTransitionStyle = .crossDissolve
        present(secondVC, animated: true, completion: nil)
    
    }
    @IBAction func didTapProfileImageButton(_ sender: Any) {
    }
    
    @IBAction func didTapSkillButton(_ sender: Any) {
    }
    
    @IBAction func didTapReviewButton(_ sender: Any) {
    }
    @IBAction func didTapMyScheduleButton(_ sender: Any) {
    }
    
    @IBAction func didTapFollowerButton(_ sender: Any) {
    }
    @IBAction func didTapFollowingButton(_ sender: Any) {
    }
    @IBAction func didTapMentorButton(_ sender: Any) {
    }
    
    @IBAction func didTapMenteeButton(_ sender: Any) {
    }
    
    @IBAction func didTapLinkFBButton(_ sender: Any) {
    }
    
    @IBAction func didTapFBButton(_ sender: Any) {
    }
    
    @IBAction func didTapLinkLIButton(_ sender: Any) {
    }
    
    @IBAction func didTapLIButton(_ sender: Any) {
    }
    

}

extension MeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellLabelText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeSceneTableViewCell", for: indexPath) as? MeSceneTableViewCell
            cell?.cellLabel?.text = cellLabelText[indexPath.row]
            return cell!
    }
    

}
