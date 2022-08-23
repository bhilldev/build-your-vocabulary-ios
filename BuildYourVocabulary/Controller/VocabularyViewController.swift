//
//  VocabularyViewController.swift
//  BuildYourVocabulary
//
//  Created by Brandon Hill on 5/24/22.
//

import UIKit

class VocabularyViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var wordManager = WordManager()
    
    var wordArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vocabulary"
        // Do any additional setup after loading the view.
        mySearchBar.delegate = self
        wordManager.delegate = self
        tableView.dataSource = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        wordArray.append(mySearchBar.text!)
//        for word in wordArray {
//            print(word)
//        }
        wordManager.fetchWordDefinition(word: mySearchBar.text!)
        tableView.reloadData()
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

extension VocabularyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
    }
}
extension VocabularyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = wordArray[indexPath.row]
        return cell
    }
}
