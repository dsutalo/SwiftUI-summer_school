//
//  DefaultView.swift
//  Challenge3
//
//  Created by Domagoj Sutalo on 24.09.2021..
//

import SwiftUI

class SettingsStart: ObservableObject {
    @Published var isSettingsActive = true
}

struct DefaultView: View {
    @ObservedObject var settingsStart = SettingsStart()
    @ObservedObject var settings = Settings()
    var body: some View {
        Group{
            if settingsStart.isSettingsActive {
                SettingsView(settings: settings, settingsStart: settingsStart)
            }  else {
                QuizView(settings: settings, settingsStart: settingsStart)
            }
            
        }
        
    }


struct DefaultView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultView()
    }
}
}
