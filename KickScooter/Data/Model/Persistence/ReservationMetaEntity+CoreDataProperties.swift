import CoreData
import Foundation

public extension ReservationMetaEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<ReservationMetaEntity> {
        return NSFetchRequest<ReservationMetaEntity>(entityName: "ReservationMetaEntity")
    }

    @NSManaged var date: Date
    @NSManaged var status: Bool
    @NSManaged var kickScooterMeta: KickScooterMetaEntity
    @NSManaged var userMeta: UserMetaEntity
}

extension ReservationMetaEntity: Identifiable {}
