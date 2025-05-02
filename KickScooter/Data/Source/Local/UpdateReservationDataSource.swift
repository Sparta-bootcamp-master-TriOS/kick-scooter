import CoreData
import Foundation

final class UpdateReservationDataSource {
    private let persisrenceController: PersistenceController

    init(persisrenceController: PersistenceController) {
        self.persisrenceController = persisrenceController
    }

    func execute(reservation: Reservation) {
        let context = persisrenceController.context

        guard let reservationEntity = fetchReservation(by: reservation.id, in: context),
              let kickScooterEntity = fetchKickScooter(by: reservation.kickScooter.id, in: context)
        else {
            return
        }

        kickScooterEntity.isAvailable = true
        kickScooterEntity.lon = reservation.endLon!
        kickScooterEntity.lat = reservation.endLat!

        reservationEntity.status = false
        reservationEntity.endLon = reservation.endLon as NSNumber?
        reservationEntity.endLat = reservation.endLat as NSNumber?
        reservationEntity.endAddress = reservation.endAddress
        reservationEntity.totalTime = reservation.totalTime
        reservationEntity.totalPrice = reservation.totalPrice

        persisrenceController.save()
    }

    private func fetchReservation(by id: UUID, in context: NSManagedObjectContext) -> ReservationEntity? {
        let request = ReservationEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1

        return try? context.fetch(request).first
    }

    private func fetchKickScooter(by id: UUID, in context: NSManagedObjectContext) -> KickScooterEntity? {
        let request = KickScooterEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1

        return try? context.fetch(request).first
    }
}
