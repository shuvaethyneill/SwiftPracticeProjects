//  ViewController.swift
//  WordScramble
//
//  Created by Shuvaethy Neill on 2022-12-09.
//

import UIKit

class ViewController: UITableViewController {
    
    var wordBank = [String]()
    var usedWords = [String]()
    let checker = UITextChecker()   // class designed to spot spelling errors

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New word", style: .plain, target: self, action: #selector(resetGame))
        
        // find path to start.txt file - returns String? (either the path or nil if it doesn't exist)
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // create String by asking it to create itself from the contents of a file at a particular path - returns String?
            if let startWords = try? String(contentsOf: startWordsURL) {
                // get array of strings by splitting startWords content at every line break
                wordBank = startWords.components(separatedBy: "\n")
            }
        }
        
        if wordBank.isEmpty {
            wordBank = ["silkworm"]
        }
        
        startGame()
    }
    
    @objc func startGame () {
        // set view controller's title to be random word from bank
        title = wordBank.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func resetGame(){
            let alertController = UIAlertController(title: "Are you sure you want a new word?", message: "You will lose your progress for the current word", preferredStyle: .alert)
            let reset = UIAlertAction(title: "Yes", style: .destructive) { [weak self]  _ in
                self?.startGame()
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alertController.addAction(reset)
            alertController.addAction(cancel)
            
            present(alertController, animated: true)
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let alertController = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        // editable text input field
        alertController.addTextField()
        
        // avoid strong reference cycle by capturing self (current view controller) and alertController as weak references in closure
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertController] action in
            guard let answer = alertController?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(submitAction)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    func submit(_ answer: String) {
        var lcAnswer = answer.lowercased()
        
        if !isPossible(word: lcAnswer) {
            guard let title = title?.lowercased() else { return }
            return showErrorMsg(errorTitle: "Word not possible", errorMsg: "You can't spell that word from \(title)")
        }
        
        if !isOriginal(word: lcAnswer) {
            return showErrorMsg(errorTitle: "Word used already", errorMsg: "Be more original...")
        }
                
        if !isReal(word: lcAnswer) {
            return showErrorMsg(errorTitle: "Word not recognized", errorMsg: "Hey...you can't make up words!")
        }
        
        usedWords.append(lcAnswer)
        // sort alphebetically then by length (shortest to longest)
        usedWords.sort()
        usedWords.sort(by: {$0.count < $1.count})
                    
        // we know returned optional must have a value
        var insertIndex = usedWords.firstIndex(of: lcAnswer)
                    
        let indexPath = IndexPath(row: insertIndex!, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        if(word.count > tempWord.count || word.count == 0) { return false }
        
        for letter in word {
            // check if word contains letter - firstIndex returns optional index
            if let i = tempWord.firstIndex(of: letter) {
                // remove letter from word so that it cannot be used twice
                tempWord.remove(at: i)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        if word == title {
            return false
        } else {
            return !usedWords.contains(word)
        }
    }
    
    func isReal(word: String) -> Bool {
        let range = NSRange(location: 0, length: word.utf16.count) // must use utf16.count for the character count with UIKit
        // check for mispell - returns either location of misspell or NSNotFound if no mispell exists (valid word)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func showErrorMsg(errorTitle: String, errorMsg: String) {
        let alertController = UIAlertController(title: errorTitle, message: errorMsg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
