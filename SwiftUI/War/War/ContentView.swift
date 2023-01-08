//
//  ContentView.swift
//  War
//
//  Created by Shuvaethy Neill on 2023-01-07.
//

import SwiftUI

struct ContentView: View {
    
    @State private var playerCard = "back"
    @State private var cpuCard = "back"
    @State private var playerScore = 0
    @State private var cpuScore = 0
    @State private var roundNumber = 0
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            Image("background-plain")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("logo")
                Spacer()
                
                HStack {
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                
                Spacer()
                
                Button(action: {
                    dealCards()
                }, label: {
                    Image("button")
                })
                .alert("Game Over!", isPresented: $showAlert) {
                    Button("New Game", action: resetGame)
                } message: {
                    Text(alertMessage)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    VStack {
                        Text("Player")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text(String(playerScore))
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                    VStack {
                        Text("CPU")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text(String(cpuScore))
                            .font(.largeTitle)
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                
                Spacer()
                
            }
            .padding()
        }
    }
    
    func dealCards() {
        let playerRand = Int.random(in: 2...14)
        let cpuRand = Int.random(in: 2...14)
        
        playerCard = "card\(playerRand)"
        cpuCard = "card\(cpuRand)"
        
        roundNumber += 1
        
        if playerRand > cpuRand {
            playerScore += 1
        } else if cpuRand > playerRand {
            cpuScore += 1
        }
        
        if roundNumber == 10 {
            if playerScore == cpuScore {
                alertMessage = "Draw! You both tied."
            } else {
                alertMessage = playerScore > cpuScore ? "You won the game!" : "The CPU won the game!"
            }
            showAlert = true
        }
    }
    
    func resetGame() {
        playerScore = 0
        cpuScore = 0
        roundNumber = 0
        cpuCard = "back"
        playerCard = "back"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
