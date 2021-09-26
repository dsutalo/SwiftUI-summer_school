//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Domagoj Sutalo on 17.09.2021..
//

import SwiftUI

struct ContentView: View {
    
    enum ActiveAlert{
        case first, second
    }
    
    @State private var countries = ["estonia","france","germany","ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    //challenge 1
    @State private var score = 0
    @State private var showAlert = false
    @State private var showingCorrectAnswer = false
    @State private var showingFalseAnswer = false
    @State private var scoreTitle = ""
    @State private var tappedStateIndex = 0
    @State private var rotationAmount: Double = 0
    @State private var opacityAmount: Double = 1
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3){ number in
                    Button(action: {
                        //flag was tapped
                        self.flagTapped(number)
                        tappedStateIndex = number
                        //Project6 challenge 1
                        withAnimation{
                            rotationAmount += 360
                            opacityAmount -= 0.75
                            
                        }
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                            //Project 6 challenge 1
                            .rotation3DEffect(
                                .degrees(number == correctAnswer ? rotationAmount: 0),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                            .opacity(number != correctAnswer ? Double(opacityAmount): 1)
                    }
                    
                    
                    
                }
                
                Label("Your score is: \(score)", systemImage: "bolt.fill").labelStyle(TitleOnlyLabelStyle())
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showAlert) {
            if showingCorrectAnswer{
                return Alert(title: Text("Correct"), message: nil, dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
                
            }
            return Alert(title: Text("Wrong answer"), message: Text("That is flag of: \(countries[tappedStateIndex])"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            showingCorrectAnswer = true
            
            
            
        } else{
            scoreTitle = "Wrong"
            score -= 1
            showingFalseAnswer = true
            showingCorrectAnswer = false
            
        }
       showAlert = true
    
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmount = 1
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
