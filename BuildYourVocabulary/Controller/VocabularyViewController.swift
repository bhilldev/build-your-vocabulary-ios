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
    var tableViewData = [CdWord]()
    var searchBarWord: String = ""
    
    //Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        fetchWords()
        
    }
    func fetchWords() {
        do {
            self.tableViewData = try context.fetch(CdWord.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBarWord = mySearchBar.text!
        wordManager.fetchWordDefinition(word: mySearchBar.text!)
        mySearchBar.endEditing(true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if errorMessage.isHidden == false {
            errorMessage.isHidden = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == false {
            return 1
        }
        else {
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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row % 2 == 0 {
            return .delete
        } else {
            return .none
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //Which word to remove
            let wordToRemove = tableViewData[indexPath.row]
            //Remove the word
            self.context.delete(wordToRemove)
            do {
                try self.context.save()
            }
            catch {
                
            }
            //Save updated table
            self.fetchWords()
        }
    }
    
//    func errorLabel() {
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//            label.center = CGPoint(x: 160, y: 285)
//            label.textAlignment = .center
//            label.text = "Word not found in dictionary..."
//
//            self.view.addSubview(label)
//        
//    }
    
}

extension VocabularyViewController: WordManagerDelegate {
    func didUpdateWord(_ wordManager: WordManager, word: WordModel) {
        DispatchQueue.main.async {
            //Create word and definition object
            var newWord = CdWord(context: self.context)
            newWord.searchedWord = self.searchBarWord
            newWord.searchedWordDefinition = word.wordDefinition
            self.tableViewData.append(newWord)
            
            //Save the word
            do {
                try self.context.save()
            }
            catch {
                
            }
            //Re-load words
            self.fetchWords()
        }
    }
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.errorMessage.isHidden = false
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//            self.errorMessage.isHidden = true
//        }

       // print("error is \(error)")
    }
}


