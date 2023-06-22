//
//  VocabularyViewController.swift
//  BuildYourVocabulary
//
//  Created by Brandon Hill on 5/24/22.
//

import UIKit

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
        wordManager.delegate = self
        
        mySearchBar.delegate = self
        tableView.dataSource = self
        tableView.register(DefinitionTableViewCell.nib(), forCellReuseIdentifier: DefinitionTableViewCell.identifier)
        tableView.delegate = self
        
        self.tableView.backgroundColor = K.TableViewColors.tableViewBackgroundColorHex
        self.setSearchBarAppearance()
        self.setNavBarAppearance(
            backgroundColor: K.NavBarColors.navBarBackgroundColor,
            foregroundColor: K.NavBarColors.navBarForegroundColor
        )
        self.fetchWords()
        
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            // The back button was pressed or interactive gesture used
            self.setNavBarAppearance(
                backgroundColor: UIColor.darkGray,
                foregroundColor: UIColor.black
            )
        }
    }
    
    func setSearchBarAppearance() {
        mySearchBar.autocapitalizationType = .none
        mySearchBar.barTintColor = K.SearchBarColors.searchBarBackgroundColorHex
        mySearchBar.searchTextField.backgroundColor = K.SearchBarColors.searchBarTextFieldBackgroundHex
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
    
    func fetchWords() {
        do {
            self.tableViewData = try context.fetch(CdWord.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            print("fetchwords error got caught")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBarWord = mySearchBar.text!
        wordManager.fetchWordDefinition(word: mySearchBar.text!)
        mySearchBar.endEditing(true)
    }
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        if errorMessage.isHidden == false {
//            errorMessage.isHidden = true
//        }
//    }
    
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
            cell.backgroundColor = K.TableViewColors.wordCellBackgroundColorHex
            cell.textLabel?.textColor = K.TableViewColors.wordCellTextColorHex
        
        return cell
        } else {
            guard let customCell = tableView.dequeueReusableCell(withIdentifier: DefinitionTableViewCell.identifier, for: indexPath) as? DefinitionTableViewCell
            else {return UITableViewCell()}
                    customCell.configure(descriptor: "verb", definition: tableViewData[indexPath.section].searchedWordDefinition!)
            customCell.backgroundColor = K.TableViewColors.definitionCellBackgroundColorHex
            return customCell
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
            let wordToRemove = tableViewData[indexPath.section]
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
    

    func allowMultipleLines(tableViewCell: UITableViewCell) {
        tableViewCell.textLabel?.numberOfLines = 0
        tableViewCell.textLabel?.lineBreakMode = .byWordWrapping
    }
}

extension VocabularyViewController: WordManagerDelegate {
    func didUpdateWord(_ wordManager: WordManager, word: WordModel) {
        DispatchQueue.main.async {
            //Create word and definition object
            let newWord = CdWord(context: self.context)
            newWord.searchedWord = self.searchBarWord
            newWord.searchedWordDefinition = word.wordDefinition
            self.tableViewData.append(newWord)
            //Save the word
            do {
                try self.context.save()
            }
            catch {
                print("error got caught")
            }
            //Re-load words
            self.fetchWords()
        }
    }
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Word not found. Try again!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

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
