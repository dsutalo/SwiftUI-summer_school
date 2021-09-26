//
//  AddressView.swift
//  CupcakeCorner - Project10
//
//  Created by Domagoj Sutalo on 26.09.2021..
//

import SwiftUI

struct AddressView: View {
    //    @ObservedObject var order: Order
    @ObservedObject var order: UpdatedOrderObject
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.updatedOrder.name)
                TextField("Street Address", text: $order.updatedOrder.streetAddress)
                TextField("City", text: $order.updatedOrder.city)
                TextField("Zip", text: $order.updatedOrder.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(!order.updatedOrder.hasValidAddress)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
    
    
}



struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: UpdatedOrderObject())
    }
}
