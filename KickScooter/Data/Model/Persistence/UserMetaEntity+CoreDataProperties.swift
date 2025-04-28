import CoreData
import Foundation

public extension UserMetaEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<UserMetaEntity> {
        return NSFetchRequest<UserMetaEntity>(entityName: "UserMetaEntity")
    }

    @NSManaged var email: String
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var password: String
    @NSManaged var reservationsMeta: NSSet?
}

// MARK: Generated accessors for reservationsMeta

public extension UserMetaEntity {
    @objc(addReservationsMetaObject:)
    @NSManaged func addToReservationsMeta(_ value: ReservationMetaEntity)

    @objc(removeReservationsMetaObject:)
    @NSManaged func removeFromReservationsMeta(_ value: ReservationMetaEntity)

    @objc(addReservationsMeta:)
    @NSManaged func addToReservationsMeta(_ values: NSSet)

    @objc(removeReservationsMeta:)
    @NSManaged func removeFromReservationsMeta(_ values: NSSet)
}

extension UserMetaEntity: Identifiable {}
