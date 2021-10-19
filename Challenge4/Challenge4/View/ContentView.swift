//
//  ContentView.swift
//  Challenge4
//
//  Created by Domagoj Sutalo on 27.09.2021..
//

import SwiftUI

struct ContentView: View {
    @State private var showAddHabit = false
    @StateObject var habits = Habits()
    var body: some View {
        NavigationView {
            List(habits.items) { item in
                NavigationLink(destination: DetailView(habitId: item.id)){
                    Text(item.name)
                        .font(.headline.bold())
                }
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(trailing: Button(action: addHabit) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showAddHabit) {
                AddView(habits: habits)
            }
        }
        .environmentObject(habits)
    }
    
    func addHabit() {
        showAddHabit = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
