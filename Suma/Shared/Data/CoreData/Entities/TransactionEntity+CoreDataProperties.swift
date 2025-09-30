//
//  TransactionEntity+CoreDataProperties.swift
//  Suma
//
//  Created by Pavel Pavel on 30/09/2025.
//
//

import Foundation
import CoreData


extension TransactionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionEntity> {
        return NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var location: String
    @NSManaged public var isSpent: Bool
    @NSManaged public var categoryId: UUID
    @NSManaged public var paymentMethod: String
    @NSManaged public var currency: String

}

extension TransactionEntity : Identifiable {

}
