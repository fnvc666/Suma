//
//  CategoryEntity+CoreDataProperties.swift
//  Suma
//
//  Created by Pavel Pavel on 19/09/2025.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var number: String?
    @NSManaged public var name: String?
    @NSManaged public var budget: Double
    @NSManaged public var current: Double
    @NSManaged public var gradient: String?
    @NSManaged public var currency: String?

}
