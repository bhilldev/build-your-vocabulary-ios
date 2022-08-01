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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("hello")
    }

}

