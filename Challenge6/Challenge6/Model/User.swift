//
//  User.swift
//  Challenge6
//
//  Created by Domagoj Sutalo on 28.09.2021..
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let age: Int
    let company: String
    let address: String
    let friends: [Friend]
    
    struct Friend: Codable, Identifiable {
        let id: String
        let name: String
    }
}
