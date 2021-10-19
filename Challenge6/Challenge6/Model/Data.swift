//
//  Data.swift
//  Challenge6
//
//  Created by Domagoj Sutalo on 28.09.2021..
//

import Foundation
import CoreData

struct Data {
    static func fetchUsers(onSuccess: @escaping (([User]) -> ())) {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedUser = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        onSuccess(decodedUser)
                    }
                    return
                }
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
    
    static func loadUsers(moc: NSManagedObjectContext ) {
        
        fetchUsers { users in
            for user in users {
                let userEntity = UserEntity(context: moc)
                userEntity.id = user.id
                userEntity.name = user.name
                userEntity.age = Int16(user.age)
                userEntity.address = user.address
                userEntity.company = user.company
            }
            do {
                try moc.save()
            } catch {
                fatalError("Error while loading users from JSON")
            }
            
        }
    }
}
