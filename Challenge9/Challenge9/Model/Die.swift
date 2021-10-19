//
//  Die.swift
//  Challenge9
//
//  Created by Domagoj Sutalo on 06.10.2021..
//

import Foundation

struct Die: Identifiable, Codable {
    static let saveKey = "savedDie"
    let id = UUID()
    var numberOfSides: Int = 6
    var result: Int = 6
    
    mutating func saveNumberOfSides(numberOfSides: Int) {
        self.numberOfSides = numberOfSides
    }
    
    mutating func saveResult(result: Int) {
        self.result = result
    }
 
}
