//
//  DiceView.swift
//  Challenge9
//
//  Created by Domagoj Sutalo on 06.10.2021..
//

import SwiftUI
import CoreHaptics

struct DiceView: View {
//    var die = Die()
    @EnvironmentObject var dice: Dice
    private let numberOfSides = ["3", "6", "8", "10", "20", "50"]
    private let numberOfDice = ["1", "2", "3", "4", "5"]
    @State private var numberOfSidesIndex = 0
    @State private var numberOfDiceIndex = 0
    @State private var rolledDiceResult = 0
    @State private var isDiceRolled = false
    @State private var engine: CHHapticEngine?
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                
                VStack(alignment: .leading) {
                    Text("Choose number of dice")
                    Picker("Number of Dice", selection: $numberOfDiceIndex) {
                        ForEach(0..<numberOfDice.count) {
                            Text("\(numberOfDice[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("Choose number of sides")
                    Picker("Dice sides", selection: $numberOfSidesIndex) {
                        ForEach(0..<numberOfSides.count) {
                            Text("\(numberOfSides[$0])")
                            
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Spacer()
                
                VStack {
                    if(isDiceRolled) {
                        HStack {
                            ForEach(dice.items) {die in
                                Spacer()
                                
                                Text("\(die.result)")
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .background(Color.black)
                                    .cornerRadius(20)
                                    
                                
                                Spacer()
                            }
                            
                        }
                    }
                    
                }
                Spacer()
                
                Button(action: rollDice) {
                    Text("Roll")
                    
                }
                .frame(width: 200, height: 50, alignment: .center)
                .foregroundColor(.white)
                .font(.headline)
                .background(Color.orange)
                .cornerRadius(20)
                .padding()
                
            }
            .navigationBarTitle("Roll the dice")
            
        }.onAppear(perform: prepareHaptics)
        
    }
    func rollDice() {
        complexSuccess()
        isDiceRolled = true
        save()
    }
    
    func deleteResults() {
            dice.items.removeAll()
    }
    
    func save() {
        if dice.items.count > 0 {
            deleteResults()
        }
       
        var j = 0
        var result = 0
        var results = [Int]()
        for _ in 0..<Int(numberOfDice[numberOfDiceIndex])! {
            var die = Die()
            die.numberOfSides = Int(numberOfSides[numberOfSidesIndex])!
            die.result = Int(arc4random_uniform(UInt32(die.numberOfSides)) + 1)
            dice.add(die: die)
            result +=  die.result
            results.append(die.result)
        }
        
        
        dice.results.append(result)
        dice.save()
        j += 1
        
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
