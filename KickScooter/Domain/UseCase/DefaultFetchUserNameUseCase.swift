final class DefaultFetchUserNameUseCase: FetchUserNameUseCase {
    private let userSessionRepository: UserSessionRepository

    init(userSessionRepository: UserSessionRepository) {
        self.userSessionRepository = userSessionRepository
    }

    func execute() -> User? {
        userSessionRepository.user
    }
}
