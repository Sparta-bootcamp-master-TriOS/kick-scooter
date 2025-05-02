final class DIContainer {
    let persistenceController = PersistenceController()
    var userSessionRepository: UserSessionRepository?

    func reset() {
        userSessionRepository = makeUserSessionRepository()
    }
}
