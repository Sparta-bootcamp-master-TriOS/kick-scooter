import CoreData

struct FetchActiveReservation {
    private let persistenceController: PersistenceController

    private let mapper = ReservationResponseMapper.shared

    public init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }

    func execute(userID: String) -> ReservationResponse? {
        let context = persistenceController.context
        let request = ReservationEntity.fetchRequest()

        request.predicate = NSPredicate(format: "user.id == %@ AND status == true", userID)
        request.fetchLimit = 1

        do {
            let results = try context.fetch(request)

            guard let entity = results.first else {
                return nil
            }

            let response = mapper.map(from: entity)

            return response
        } catch {
            return nil
        }
    }
}
