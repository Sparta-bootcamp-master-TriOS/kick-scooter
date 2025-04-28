final class SignUpDataSource {
    private let persistenceController: PersistenceController

    public init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }

    func execute(user: UserResponse) {
        let context = persistenceController.context

        let entity = UserEntity(context: context)
        entity.name = user.name
        entity.id = user.id
        entity.password = user.password
        entity.email = user.email

        persistenceController.save()
    }
}
