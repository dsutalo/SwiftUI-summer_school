//
//  SettingsView.swift
//  Challenge3
//
//  Created by Domagoj Sutalo on 23.09.2021..
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings: Settings
    @ObservedObject var settingsStart: SettingsStart
    
    var body: some View {
        NavigationView{
            ZStack{
                RadialGradient(gradient: Gradient(colors: [.white, .green]), center: .center, startRadius: 1, endRadius: 470).edgesIgnoringSafeArea(.all)
                VStack(spacing:20){
                    Section(header: Text("Select difficulty")
                                .font(Font.title.weight(.semibold))){
                        Stepper("\(settings.difficulty)", value: $settings.difficulty, in: 1...12)
                    }
                    
                    Section(header: Text("Number of questions: ").font(Font.title.weight(.semibold))){
                        Picker("Select number of questions", selection: $settings.numberOfQuestionsIndex) {
                            ForEach(0..<settings.questionsNumber.count) { i in
                                Text((numberOfQuestionsToString(for: i))
                            )}
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Spacer()
                    Section{
                        Button("Start", action: startGame)
                            .buttonDesign()
                            
                    }
                }
            }
            
            .navigationTitle("Settings")
        }
        
        
    }
    
    func startGame() {
        settingsStart.isSettingsActive.toggle()
    }
    
    func numberOfQuestionsToString(for index: Int) -> String {
        return self.settings.questionsNumber[index].rawValue
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: Settings(),settingsStart: SettingsStart())
    }
}
