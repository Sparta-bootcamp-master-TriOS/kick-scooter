final class DefaultRememberSignInStatusRepository: RememberSignInStatusRepository {
    private let saveRememberSignInStatusDataSource: SaveRememberSignInStatusDataSource
    private let fetchRememberSignInStatusDataSource: FetchRememberSignInStatusDataSource
    private let clearRememberSignInStatusDataSource: ClearRememberSignInStatusDataSource

    init(
        saveRememberSignInStatusDataSource: SaveRememberSignInStatusDataSource,
        fetchRememberSignInStatusDataSource: FetchRememberSignInStatusDataSource,
        clearRememberSignInStatusDataSource: ClearRememberSignInStatusDataSource
    ) {
        self.saveRememberSignInStatusDataSource = saveRememberSignInStatusDataSource
        self.fetchRememberSignInStatusDataSource = fetchRememberSignInStatusDataSource
        self.clearRememberSignInStatusDataSource = clearRememberSignInStatusDataSource
    }

    func save(status: Bool) {
        saveRememberSignInStatusDataSource.execute(status: status)
    }

    func fetch() -> Bool {
        fetchRememberSignInStatusDataSource.execute()
    }

    func clear() {
        clearRememberSignInStatusDataSource.execute()
    }
}
