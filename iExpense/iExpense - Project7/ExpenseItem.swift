//
//  ExpenseItem.swift
//  iExpense - Project7
//
//  Created by Domagoj Sutalo on 23.09.2021..
//

import Foundation

struct ExpenseItem: Identifiable, Codable{
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
