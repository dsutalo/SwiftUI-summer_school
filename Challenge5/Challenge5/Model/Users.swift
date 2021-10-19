//
//  Users.swift
//  Challenge5
//
//  Created by Domagoj Sutalo on 28.09.2021..
//

import Foundation

class Users: ObservableObject{
    @Published var items = [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedUser = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        self.items = decodedUser
                    }
                    return
                }
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
    
    func getUserIndex(id: String) -> Int?{
        return items.firstIndex(where: {$0.id == id})
    }
    
    func getUser(id: String) -> User {
        guard let index = getUserIndex(id: id) else {
            return User(id: "15", name: "Ivan", age: 23, company: "KKAK", address: "OS", friends: [])
        }
        return items[index]
    }
    
}
