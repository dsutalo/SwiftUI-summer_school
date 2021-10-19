//
//  Persons.swift
//  Challenge8
//
//  Created by Domagoj Sutalo on 03.10.2021..
//

import Foundation

class Persons: ObservableObject {
    let userDefaultsKey = "saved"
    @Published var items = [Person]() {
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
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func fetchFromUserDefaults() {
        if let items = UserDefaults.standard.data(forKey: userDefaultsKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Person].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}
