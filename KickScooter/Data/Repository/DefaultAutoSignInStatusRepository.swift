final class DefaultAutoSignInStatusRepository: AutoSignInStatusRepository {
    private let saveAutoSignInStatusDataSource: SaveAutoSignInStatusDataSource
    private let fetchAutoSignInStatusDataSource: FetchAutoSignInStatusDataSource
    private let clearAutoSignInStatusDataSource: ClearAutoSignInStatusDataSource

    init(
        saveAutoSignInStatusDataSource: SaveAutoSignInStatusDataSource,
        fetchAutoSignInStatusDataSource: FetchAutoSignInStatusDataSource,
        clearAutoSignInStatusDataSource: ClearAutoSignInStatusDataSource
    ) {
        self.saveAutoSignInStatusDataSource = saveAutoSignInStatusDataSource
        self.fetchAutoSignInStatusDataSource = fetchAutoSignInStatusDataSource
        self.clearAutoSignInStatusDataSource = clearAutoSignInStatusDataSource
    }

    func save(status: Bool) {
        saveAutoSignInStatusDataSource.execute(status: status)
    }

    func fetch() -> Bool {
        fetchAutoSignInStatusDataSource.execute()
    }

    func clear() {
        clearAutoSignInStatusDataSource.execute()
    }
}
