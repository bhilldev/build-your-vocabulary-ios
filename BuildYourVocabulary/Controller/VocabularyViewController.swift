//
//  VocabularyViewController.swift
//  BuildYourVocabulary
//
//  Created by Brandon Hill on 5/24/22.
//

import UIKit

struct cellData {
    var opened = Bool()
    var searchedWord = String()
    var searchedWordDefinition = String()
}
class VocabularyViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var wordManager = WordManager()
    var tableViewData = [cellData]()
    var searchBarWord: String = ""
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vocabulary"
        // Do any additional setup after loading the view.
        wordManager.delegate = self
        
        mySearchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBarWord = mySearchBar.text!
        wordManager.fetchWordDefinition(word: mySearchBar.text!)
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == false {
            return 1
        }else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].searchedWord
        return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].searchedWordDefinition
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewData[indexPath.section].opened == true {
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    func errorLabel() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.center = CGPoint(x: 160, y: 285)
            label.textAlignment = .center
            label.text = "Word not found in dictionary..."

            self.view.addSubview(label)
        
    }
    
}

extension VocabularyViewController: WordManagerDelegate {
    func didUpdateWord(_ wordManager: WordManager, word: WordModel) {
        DispatchQueue.main.async {
            var nextWord = cellData(opened: false, searchedWord: "", searchedWordDefinition: "")
            nextWord.searchedWord = self.searchBarWord
            nextWord.searchedWordDefinition = word.wordDefinition
            self.tableViewData.append(nextWord)
            self.tableView.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.errorMessage.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.errorMessage.isHidden = true
        }

       // print("error is \(error)")
    }
}


