//
//  ContentView.swift
//  Challenge9
//
//  Created by Domagoj Sutalo on 06.10.2021..
//

import SwiftUI

struct MainView: View {
    var dice = Dice()
    var body: some View {
        
        TabView {
            DiceView()
                .tabItem {
                    Image(systemName: "die.face.6.fill")
                    Text("Roll dice")
                }
            ResultsView()
                .tabItem {
                    Image(systemName: "folder.fill")
                    Text("Results")
                }
        }
        .environmentObject(dice)
    }
    
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
