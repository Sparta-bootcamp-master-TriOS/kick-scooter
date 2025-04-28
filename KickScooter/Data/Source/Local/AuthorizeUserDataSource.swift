import Foundation

final class AuthorizeUserDataSource {
    private let persistenceController: PersistenceController
    private let mapper = UserResponseMapper.shared

    public init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }

    func execute(user: UserSignIn) -> Result<UserResponse, Error> {
        let context = persistenceController.context

        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@ AND password == %@", user.id, user.password)
        request.fetchLimit = 1

        do {
            let result = try context.fetch(request)

            guard let userEntity = result.first else {
                return .failure(AuthorizeError.userNotFound)
            }

            let user = mapper.map(from: userEntity)

            return .success(user)
        } catch {
            return .failure(error)
        }
    }
}
