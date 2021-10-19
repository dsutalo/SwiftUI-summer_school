//
//  Habits.swift
//  Challenge4
//
//  Created by Domagoj Sutalo on 27.09.2021..
//

import Foundation

class Habits: ObservableObject {
    @Published var items = [Habit]() {
        didSet {
            saveToUserDefaults()
        }
    }
    
    init() {
        fetchFromUserDefaults()
    }

    func saveToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "habitss")
        }
    }
    
    func fetchFromUserDefaults() {
        if let items = UserDefaults.standard.data(forKey: "habitss") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habit].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
    
    func getHabit(id: UUID) -> Habit {
        guard let index = getIndex(id: id) else {  return Habit(name: "", description: "")}
        return items[index]
    }
    
    func getIndex(id: UUID) -> Int? {
        return items.firstIndex(where: {$0.id == id})
    }
}

