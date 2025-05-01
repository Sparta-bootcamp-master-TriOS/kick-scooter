final class DefaultCredentialsRepository: CredentialsRepository {
    private let saveCredentialsDataSource: SaveCredentialsDataSource
    private let fetchCredentialsDataSource: FetchCredentialsDataSource
    private let clearCredentialsDataSource: ClearCredentialsDataSource

    init(
        saveCredentialsDataSource: SaveCredentialsDataSource,
        fetchCredentialsDataSource: FetchCredentialsDataSource,
        clearCredentialsDataSource: ClearCredentialsDataSource
    ) {
        self.saveCredentialsDataSource = saveCredentialsDataSource
        self.fetchCredentialsDataSource = fetchCredentialsDataSource
        self.clearCredentialsDataSource = clearCredentialsDataSource
    }

    func save(user: UserSignIn) {
        saveCredentialsDataSource.execute(id: user.id, password: user.password)
    }

    func fetch() -> (String, String)? {
        fetchCredentialsDataSource.execute()
    }

    func clear() {
        clearCredentialsDataSource.execute()
    }
}
