//
//  PersonView.swift
//  Challenge7
//
//  Created by Domagoj Sutalo on 03.10.2021..
//

import SwiftUI

struct PersonView: View {
    var person: Person
    var body: some View {
        Image(uiImage: person.getImage())
            .resizable()
            .scaledToFit()
            .padding()
    }
}

struct PersonView_Previews: PreviewProvider {
    static var person = Person(name: "Ivan", imagePath: nil)
    static var previews: some View {
        PersonView(person: person)
    }
}
