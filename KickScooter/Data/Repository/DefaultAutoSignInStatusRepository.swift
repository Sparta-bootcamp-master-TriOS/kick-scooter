final class DefaultAutoSignInStatusRepository: AutoSignInStatusRepository {
    private let saveAutoSignInStatusDataSource: SaveAutoSignInStatusDataSource
    private let fetchAutoSignInStatusDataSource: FetchAutoSignInStatusDataSource

    init(
        saveAutoSignInStatusDataSource: SaveAutoSignInStatusDataSource,
        fetchAutoSignInStatusDataSource: FetchAutoSignInStatusDataSource
    ) {
        self.saveAutoSignInStatusDataSource = saveAutoSignInStatusDataSource
        self.fetchAutoSignInStatusDataSource = fetchAutoSignInStatusDataSource
    }

    func save(status: Bool) {
        saveAutoSignInStatusDataSource.execute(status: status)
    }

    func fetch() -> Bool {
        fetchAutoSignInStatusDataSource.execute()
    }
}
