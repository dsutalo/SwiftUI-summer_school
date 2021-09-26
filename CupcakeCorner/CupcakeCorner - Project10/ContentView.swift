//
//  ContentView.swift
//  CupcakeCorner - Project10
//
//  Created by Domagoj Sutalo on 26.09.2021..
//

import SwiftUI

struct ContentView: View {
    //    @ObservedObject var order: Order
    @ObservedObject var order = UpdatedOrderObject()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.updatedOrder.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    
                    Stepper(value: $order.updatedOrder.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.updatedOrder.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.updatedOrder.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }

                    if order.updatedOrder.specialRequestEnabled {
                        Toggle(isOn: $order.updatedOrder.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $order.updatedOrder.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)){
                        Text("Delivery details")
                    }}
                    
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
