  import UIKit
  
  
  class OTPVerificationViewController: UIViewController {

       var verifyid : String = ""
       let userdefault = UserDefaults()

       @IBOutlet weak var OTPVerifyCode: UITextField!

       override func viewDidLoad() {
           super.viewDidLoad()

           let valust = self.userdefault.dictionary(forKey: "verifyID")
           print(verifyid)

       }

       @IBAction func verificationSubmitButton(_ sender: Any) {

            guard let verifycode = OTPVerifyCode.text else {return}
            let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verifyid, verificationCode: verifycode)
            Auth.auth().signInAndRetrieveData(with: credentials) { (result, error) in
            if error == nil {
                 if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ServiceViewControllerID") as? ServiceViewController {

                 UIApplication.shared.keyWindow?.rootViewController = viewController
                 self.dismiss(animated: true, completion: nil)
             }
           } else{
               print(error?.localizedDescription)
        }
    }
}
  }
