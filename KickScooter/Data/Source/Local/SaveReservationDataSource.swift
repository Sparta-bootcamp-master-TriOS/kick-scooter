import CoreData
import Foundation

struct SaveReservationDataSource {
    private let persistenceController: PersistenceController

    public init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }

    func execute(kickScooterID: UUID, userID: String) {
        let context = persistenceController.context

        guard let kickScooter = fetchKickScooter(by: kickScooterID, in: context),
              let user = fetchUser(by: userID, in: context)
        else {
            return
        }

        kickScooter.isAvailable = false

        let entity = ReservationEntity(context: context)
        entity.date = Date()
        entity.status = true
        entity.startLon = kickScooter.lon
        entity.startLat = kickScooter.lat
        entity.endLon = nil
        entity.endLat = nil
        entity.startAddress = "임시 시작 주소"
        entity.endAddress = nil
        entity.totalTime = nil
        entity.totalPrice = nil
        entity.kickScooter = kickScooter
        entity.user = user

        persistenceController.save()
    }

    private func fetchKickScooter(by id: UUID, in context: NSManagedObjectContext) -> KickScooterEntity? {
        let request = KickScooterEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1

        return try? context.fetch(request).first
    }

    private func fetchUser(by id: String, in context: NSManagedObjectContext) -> UserEntity? {
        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1

        return try? context.fetch(request).first
    }
}
