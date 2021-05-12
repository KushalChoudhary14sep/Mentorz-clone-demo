//
//  CommentVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 09/05/21.
//

import Foundation
import UIKit
import PagingTableView

class CommentVC : UIViewController, UITableViewDelegate, UITableViewDataSource, PagingTableViewDelegate {
    
    var datasource : SharePostID?
    var data = [CommentList]()
    private let refreshControl = UIRefreshControl()

   
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: PagingTableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        self.tableView.pagingDelegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .red
        self.tableView.addSubview(self.refreshControl)
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.data = [CommentList]()
        self.tableView.reloadData()
        paginate(self.tableView, to: 0)
        refreshControl.endRefreshing()
    }
    
    func getCommentsApiCall(page: Int, postid: Int){
        GetStoriesRestManager.shared.getComments(page: page, postid: postid) { (response) in
            switch response{
            
            case .success(let response):
                let count = response.commentList.count
                var startIndex = 0
                if self.data.count != 0 {
                    startIndex = self.data.count - 1
                }
                let endIndex = count + startIndex
                var indices = [IndexPath]()
                for i in startIndex..<endIndex {
                    indices.append(IndexPath(row: i, section: 0))
                }
                self.data.append(contentsOf: response.commentList)
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indices, with: .none)
                self.tableView.endUpdates()
                self.tableView.scrollToRow(at: indices[0], at: UITableView.ScrollPosition.none, animated: false)
           
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    
 
        
        
    
    
    @IBAction func didTapOnBackArrowButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func didTapOnPostButton(_ sender: Any) {
       
        let text = self.textView.text!
        
        GetStoriesRestManager.postComment(request: PostCommentRequest(comment: text), postid: (self.datasource?.data?.postID)!) { (response) in
            switch response {
            case .success(let response):
                
                let tempdata = CommentList(commentID: response.commentID, comment: response.comment, commentTime: response.commentTime, userID: response.userID, userName: (UserManager.shared.user?.userName)!, lastName: "", lresID: "", hresID: "", name: (UserManager.shared.user?.userName)!)
                self.data.append(tempdata)
                self.tableView.insertRows(at: [IndexPath(row: self.data.count - 1, section: 0)], with: .automatic)
                self.tableView.endUpdates()
                self.textView.text = ""
                self.datasource?.commentsLabel.text = "\(((self.datasource?.data?.commentCount) ?? 0) + 1) Comments"
                self.datasource?.data?.commentCount! += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell
        if data.count > indexPath.row {
            cell?.setData(data: data[indexPath.row])
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func paginate(_ tableView: PagingTableView, to page: Int) {
        self.tableView.isLoading = true
        getCommentsApiCall(page: page, postid: (self.datasource?.data?.postID)!)
        self.tableView.isLoading = false
    }

}
