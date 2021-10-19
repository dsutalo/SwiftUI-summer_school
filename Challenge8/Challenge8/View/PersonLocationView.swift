//
//  PersonLocationView.swift
//  Challenge8
//
//  Created by Domagoj Sutalo on 03.10.2021..
//

import SwiftUI

struct PersonLocationView: View {
    
    var person: Person
    var body: some View {
        MapView(annotation: person.getLocation()).edgesIgnoringSafeArea(.all)
    }
}

struct PersonLocationView_Previews: PreviewProvider {
    static var person = Person(name: "Ivan", imagePath: nil,latitude: 0.0,longitude: 0.0,isLocationActive: false )
    static var previews: some View {
        PersonLocationView(person: person)
    }
}
