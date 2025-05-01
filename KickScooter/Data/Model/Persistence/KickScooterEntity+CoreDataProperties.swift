import CoreData
import Foundation

public extension KickScooterEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<KickScooterEntity> {
        NSFetchRequest<KickScooterEntity>(entityName: "KickScooterEntity")
    }

    @NSManaged var battery: Double
    @NSManaged var id: UUID
    @NSManaged var isAvailable: Bool
    @NSManaged var lat: Double
    @NSManaged var lon: Double
    @NSManaged var type: Int64
    @NSManaged var reservation: ReservationEntity?
}

extension KickScooterEntity: Identifiable {}
