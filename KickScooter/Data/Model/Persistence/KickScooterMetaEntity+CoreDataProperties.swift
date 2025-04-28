import CoreData
import Foundation

public extension KickScooterMetaEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<KickScooterMetaEntity> {
        return NSFetchRequest<KickScooterMetaEntity>(entityName: "KickScooterMetaEntity")
    }

    @NSManaged var battery: Double
    @NSManaged var id: Int64
    @NSManaged var image: String
    @NSManaged var isAvailable: Bool
    @NSManaged var lat: String
    @NSManaged var lon: String
    @NSManaged var model: String
    @NSManaged var price: Int64
    @NSManaged var reservationMeta: ReservationMetaEntity?
}

extension KickScooterMetaEntity: Identifiable {}
