//
//  ViewController.swift
//  BuildYourVocabulary
//
//  Created by Brandon Hill on 5/23/22.
//

import UIKit

class WelcomeViewController: UIViewController, UISearchBarDelegate {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Welcome"
       
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

}

