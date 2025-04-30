final class DefaultCredentialsRepository: CredentialsRepository {
    private let saveCredentialsDataSource: SaveCredentialsDataSource
    private let fetchCredentialsDataSource: FetchCredentialsDataSource

    init(
        saveCredentialsDataSource: SaveCredentialsDataSource,
        fetchCredentialsDataSource: FetchCredentialsDataSource
    ) {
        self.saveCredentialsDataSource = saveCredentialsDataSource
        self.fetchCredentialsDataSource = fetchCredentialsDataSource
    }

    func save(user: UserSignIn) {
        saveCredentialsDataSource.execute(id: user.id, password: user.password)
    }

    func fetch() -> (String, String)? {
        fetchCredentialsDataSource.execute()
    }
}
