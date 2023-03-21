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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavBarAppearance(
            backgroundColor: UIColor.darkGray,
            foregroundColor: UIColor.black
        )
        
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            // The back button was pressed or interactive gesture used
            self.setNavBarAppearance(
                backgroundColor: UIColor.systemGray2,
                foregroundColor: UIColor.black
            )
        }
    }
    
    
    
    
    func setNavBarAppearance(backgroundColor: UIColor, foregroundColor: UIColor) {
        // This will change the navigation bar background color
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
                
        // This will alter the navigation bar title appearance
        let titleAttribute = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: foregroundColor]
        
        appearance.largeTitleTextAttributes = titleAttribute
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        
        if let email = userEmail.text, let password = userPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                }
            }
        }
        }
    
}
