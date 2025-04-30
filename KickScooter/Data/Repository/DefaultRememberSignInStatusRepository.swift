final class DefaultRememberSignInStatusRepository: RememberSignInStatusRepository {
    private let saveRememberSignInStatusDataSource: SaveRememberSignInStatusDataSource
    private let fetchRememberSignInStatusDataSource: FetchRememberSignInStatusDataSource

    init(
        saveRememberSignInStatusDataSource: SaveRememberSignInStatusDataSource,
        fetchRememberSignInStatusDataSource: FetchRememberSignInStatusDataSource
    ) {
        self.saveRememberSignInStatusDataSource = saveRememberSignInStatusDataSource
        self.fetchRememberSignInStatusDataSource = fetchRememberSignInStatusDataSource
    }

    func save(status: Bool) {
        saveRememberSignInStatusDataSource.execute(status: status)
    }

    func fetch() -> Bool {
        fetchRememberSignInStatusDataSource.execute()
    }
}
