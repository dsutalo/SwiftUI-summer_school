//
//  ContentView.swift
//  Challenge2
//
//  Created by Domagoj Sutalo on 20.09.2021..
//

import SwiftUI

struct ButtonDesign: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding()
            .background(Color.blue.opacity(0.6))
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    let possibleMoves = ["Rock","Paper","Scissors"]
    @State private var currentChoice = Int.random(in: 0...2)
    @State private var isWin = Bool.random()
    @State private var score = 0
    @State private var numberOfRound = 0
    @State private var lastRound = false
    @State private var alertTitle = ""
    @State private var showAlert = false
    
    var body: some View {
            NavigationView{
                ZStack{
                    RadialGradient(gradient: Gradient(colors: [.orange, .red]), center: .center, startRadius: 100, endRadius: 470).edgesIgnoringSafeArea(.all)
                    VStack(spacing: 30){
                        HStack(spacing: 50){
                            Text("Round: \(numberOfRound)")
                                .font(.title2)
                            Text("Score: \(score)")
                                .font(.title2)
                        }
                        Spacer()
                        
                        Text("Computers move: \(possibleMoves[currentChoice])")
                            .font(.title)
                        Text("You need to: \(isWin ? "win": "lose")")
                            .font(.title)
                        
                        Spacer()
                        
                        HStack(spacing: 50){
                            Button(action: rockTapped){
                                Text("Rock")
                            }
                            .disabled(lastRound)
                            .modifier(ButtonDesign())
                            
                            Button(action: paperTapped){
                                Text("Paper")
                            }
                            .disabled(lastRound)
                            .modifier(ButtonDesign())
                            
                            Button(action: scissorsTapped){
                                Text("Scissors")
                            }
                            .disabled(lastRound)
                            .modifier(ButtonDesign())
                            
                        }
                    }
                    .navigationBarTitle("Rock, Paper, Scissors")
                }
                }
                
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text(alertTitle), message: nil,  dismissButton: .default(lastRound ? Text("Finish") : Text("Next round") ))
            })
            
        }
        
    func rockTapped(){
        switch currentChoice {
        case 0:
            didLose()
        case 1:
            isWin ? didLose() : didWin()
        case 2:
            isWin ? didWin() : didLose()
        default:
            defaultCase()
        }
    }
    
    func paperTapped(){
        switch currentChoice {
        case 0:
            isWin ? didWin() : didLose()
        case 1:
            didLose()
        case 2:
            isWin ? didLose() : didWin()
            
        default:
            defaultCase()
        }
    }
    
    func scissorsTapped(){
        
        switch currentChoice {
        case 0:
            isWin ? didLose() : didWin()
            
        case 1:
            isWin ? didWin() : didLose()
            
        case 2:
            didLose()
        default:
            defaultCase()
        }
    }
    
    func didWin() {
        score += 1
        showAlert = true
        nextRound()
        alertTitle = "Correct!"
    }
    
    func didLose() {
        score -= 1
        showAlert = true
        nextRound()
        alertTitle = "Wrong"
    }
    
    func defaultCase() {
        alertTitle = "Error while choosing answer"
        nextRound()
    }
    
    func nextRound() {
        numberOfRound += 1
        if numberOfRound >= 5 {
            lastRound = true
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
