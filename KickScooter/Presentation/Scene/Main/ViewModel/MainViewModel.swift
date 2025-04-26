final class MainViewModel {
    private let authorizeUserUseCase: AuthorizeUserUseCase

    private let mapper = UserUIMapper.shared

    init(authorizeUserUseCase: AuthorizeUserUseCase) {
        self.authorizeUserUseCase = authorizeUserUseCase
    }

    func authorize(user userUI: UserSignInUI) -> Bool {
        let user = mapper.map(user: userUI)

        switch authorizeUserUseCase.execute(user: user) {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}
