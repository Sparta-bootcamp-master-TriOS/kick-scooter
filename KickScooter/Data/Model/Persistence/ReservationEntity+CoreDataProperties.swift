import CoreData
import Foundation

public extension ReservationEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<ReservationEntity> {
        NSFetchRequest<ReservationEntity>(entityName: "ReservationEntity")
    }

    @NSManaged var date: Date
    @NSManaged var status: Bool
    @NSManaged var startLon: Double
    @NSManaged var startLat: Double
    @NSManaged var endLon: NSNumber?
    @NSManaged var endLat: NSNumber?
    @NSManaged var startAddress: String
    @NSManaged var endAddress: String?
    @NSManaged var totalTime: String?
    @NSManaged var totalPrice: String?
    @NSManaged var kickScooter: KickScooterEntity
    @NSManaged var user: UserEntity
}

extension ReservationEntity: Identifiable {}
