//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Shuvaethy Neill on 2022-12-18.
//

import SwiftUI

// Custom View
struct DrawImageView: View  {
    var image: String
    
    var body: some View {
        Text("\(image)")
            .background(Color.white)
            .cornerRadius(25)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.gray, lineWidth: 2))
            .font(.system(size: 90))
    }
}

struct ContentView: View {
    @State private var questionCounter = 1
    @State private var score = 0
    
    @State private var shouldWin = Bool.random()
    @State private var computerChoice = Int.random(in: 0...2)
    
    @State private var alertMessage = ""
    @State private var showScore = false
    @State private var gameOver = false
    
    let possibleMoves = ["🪨", "📄", "✂️"]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color.white, location: 0.3),
                .init(color: Color(red: 0.4627, green: 0.8392, blue: 1.0), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 250)
            .ignoresSafeArea()
            
            VStack (spacing: 20) {
                // Top Section
                Text("Rock, Paper, Scissors")
                    .foregroundColor(.black)
                    .font(.largeTitle.bold())
                
                Text("Brain Training Edition")
                    .foregroundColor(.black)
                    .font(.title2)
                
                Text("Question \(questionCounter) of 10")
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                Spacer()
                Spacer()
                
                // Bottom Section
                VStack (spacing: 20){
                    Text(shouldWin ? "You must WIN against:" : "You must LOSE against:")
                        .foregroundColor(.white)
                        .font(.title.bold())
                    
                    DrawImageView(image: "\(possibleMoves[computerChoice])")
                    
                    Spacer()
                    
                    Text("Choose your move:")
                        .foregroundColor(.white)
                        .font(.title.bold())
                    
                    // Align 3 buttons horizontally
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                checkAnswer(number)
                            } label:  {
                                DrawImageView(image: "\(possibleMoves[number])")
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                }
            }
        }
        .alert(alertMessage, isPresented: $showScore) {
            Button("Next Question", action: newQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert("Game Over", isPresented: $gameOver) {
            Button("Next Game", action: newGame)
        } message: {
            Text("Your final score was \(score)/10")
        }
    }
    
    // Validate user answer
    func checkAnswer(_ number: Int) {
        let objective = shouldWin ? "win" : "lose"
        let correctAnswer = "That's correct!"
        let incorrectAnswer = "Wrong! You were supposed to \(objective)."
        
        let choiceDifference = number - computerChoice
        
        if choiceDifference % 3 == 1 {
            if shouldWin {
                score += 1
                alertMessage = correctAnswer
            } else {
                alertMessage = incorrectAnswer
            }
        } else if choiceDifference % 3 == 0 {
            alertMessage = incorrectAnswer
        } else {
            if !shouldWin {
                score += 1
                alertMessage = correctAnswer
            } else {
                alertMessage = incorrectAnswer
            }
        }
        
        showScore = true
        
        // End game after 10 questions
        if questionCounter == 10 {
            gameOver = true
            showScore = false
        }
    }
    
    // Reset randoms and ask new question
    func newQuestion() {
        computerChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        questionCounter += 1
    }
    
    // Reset to new game
    func newGame() {
        score = 0
        questionCounter = 0
        newQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
