//
//  updatedOrder.swift
//  CupcakeCorner - Project10
//
//  Created by Domagoj Sutalo on 26.09.2021..
//

import Foundation

//Challenge 3 wrap struct inside @Published object - no need of using CodingKeys for Codable support in class

class UpdatedOrderObject: ObservableObject{
    @Published var updatedOrder = UpdatedOrder()
}

struct UpdatedOrder: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
         var type = 0
         var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += (Double(type) / 2)

        if extraFrosting {
            cost += Double(quantity)
        }

        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}

