final class MainViewModel {
    private let authorizeUserUseCase: AuthorizeUserUseCase

    private let mapper = UserUIMapper.shared

    init(authorizeUserUseCase: AuthorizeUserUseCase) {
        self.authorizeUserUseCase = authorizeUserUseCase
    }

    func authorize(id: String, password: String) -> Bool {
        let user = mapper.map(id: id, password: password)

        switch authorizeUserUseCase.execute(user: user) {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}
