//
//  SignInViewController.swift
//  ChatAppProject
//


import UIKit
import FirebaseAuth
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var myNameTextField: UITextField!
    
     var myProfile : Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? AkciiViewController, let myProfile = self.myProfile {
            controller.myProfile = myProfile
            
        }
    }
    
    
    @IBAction func goButtonAction(_ sender: Any) {
        
        
        Auth.auth().signInAnonymously { (result, error) in
            if error != nil {
                print("ERROR WHILE LOGGIN IN")
            }else {
                if let uid = result?.user.uid, let myName = self.myNameTextField.text {
                    
                    let db = Firestore.firestore()
                    
                    let profile = Profile()
                    profile.name = myName
                    profile.profileID = uid
                    self.myProfile = profile
                    
                    db.collection("profiles").document(uid).setData(profile.params)
                    self.performSegue(withIdentifier: "showAkciiViewController", sender: nil)
            }
        }
        }
        
    }

}
