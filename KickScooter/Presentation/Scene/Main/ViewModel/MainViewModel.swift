final class MainViewModel {
    private let authorizeUserUseCase: AuthorizeUserUseCase
    private let saveCredentialsUseCase: SaveCredentialsUseCase
    private let fetchCredentialsUseCase: FetchCredentialsUseCase
    private let saveRememberSignInStatusUseCase: SaveRememberSignInStatusUseCase
    private let fetchRememberSignInStatusUseCase: FetchRememberSignInStatusUseCase
    private let saveAutoSignInStatusUseCase: SaveAutoSignInStatusUseCase
    private let fetchAutoSignInStatusUseCase: FetchAutoSignInStatusUseCase

    private let mapper = UserUIMapper.shared

    private(set) var didApplyCredentials = false
    private(set) var credentials: (id: String, password: String)?
    private(set) var rememberSignInStatus = false
    private(set) var autoSignInStatus = false

    init(
        authorizeUserUseCase: AuthorizeUserUseCase,
        saveCredentialsUseCase: SaveCredentialsUseCase,
        fetchCredentialsUseCase: FetchCredentialsUseCase,
        saveRememberSignInStatusUseCase: SaveRememberSignInStatusUseCase,
        fetchRememberSignInStatusUseCase: FetchRememberSignInStatusUseCase,
        saveAutoSignInStatusUseCase: SaveAutoSignInStatusUseCase,
        fetchAutoSignInStatusUseCase: FetchAutoSignInStatusUseCase
    ) {
        self.authorizeUserUseCase = authorizeUserUseCase
        self.saveCredentialsUseCase = saveCredentialsUseCase
        self.fetchCredentialsUseCase = fetchCredentialsUseCase
        self.saveRememberSignInStatusUseCase = saveRememberSignInStatusUseCase
        self.fetchRememberSignInStatusUseCase = fetchRememberSignInStatusUseCase
        self.saveAutoSignInStatusUseCase = saveAutoSignInStatusUseCase
        self.fetchAutoSignInStatusUseCase = fetchAutoSignInStatusUseCase
    }

    func savedCredentials() {
        rememberSignInStatus = fetchRememberSignInStatusUseCase.execute()
        autoSignInStatus = fetchAutoSignInStatusUseCase.execute()
        credentials = fetchCredentialsUseCase.execute()
    }

    func authorize(user userUI: UserSignInUI) -> Bool {
        let user = mapper.map(user: userUI)

        switch authorizeUserUseCase.execute(user: user) {
        case .success:
            saveRememberSignInStatus()
            saveAutoSignInStatus()

            if rememberSignInStatus || autoSignInStatus {
                saveCredentials(user: user)
            }
            return true
        case .failure:
            return false
        }
    }

    func signIn() {
        guard let (id, password) = credentials else {
            return
        }

        let user = UserSignIn(id: id, password: password)

        _ = authorizeUserUseCase.execute(user: user)
    }

    func toggleRememberSignInStatus(status: Bool) {
        rememberSignInStatus = status
    }

    func toggleAutoSignInStatus(status: Bool) {
        autoSignInStatus = status
    }

    func toggleDidApplyCredentials() {
        didApplyCredentials.toggle()
    }

    private func saveCredentials(user: UserSignIn) {
        saveCredentialsUseCase.execute(user: user)
    }

    private func saveRememberSignInStatus() {
        saveRememberSignInStatusUseCase.execute(status: rememberSignInStatus)
    }

    private func saveAutoSignInStatus() {
        saveAutoSignInStatusUseCase.execute(status: autoSignInStatus)
    }
}
