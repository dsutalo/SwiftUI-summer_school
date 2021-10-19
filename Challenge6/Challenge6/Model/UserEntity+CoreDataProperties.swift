//
//  UserEntity+CoreDataProperties.swift
//  Challenge6
//
//  Created by Domagoj Sutalo on 28.09.2021..
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var address: String?
    @NSManaged public var company: String?
    @NSManaged public var id: String?

    var wrappedId: String {
        return id ?? "15"
    }
    
    var wrappedName: String {
        return name ?? "Ivan"
    }
   
    var wrappedCompany: String {
        return company ?? "KKAK"
    }
    
    var wrappedAddress: String {
        return address ?? "OS"
    }
}

extension UserEntity : Identifiable {

}
