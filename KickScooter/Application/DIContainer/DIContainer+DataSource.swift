extension DIContainer {
    func makeAuthorizeUserDataSource() -> AuthorizeUserDataSource {
        AuthorizeUserDataSource(persistenceController: persistenceController)
    }
}
