import Foundation

final class VerifyIDAvailabilityDataSource {
    private let persistenceController: PersistenceController

    public init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }

    func execute(_ id: String) -> Bool {
        let context = persistenceController.context

        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1

        guard let result = try? context.fetch(request) else {
            return false
        }

        return result.first == .none
    }
}
