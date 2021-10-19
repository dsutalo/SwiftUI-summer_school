//
//  UserView.swift
//  Challenge6
//
//  Created by Domagoj Sutalo on 28.09.2021..
//

import SwiftUI

struct UserView: View {

//    let userId: String
    
    let user: UserEntity
    
//    var user: User {
//        users.getUser(id: userId)
//    }
    
    var body: some View {
        List {
            Section(header: Text("General")){
                Text("Name: \(user.wrappedName)")
                Text("Age: \(user.age)")
                Text("Company: \(user.wrappedCompany)")
                Text("Address: \(user.wrappedAddress)")
            }
            
            Section(header: Text("Friends")) {
                Text("Soon to come!")
            }
        }
        .navigationBarTitle("\(user.wrappedName)", displayMode: .inline)
    }
}


struct UserView_Previews: PreviewProvider {
    
    static var defaultUser: UserEntity{
        let defUser = UserEntity()
        defUser.id = "15"
        defUser.name = "Ivan"
        defUser.age = 23
        defUser.address = "OS"
        defUser.company = "KKAK"
        return defUser
    }
    
    static var previews: some View {
        UserView(user: defaultUser)
    }
}
