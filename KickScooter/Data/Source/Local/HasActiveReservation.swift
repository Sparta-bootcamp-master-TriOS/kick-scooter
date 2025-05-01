import CoreData

struct HasActiveReservation {
    private let persistenceController: PersistenceController

    public init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }

    func execute(userID: String) -> Bool {
        let context = persistenceController.context
        let request = ReservationEntity.fetchRequest()

        request.predicate = NSPredicate(format: "user.id == %@ AND status == true", userID)
        request.fetchLimit = 1

        do {
            let results = try context.fetch(request)
            return !results.isEmpty
        } catch {
            return false
        }
    }
}
