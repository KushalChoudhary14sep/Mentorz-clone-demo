//
//  ViewController.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 20/02/21.
//

import UIKit

class ViewController: UIViewController {
   
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var signUpButton: LoginSignupButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
 
   
    var dataOfImg = [ UIImage(named: "logo-1"), UIImage(named: "2_img"), UIImage(named: "3_img"), UIImage(named: "4_img")  ]
    var dataOfLabl = ["Expand your Horizons", "Become a mentor and help others grow", "Match with mentors with the expertise you need", "Connect and Learn"]

    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.register(UINib(nibName: "CollectionViewCellTopLabel", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCellTopLabel")
        
        collectionView.register(UINib(nibName: "CollectionViewCellBottomLabel", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCellBottomLabel")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        pageControl.numberOfPages = 4
        //pageControl.backgroundStyle = .automatic
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .lightGray
        collectionView!.collectionViewLayout = layout
        collectionView.backgroundColor = UIColor.clear
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.contentMode = .scaleToFill
        collectionView.reloadData()
       // setTimer()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

    }
    
//    func setTimer() {
//        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true);
//    }
//
//    @objc func autoScroll(_ timer1: Timer) {
//
//        if pageControl.currentPage == pageControl.numberOfPages-1 {
//            pageControl.currentPage = 0
//            let indexPath = IndexPath(item: 0, section: 0)
//            self.collectionView.scrollToItem(at: [indexPath.row], at: .right, animated: true)
//        } else {
//            pageControl.currentPage += 1
//            let indexPath = IndexPath(item : pageControl.currentPage, section: 0)
//           self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
//        }
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(collectionView.frame.size.width)
    }
   
  
    
    @IBAction func didTapSignupButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle:.main)
        let vc = storyboard.instantiateViewController(identifier: "SignupDetailsViewController") as! SignupDetailsViewController
        AppDelegate().shared().window?.rootViewController = vc
        AppDelegate().shared().window?.makeKeyAndVisible()
           }
        
    @IBAction func didTapAlreadyRegisteredLoginButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle:.main)
        let vc = storyboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        AppDelegate().shared().window?.rootViewController = vc
        AppDelegate().shared().window?.makeKeyAndVisible()
    
    }

}
    

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width-10, height: collectionView.frame.size.height-10)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataOfImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellBottomLabel", for: indexPath) as? CollectionViewCellBottomLabel else { return UICollectionViewCell()  }
            cell.backgroundColor = UIColor.clear
            cell.imageOfBottomLabel.image = dataOfImg[indexPath.row]
            cell.labelOfBottomLabel.text = dataOfLabl[indexPath.row]
            return cell
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellTopLabel", for: indexPath) as? CollectionViewCellTopLabel else { return UICollectionViewCell()  }
            cell.backgroundColor = UIColor.clear
            cell.imageOfTopLabel.image = dataOfImg[indexPath.row]
            cell.labelOfTopLabel.text = dataOfLabl[indexPath.row]
            return cell
        }
    
    }

    
}
