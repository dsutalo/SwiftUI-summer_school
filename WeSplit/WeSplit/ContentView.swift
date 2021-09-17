//
//  ContentView.swift
//  WeSplit
//
//  Created by Domagoj Sutalo on 16.09.2021..
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmout = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    private let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double {
        let peopleCount = Double( numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmout) ?? 0
        
        let tipValue = orderAmount/100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Type in amount", text: $checkAmout)
                        .keyboardType(.decimalPad)
                    Picker("Number of people: ", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave")){
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<tipPercentages.count){
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section{
                    Text("$\(totalPerPerson,specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
