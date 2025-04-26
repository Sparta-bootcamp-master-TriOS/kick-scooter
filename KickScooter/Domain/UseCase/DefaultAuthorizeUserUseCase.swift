final class DefaultAuthorizeUserUseCase: AuthorizeUserUseCase {
    private let authorizeUserRepository: AuthorizeUserRepository
    private let userSessionRepository: UserSessionRepository

    init(authorizeUserRepository: AuthorizeUserRepository, userSessionRepository: UserSessionRepository) {
        self.authorizeUserRepository = authorizeUserRepository
        self.userSessionRepository = userSessionRepository
    }

    func execute(user: UserSignIn) -> Result<Void, Error> {
        switch authorizeUserRepository.authorize(user: user) {
        case let .success(user):
            userSessionRepository.cache(user: user)

            return .success(())
        case let .failure(error):
            return .failure(error)
        }
    }
}
