import CoreData
import Foundation

public extension ReservationEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<ReservationEntity> {
        NSFetchRequest<ReservationEntity>(entityName: "ReservationEntity")
    }

    @NSManaged var date: Date
    @NSManaged var status: Bool
    @NSManaged var user: UserEntity
    @NSManaged var kickScooter: KickScooterEntity
}

extension ReservationEntity: Identifiable {}
