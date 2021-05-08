//
//  TabBarHomeController.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 05/03/21.
//

import Foundation
import UIKit

class HomeVC: UIViewController! {
   
    

    @IBOutlet var tabBarTableView: UITableView!
    
    

  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarTableView.delegate = self
        self.tabBarTableView.dataSource = self
       
        self.tabBarTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
       // self.tabBarTableView.rowHeight = 80
    }
}





    extension HomeVC: UITableViewDelegate, UITableViewDataSource {
        
      
        func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1 //cellLabelText.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
         //   cell?.cellLabel?.text = cellLabelText[indexPath.row]
            return cell!
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
        }

}
