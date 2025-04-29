import CoreData
import Foundation

public extension KickScooterEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<KickScooterEntity> {
        NSFetchRequest<KickScooterEntity>(entityName: "KickScooterEntity")
    }

    @NSManaged var id: UUID
    @NSManaged var model: String
    @NSManaged var battery: Double
    @NSManaged var price: Int64
    @NSManaged var lon: String
    @NSManaged var lat: String
    @NSManaged var image: String
    @NSManaged var isAvailable: Bool
    @NSManaged var reservation: ReservationEntity?
}

extension KickScooterEntity: Identifiable {}
