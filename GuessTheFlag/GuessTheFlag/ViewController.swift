//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Shuvaethy Neill on 2022-12-04.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numOfQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco",
                      "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1;
        button2.layer.borderWidth = 1;
        button3.layer.borderWidth = 1;
        
        button1.layer.borderColor = UIColor.lightGray.cgColor;
        button2.layer.borderColor = UIColor.lightGray.cgColor;
        button3.layer.borderColor = UIColor.lightGray.cgColor;
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        // assign UIImage to button and set standard state of button to be changed
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        let uppercasedCountry = countries[correctAnswer].uppercased()
        title = "Tap on \(uppercasedCountry)'s flag"
        
        numOfQuestions += 1
    }
    
    func startNewGame(action: UIAlertAction) {
        numOfQuestions = 0
        score = 0
        scoreLabel.text = "Score: \(score)"
        
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
        } else {
            title = "Incorrect! That's the flag of \(countries[sender.tag].uppercased())."
            score -= 1
        }
        
        scoreLabel.text = "Score: \(score)"
        
        if(numOfQuestions == 10) {
            let finalAlertController = UIAlertController(title: "Game over!", message: "Your final score is \(score)/10.", preferredStyle: .alert)
            finalAlertController.addAction(UIAlertAction(title: "Start new game!", style: .default, handler: startNewGame))
            present(finalAlertController, animated: true)
        } else {
            let alertController = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alertController, animated: true)
        }
    }
}

