//
//  ContentView.swift
//  Challenge1
//
//  Created by Domagoj Sutalo on 16.09.2021..
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue: String = ""
    @State private var unitsOfMeasurementInputIndex = 0
    @State private var unitsOfMeasurementOutputIndex = 0
    
    let unitsOfMeasurement = ["ft", "in", "m", "km","yd"]
    
    var measurement: Measurement<UnitLength> {
        let inputValueDecimal = Double(inputValue) ?? 0
        switch unitsOfMeasurement[unitsOfMeasurementInputIndex] {
        case "ft":
            return Measurement(value: inputValueDecimal, unit: UnitLength.feet)
        case "in": return Measurement(value: inputValueDecimal, unit: UnitLength.inches)
        case "m": return Measurement(value: inputValueDecimal, unit: UnitLength.meters)
        case "km": return Measurement(value: inputValueDecimal, unit: UnitLength.kilometers)
        case "yd": return Measurement(value: inputValueDecimal, unit: UnitLength.yards)
        default: return Measurement(value: inputValueDecimal, unit: UnitLength.decameters)
        }
    }
    
    var convertedUnit: Measurement<UnitLength> {
        switch unitsOfMeasurement[unitsOfMeasurementOutputIndex] {
        case "ft": return measurement.converted(to: UnitLength.feet)
        case "in": return measurement.converted(to: UnitLength.inches)
        case "m": return measurement.converted(to: UnitLength.meters)
        case "km": return measurement.converted(to: UnitLength.kilometers)
        case "yd": return measurement.converted(to: UnitLength.yards)
        default: return measurement.converted(to: UnitLength.decameters)
        }
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Input number", text: $inputValue)
                        .keyboardType(.decimalPad)
                    
                }
                Section(header: Text("Select unit you want to covert from")){
                    Picker("Units of measurement", selection: $unitsOfMeasurementInputIndex){
                        ForEach(0..<unitsOfMeasurement.count){
                            Text("\(unitsOfMeasurement[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Select unit you want to covert to")){
                    Picker("Units of measurement", selection: $unitsOfMeasurementOutputIndex){
                        ForEach(0..<unitsOfMeasurement.count){
                            Text("\(unitsOfMeasurement[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                Section{
                    Text("Converted unit: \(convertedUnit.value, specifier: "%.4f")")
                }
            }
            .navigationBarTitle("Units Converter")
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
