//
//  ContentView.swift
//  WordScramble
//
//  Created by Shuvaethy Neill on 2022-12-18.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    
    var body: some View {
        // Note: NavigationView is deprecated for iOS 16 - alternative is NavigationStack
        NavigationView {
            List {
                Section {
                    // Bind user input
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                    
                Section {
                    // ForEach needs unique objects to iterate
                    // Use special keypath \.self
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(submit)
            .onAppear(perform: startGame)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("New Word", action: startGame)
                }
            }
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func startGame() {
        // Find path to start.txt file - returns String? (either the path or nil if it doesn't exist)
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // Create String by asking it to create itself from the contents of a file at a particular path - returns String?
            if let startWords = try? String(contentsOf: startWordsURL) {
                // Get array of strings by splitting startWords content at every line break
                let wordBank = startWords.components(separatedBy: "\n")
                rootWord = wordBank.randomElement() ?? "silkworm"
                usedWords = []
                return
            }
        }
        
        usedWords = [String]()
        
        // Should not reach here. Means file was not loaded properly
        fatalError("Could not load start.txt from bundle.")
    }
    
    func submit() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !answer.isEmpty else { return }
        
        guard isPossible(word: answer) else {
            return showErrorMessage(title: "Word not possible", message: "You can't spell that word from \(rootWord).")
        }
        
        guard isOriginal(word: answer) else {
            return showErrorMessage(title: "Word used already", message: "Be more original...")
        }
        
        guard isReal(word: answer) else {
            return showErrorMessage(title: "Word not recognized", message: "Hey...you can't make up words!")
        }
                
        
        withAnimation {
            usedWords.append(answer)
            // sort alphebetically then by length (shortest to longest)
            usedWords.sort()
            usedWords.sort(by: {$0.count < $1.count})
        }
        newWord = ""
    }
    
    func isPossible(word: String) -> Bool {
        if(word.count > rootWord.count) { return false }
        
        var tempWord = rootWord
            
        for letter in word {
            // Check if root word contains letter - firstIndex returns optional index
            if let i = tempWord.firstIndex(of: letter) {
                // Remove letter from word so that it cannot be used twice
                tempWord.remove(at: i)
            } else {
                return false
            }
        }
            
        return true
    }
        
    func isOriginal(word: String) -> Bool {
        if word == rootWord {
            return false
        } else {
            return !usedWords.contains(word)
        }
    }
        
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()   // Class designed to spot spelling errors
        let range = NSRange(location: 0, length: word.utf16.count) // Must use utf16.count for the character count
        // Check for mispell - returns either location of misspell or NSNotFound if no mispell exists (valid word)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func showErrorMessage(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
