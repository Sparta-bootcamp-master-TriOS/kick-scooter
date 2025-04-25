import CoreData
import Foundation

public extension UserEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<UserEntity> {
        NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var id: String
    @NSManaged var password: String
    @NSManaged var reservations: NSSet?
}

// MARK: Generated accessors for reservations

public extension UserEntity {
    @objc(addReservationsObject:)
    @NSManaged func addToReservations(_ value: ReservationEntity)

    @objc(removeReservationsObject:)
    @NSManaged func removeFromReservations(_ value: ReservationEntity)

    @objc(addReservations:)
    @NSManaged func addToReservations(_ values: NSSet)

    @objc(removeReservations:)
    @NSManaged func removeFromReservations(_ values: NSSet)
}

extension UserEntity: Identifiable {}
