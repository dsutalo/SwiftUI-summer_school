//
//  Person.swift
//  Challenge8
//
//  Created by Domagoj Sutalo on 03.10.2021..
//

import SwiftUI
import CoreLocation
import MapKit


struct Person: Identifiable, Codable {
    let id = UUID()
    let name: String
    var imagePath: String?
    
    //location
    var latitude: Double?
    var longitude: Double?
    var isLocationActive: Bool?
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    mutating func setImage(jpegData: Data) {
        let filename = getDocumentsDirectory().appendingPathComponent(UUID().uuidString)
        try? jpegData.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        self.imagePath = filename.lastPathComponent
    }
    
    func getImageData(person: Person) -> Data? {
        if let imagePath = imagePath {
            let filename = getDocumentsDirectory().appendingPathComponent(imagePath)
            do {
                let data = try Data(contentsOf: filename)
                return data
            } catch {
                print("Unable to load data")
            }
        }
        return nil
    }
    
    func getImage() -> UIImage {
        if let data = self.getImageData(person: self) {
            if let uiImage = UIImage(data: data) {
                return uiImage
            }
        }
        return UIImage(systemName: "person.circle.fill")!
    }
    
    func getLocation() -> MKPointAnnotation{
        let location = MKPointAnnotation()
        location.coordinate.latitude = self.latitude ?? 45.815399
        location.coordinate.longitude = self.longitude ?? 15.966568
        return location
    }
}
