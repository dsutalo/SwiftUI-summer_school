//
//  ContentView.swift
//  iExpense - Project7
//
//  Created by Domagoj Sutalo on 23.09.2021..
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddExpense = false
    @ObservedObject var expenses = Expenses()
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("$\(item.amount)")
                            .foregroundColor(changeAmountColor(for: item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            //challenge 1 - add edit button
            .navigationBarItems(leading: EditButton(), trailing:
                                    Button(action:{
                                        showingAddExpense = true
                                        
                                    }) {
                                        Image(systemName: "plus")
                                    })
        }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    //challenge 2
    func changeAmountColor(for amount: Int) -> Color{
        switch amount {
        case 0..<10:
            return .gray
        case 10..<100:
            return .green
        default:
            return .orange
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
