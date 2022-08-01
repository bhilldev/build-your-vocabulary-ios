//
//  VocabularyViewController.swift
//  BuildYourVocabulary
//
//  Created by Brandon Hill on 5/24/22.
//

import UIKit

class VocabularyViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    var wordManager = WordManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vocabulary"
        // Do any additional setup after loading the view.
        mySearchBar.delegate = self
        wordManager.delegate = self
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        wordManager.fetchWordDefinition(word: mySearchBar.text!)
    }
}

extension VocabularyViewController: WordManagerDelegate {
    func didUpdateWord(_ wordManager: WordManager, word: WordModel) {
        DispatchQueue.main.async {
            print(word.wordDefinition)
        }
    }
    func didFailWithError(error: Error) {
        print("error is \(error)")
    }
}
