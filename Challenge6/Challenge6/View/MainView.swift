//
//  ContentView.swift
//  Challenge6
//
//  Created by Domagoj Sutalo on 28.09.2021..
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: UserEntity.entity(), sortDescriptors: []) var users: FetchedResults<UserEntity>
//    @StateObject var users = Users()
    
    var body: some View {
        NavigationView{
            List(users, id: \.self.id){ user in
                NavigationLink(destination: UserView(user: user )){
                    Text(user.wrappedName)
                }
                
            }
            .navigationViewStyle(DefaultNavigationViewStyle())
            .navigationBarTitle("Users")
            
        }
        .onAppear(perform: loadData)
//        .environmentObject(users)
        
    }
    
    func loadData() {
        print("loading")
        if users.isEmpty {
            Data.loadUsers(moc: moc)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
