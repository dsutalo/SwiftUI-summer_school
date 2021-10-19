//
//  Habit.swift
//  Challenge4
//
//  Created by Domagoj Sutalo on 27.09.2021..
//

import Foundation

struct Habit: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    var completitionCounter: Int = 0
    
}
