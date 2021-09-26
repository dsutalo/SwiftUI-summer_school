//
//  CheckoutView.swift
//  CupcakeCorner - Project10
//
//  Created by Domagoj Sutalo on 26.09.2021..
//

import SwiftUI

struct CheckoutView: View {
//    @ObservedObject var order: Order
    
    @ObservedObject var order: UpdatedOrderObject
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.updatedOrder.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        placeOrder()
                    }
                    .padding()
                }
            }
        }
        //challenge 2 - alert in case placeOrder() fails
        .alert(isPresented: $showAlert) {
            if showingConfirmation {
               return Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            }
            return Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.updatedOrder) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self.showAlert = true
                self.errorMessage = "No data in response: \(error?.localizedDescription ?? "Unknown error")"
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
                self.showAlert = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
    
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: UpdatedOrderObject())
    }
}
