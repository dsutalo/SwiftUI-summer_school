//
//  Dice.swift
//  Challenge9
//
//  Created by Domagoj Sutalo on 06.10.2021..
//

import Foundation

class Dice: ObservableObject, Identifiable {
    let saveKey = "savedDicee"
    @Published var items = [Die]()
    @Published var results = [Int]()
    
    func add(die: Die) {
        self.items.insert(die, at: 0)
        
    }
    
    init() {
        fetch()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(results) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
            print("saved!")
        }
    }
    
    func fetch() {
        if let items = UserDefaults.standard.data(forKey: saveKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Int].self, from: items) {
                self.results = decoded
                print("fetched!")
                print(self.results[0])
                return
            } else {
                print("Couldnt decode")
            }
        } else {
            print("Couldnt fetch items")
        }
        
        
        
    }
}
