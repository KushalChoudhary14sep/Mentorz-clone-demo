//
//  File.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 16/03/21.
//

import Foundation
import UIKit

class AddPostViewController: UIViewController, UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var addPostView: UIView!
    @IBOutlet weak var postDetailTextView: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var turnOnCameraButton: UIButton!
    @IBOutlet weak var textCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPostView.layer.masksToBounds = true
        addPostView.clipsToBounds = true
        addPostView.layer.cornerRadius = 10
        postDetailTextView.layer.borderWidth = 1
        postDetailTextView.layer.borderColor = UIColor.gray.cgColor
        postDetailTextView.layer.cornerRadius = 5
        postDetailTextView.delegate = self
       
        _ = UITapGestureRecognizer(target: self, action: #selector(didTapTurnOnCameraButton))
    }
  

    @IBAction func didTapAddImageButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let secondVC = storyboard.instantiateViewController(identifier: "AddImageViewController")
        secondVC.modalPresentationStyle = .fullScreen
              secondVC.modalTransitionStyle = .crossDissolve

        present(secondVC, animated: true, completion: nil)
    }
   
    @IBAction func didTapTurnOnCameraButton(_ sender: Any) {
        let imgPicker = UIImagePickerController()
           imgPicker.delegate = self
           imgPicker.sourceType = .camera
           imgPicker.allowsEditing = false
           imgPicker.showsCameraControls = true
           self.present(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey :
    Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as?
       UIImage {
             self.postImageView.image = img
             picker.dismiss(animated: true, completion: nil)
          }
          else {
             print("error")
          }
       }
   
   
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(textView == postDetailTextView){
           let strLength = textView.text?.count ?? 0
           let lngthToAdd = text.count
           let lengthCount = strLength + lngthToAdd
           self.textCountLabel.text = "\(lengthCount)/140"
        }
        return true
    }
    
}
