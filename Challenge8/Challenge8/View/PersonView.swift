//
//  PersonView.swift
//  Challenge8
//
//  Created by Domagoj Sutalo on 03.10.2021..
//

import SwiftUI

struct PersonView: View {
    var person: Person
    
    var body: some View {
        Form {
           
            Section(header: Text("Persons picture")) {
                Image(uiImage: person.getImage())
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            Section(header: Text("Person name")) {
                Text("\(person.name)")
            }
            Section(header: Text("Coordinates of taken picture")) {
                Text("Latitude: \(person.latitude ?? 0.0)")
                Text("Longitude: \(person.longitude ?? 0.0)")
                NavigationLink(destination: PersonLocationView(person: person)){
                    Button(action: {
                    }) {
                        Text("Show on map")
                    }
                }
                
            }
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var person = Person(name: "Ivan", imagePath: nil)
    static var previews: some View {
        PersonView(person: person)
    }
}
