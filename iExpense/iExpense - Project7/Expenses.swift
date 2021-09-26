//
//  Expenses.swift
//  iExpense - Project7
//
//  Created by Domagoj Sutalo on 23.09.2021..
//

import Foundation
import SwiftUI

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            saveToUserDefaults()
        }
    }
    
    init(){
        fetchUserDefaults()
    }
    
    func saveToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "newItems")
        }
    }
    
    func fetchUserDefaults(){
        if let items = UserDefaults.standard.data(forKey: "newItems") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                    self.items = decoded
                    return
                }
            }

            self.items = []
    }
}
