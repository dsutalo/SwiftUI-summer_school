//
//  AddView.swift
//  iExpense - Project7
//
//  Created by Domagoj Sutalo on 23.09.2021..
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showAlert = false
    static let types = ["Buissness", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save", action: save))
        }
        //challenge 3
        .alert(isPresented: $showAlert) {
            Alert(title: Text("We accept money amount only"), message: nil, dismissButton: .default(Text("Uh..My bad")))
        }
    }
    func save(){
        if let actualAmount = Int(self.amount) {
            let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
            self.expenses.items.append(item)
            self.presentationMode.wrappedValue.dismiss()
        } else {
            showAlert = true
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
