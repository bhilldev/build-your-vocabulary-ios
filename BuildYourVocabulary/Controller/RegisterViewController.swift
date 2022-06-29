//
//  RegisterViewController.swift
//  BuildYourVocabulary
//
//  Created by Brandon Hill on 5/24/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = userEmail.text, let password = userPassword.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "registerSegue", sender: self)
                }
            }
        }
        
    }
    

}
