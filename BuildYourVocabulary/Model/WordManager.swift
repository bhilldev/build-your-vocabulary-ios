//
//  API.swift
//  BuildYourVocabulary
//
//  Created by Brandon Hill on 6/29/22.
//

import Foundation

protocol WordManagerDelegate {
    func didUpdateWord(_ wordManager: WordManager, word: WordModel)
    func didFailWithError(error: Error)
}

struct WordManager {
    let wordUrl = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
    var delegate: WordManagerDelegate?
    
    func fetchWordDefinition(word: String) {
        let urlString = "\(wordUrl)\(word)?key=35d770ac-3c83-43a4-9aff-2bee78c32610"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let word = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWord(self, word: word)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ wordData: Data) -> WordModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([WordData].self, from: wordData)
            let definition = decodedData[0].shortdef[0]
            let word = WordModel(wordDefinition: definition)
            return word
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }}
