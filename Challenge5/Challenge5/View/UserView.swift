//
//  UserView.swift
//  Challenge5
//
//  Created by Domagoj Sutalo on 28.09.2021..
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var users: Users
    let userId: String
    
    var user: User {
        users.getUser(id: userId)
    }
    
    var body: some View {
        List {
            Section(header: Text("General")){
                Text("Name: \(user.name)")
                Text("Age: \(user.age)")
                Text("Company: \(user.company)")
                Text("Address: \(user.address)")
            }
            
            Section(header: Text("Friends")) {
                ForEach(user.friends) { friend in
                    NavigationLink(destination: UserView(userId: friend.id)) {
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationBarTitle("\(user.name)", displayMode: .inline)
        
    }
}



struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userId: "15")
    }
}

