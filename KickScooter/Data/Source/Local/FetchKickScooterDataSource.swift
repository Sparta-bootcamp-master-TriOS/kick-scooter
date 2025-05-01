import CoreData

struct FetchKickScooterDataSource {
    private let persistenceController: PersistenceController

    public init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }

    func execute() -> [KickScooterResponse] {
        let context = persistenceController.context
        let request = KickScooterEntity.fetchRequest()

        do {
            let entity = try context.fetch(request)
            return entity.map {
                KickScooterResponse(
                    id: $0.id,
                    battery: $0.battery,
                    type: Int($0.type),
                    lon: $0.lon,
                    lat: $0.lat,
                    isAvailable: $0.isAvailable
                )
            }
        } catch {
            return []
        }
    }
}
