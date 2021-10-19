//
//  ContentView.swift
//  Challenge5
//
//  Created by Domagoj Sutalo on 28.09.2021..
//

import SwiftUI

struct ContentView: View {
    @StateObject var users = Users()
    
    var body: some View {
        NavigationView{
            List(users.items){ item in
                NavigationLink(destination: UserView(userId: item.id)){
                    Text(item.name)
                }
                
            }
            .navigationViewStyle(DefaultNavigationViewStyle())
            .navigationBarTitle("Users")
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(users)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
