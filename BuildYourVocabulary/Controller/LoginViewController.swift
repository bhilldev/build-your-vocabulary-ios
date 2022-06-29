//
//  LoginViewController.swift
//  BuildYourVocabulary
//
//  Created by Brandon Hill on 5/24/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    

    @IBAction func logInPressed(_ sender: UIButton) {
        
        if let email = userEmail.text, let password = userPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    print("Segue executed")
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                }
            }
        }
        }
    
}
