//
//  ContentView.swift
//  Challenge8
//
//  Created by Domagoj Sutalo on 03.10.2021..
//

import SwiftUI

struct MainView: View {
    let range = [0,1,2,3,4,5]
    @State private var showImagePicker = false
    @State private var image: Image?
    @State private var showInputName = false
    
    @StateObject var persons = Persons()
    var body: some View {
        NavigationView {
            VStack{
                List(persons.items) { person in
                    NavigationLink(destination: PersonView(person: person)){
                        HStack{
                            Image(uiImage: person.getImage())
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                .frame(width: 100, height: 100, alignment: .center)
                           
                            Text(person.name)
                                
                        }
                    }
                }
                Button(action: {
                    showImagePicker = true
                }) {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                        
                }
            }
            .sheet(isPresented: $showImagePicker) {
                AddPersonView(persons: self.persons)
            }
            .alert(isPresented: $showInputName) {
                Alert(title: Text("Input persons name"), message: nil, dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle("Who is that?")
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(persons)
        
    }
    
//    func getImage(person: Person) -> UIImage {
//        print(person.id)
//        if let data = person.getImageData(person: person) {
//            if let uiImage = UIImage(data: data) {
//                return uiImage
//            }
//        }
//        return UIImage(systemName: "person.circle.fill")!
//    }
    
   
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(persons: Persons())
    }
}
