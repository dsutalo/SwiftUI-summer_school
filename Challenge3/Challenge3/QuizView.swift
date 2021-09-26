//
//  ContentView.swift
//  Challenge3
//
//  Created by Domagoj Sutalo on 23.09.2021..
//

import SwiftUI



struct QuizView: View {
    @State private var questions = [Question]()
    @State private var gameActive = false
    @State private var score = 0
    @State private var questionIndex = 0
    @State private var showResult = false
    @State private var submitIsDisabled = false
    @State private var newGameIsDisabled = true
    @State private var correctAnswer = false
    @State private var incorrectAnswer = false
    @State private var unknownAnswer = false
    @State private var submitAnimation: CGFloat = 1
    @ObservedObject var settings: Settings
    @ObservedObject var settingsStart: SettingsStart

    @State private var userAnswer = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                RadialGradient(gradient: Gradient(colors: [.white, .blue]), center: .center, startRadius: 1, endRadius: 470).edgesIgnoringSafeArea(.all)
                VStack{
                    if(gameActive){
                        Text(questions[questionIndex].text)
                            .font(Font.title.weight(.semibold))
                        
                        TextField("Input answer here", text: $userAnswer)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .font(.title2)
                        
                    }
                    Spacer()
                    if submitIsDisabled {
                        Text("Final score: \(score)/\(settings.numberOfQuestions)")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                    
                    Spacer()
                    if !submitIsDisabled {
                        Button(action: submit){
                            Text("Submit")
                        }
                        .disabled(submitIsDisabled)
                        .foregroundColor(.white)
                        .padding(10)
                        
                        .background(correctAnswer ? Color.green.opacity(0.7): Color.red.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .font(.title)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .scaleEffect(submitAnimation)
                    }
                    if !newGameIsDisabled {
                        Button("New game") {
                            settingsStart.isSettingsActive.toggle()
                        }
                        .disabled(newGameIsDisabled)
                        .newGameDesign()
                    }
                }
                
                Text("Correct!")
                    .font(.system(size: 70))
                    .foregroundColor(correctAnswer ? .green : .clear)
                    .opacity(correctAnswer ? 0 : 1)
                    
                
                Text("Wrong!")
                    .font(.system(size: 70))
                    .foregroundColor(incorrectAnswer ? .red : .clear)
                    .opacity(incorrectAnswer ? 0 : 1)
                
                Text("Input answer!")
                    .font(.system(size: 50))
                    .foregroundColor(unknownAnswer ? .black : .clear)
                    .opacity(unknownAnswer ? 0 : 1)
                    
            }
            .navigationBarTitle("Quiz")
            .navigationBarItems(leading: Text("Question \(questionIndex + 1)/\(settings.numberOfQuestions)"), trailing: Text("Score: \(score)/\(settings.numberOfQuestions)")
            )
        }
        .onAppear {
            generateQuestions()
        }
    }
    
    func submit() {
        if userAnswer.isEmpty{
            nextRound()
            withAnimation(Animation.linear(duration: 1)) {
                unknownAnswer = true
            }
            
        } else if userAnswer == questions[questionIndex].answer {
            score += 1
            nextRound()
            withAnimation(Animation.linear(duration: 1)) {
                correctAnswer = true
                submitAnimation += 0.05

            }
        } else{
            nextRound()
            withAnimation(Animation.linear(duration: 1)) {
                incorrectAnswer = true
                submitAnimation -= 0.05
                
            }
        }
        
        
    }
    
    func nextRound() {
        
        if questionIndex >= settings.numberOfQuestions - 1 {
            showResult = true
            submitIsDisabled = true
            newGameIsDisabled = false
        } else if !userAnswer.isEmpty{
            questionIndex += 1
        }
        correctAnswer = false
        incorrectAnswer = false
        unknownAnswer = false
        userAnswer = ""
    }
    
    func generateQuestions() {
        questions = Questions(difficulty: settings.difficulty, numberOfQuestions: settings.numberOfQuestions).questions
        gameActive = true
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(settings: Settings(), settingsStart: SettingsStart())
    }
}
