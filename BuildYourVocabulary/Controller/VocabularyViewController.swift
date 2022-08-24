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
    
    var tableViewData = [cellData]()
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var wordManager = WordManager()
    
    var wordArray = [String]()
    
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
        var nextWord = cellData(opened: false, searchedWord: "", searchedWordDefinition: "")
        nextWord.searchedWord = mySearchBar.text!
        tableViewData.append(nextWord)
        wordManager.fetchWordDefinition(word: mySearchBar.text!)
        wordArray.append(mySearchBar.text!)

        tableView.reloadData()
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
    
}

extension VocabularyViewController: WordManagerDelegate {
    func didUpdateWord(_ wordManager: WordManager, word: WordModel) {
        DispatchQueue.main.async {
            self.tableViewData[self.tableViewData.count-1].searchedWordDefinition = word.wordDefinition
        }
    }
    func didFailWithError(error: Error) {
        print("error is \(error)")
    }
}


