//
//  ResultsView.swift
//  Challenge9
//
//  Created by Domagoj Sutalo on 06.10.2021..
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var dice: Dice
    var body: some View {
        NavigationView {
            List{
                ForEach(0..<dice.results.count, id: \.self) { index in
                    Text("\(index + 1). Roll results: \(dice.results[index])")
                    
                }
            }
            .navigationBarTitle("Results")
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
