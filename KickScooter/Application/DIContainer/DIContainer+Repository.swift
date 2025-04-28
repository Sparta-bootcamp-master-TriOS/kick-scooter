extension DIContainer {
    func makeAuthorizeUserRepository() -> AuthorizeUserRepository {
        DefaultAuthorizeUserRepository(authorizeUserDataSource: makeAuthorizeUserDataSource())
    }

    func makeUserSessionRepository() -> UserSessionRepository {
        DefaultUserSessionRepository()
    }
}
