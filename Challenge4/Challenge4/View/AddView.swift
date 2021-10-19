//
//  AddView.swift
//  Challenge4
//
//  Created by Domagoj Sutalo on 27.09.2021..
//

import SwiftUI

struct AddView: View {
    @ObservedObject var habits: Habits
    @State private var name = ""
    @State private var description = ""
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            Form {
                TextField("Input name of habit", text: $name).disableAutocorrection(true)
                TextField("Input description", text: $description).disableAutocorrection(true)
            }
            .navigationBarTitle("Add habit")
            .navigationBarItems(trailing: Button(action: saveHabit){
                Text("Save")
            })
            .alert(isPresented: $showAlert){
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        
    }
    func saveHabit() {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || description.trimmingCharacters(in: .whitespaces).isEmpty {
            showAlert = true
            errorMessage = "You need to fill both name and description!"
            
        } else {
            
            let item = Habit(name: self.name.trimmingCharacters(in: .whitespaces), description: self.description.trimmingCharacters(in: .whitespaces))
            self.habits.items.append(item)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
