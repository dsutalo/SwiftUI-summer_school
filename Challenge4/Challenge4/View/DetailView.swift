//
//  DetailView.swift
//  Challenge4
//
//  Created by Domagoj Sutalo on 27.09.2021..
//

import SwiftUI

struct DetailView: View {
    var habitId: UUID
    
    @EnvironmentObject var habitsEnv: Habits
    @State private var completitionCounterIsOne = false
    
    var habit: Habit {
        habitsEnv.getHabit(id: habitId)
    }
    
    var body: some View {
        Form {
            Section(header:Text("Description").font(.headline).bold()) {
                Text(habit.description)
            }
            Section(header: Text("Completition").font(.headline).bold()) {
                Text("Completed: \(habit.completitionCounter)" + (completitionCounterIsOne ? " time": " times"))
                Button(action: addCompletedHabit){
                    Text("Add")
                }
            }
        }
        .navigationBarTitle(habit.name, displayMode: .inline)
    }
    
    func addCompletedHabit() {
        completitionCounterIsOne = false
        let index = habitsEnv.getIndex(id: habitId)!
        habitsEnv.items[index].completitionCounter += 1
        
        if habitsEnv.items[index].completitionCounter == 1 {
            completitionCounterIsOne = true
        }  
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView(habitId: UUID())
    }
}
