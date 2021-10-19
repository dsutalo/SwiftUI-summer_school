//
//  AddPerson.swift
//  Challenge8
//
//  Created by Domagoj Sutalo on 03.10.2021..
//

import SwiftUI

struct AddPersonView: View {
    @Environment (\.presentationMode) var presentationMode
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showPicker = false
    @State private var personName = ""
    @State private var errorAlert = false
    
    let locationFetcher = LocationFetcher()
    @ObservedObject var persons: Persons
    var body: some View {
        Form {
            Section(header: Text("Choose picture")){
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                        .frame(width: 300, height: 300, alignment: .center)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Select picture")
                    }
                }
                .onTapGesture {
                    self.showPicker = true
                }
            }
            
            Section {
                TextField("Input name", text: $personName)
            }
            Section {
                Button(action: addPerson) {
                    Text("Add person")
                }
            }
        }
        .sheet(isPresented: $showPicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
        .alert(isPresented: $errorAlert) {
            Alert(title: Text("Error"), message: Text("You need to input both name and picture"), dismissButton: .default(Text("Understood")))
        }
        .onAppear(perform: {
            locationFetcher.start()
        })
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func addPerson() {
        guard !personName.isEmpty && image != nil else{
            errorAlert = true
            return
        }
        
        var person = Person(name: personName)
        
        if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
            person.setImage(jpegData: jpegData)
        }
        
        if let location = self.locationFetcher.lastKnownLocation {
            print("Your location is \(location)")
            person.latitude = location.latitude
            person.longitude = location.longitude
            person.isLocationActive = true
        }
        
        self.persons.items.append(person)
        presentationMode.wrappedValue.dismiss()
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(persons: Persons())
    }
}

