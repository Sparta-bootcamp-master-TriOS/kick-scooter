final class DIContainer {
    let persistenceController = PersistenceController()

    lazy var userSessionRepository = makeUserSessionRepository()
}
