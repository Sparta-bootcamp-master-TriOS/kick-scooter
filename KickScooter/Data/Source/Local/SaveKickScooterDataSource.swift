import CoreData

struct SaveKickScooterDataSource {
    private let persistenceController: PersistenceController

    public init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }

    func execute(kickScooter: KickScooterResponse) {
        let context = persistenceController.context

        let entity = KickScooterEntity(context: context)
        entity.id = kickScooter.id
        entity.battery = kickScooter.battery
        entity.type = Int64(kickScooter.type)
        entity.lon = kickScooter.lon
        entity.lat = kickScooter.lat
        entity.isAvailable = kickScooter.isAvailable
    }
}
