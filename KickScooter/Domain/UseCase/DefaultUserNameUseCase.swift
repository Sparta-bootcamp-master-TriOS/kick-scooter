final class DefaultUserNameUseCase: UserNameUseCase {
    private let userSessionRepository: UserSessionRepository

    init(userSessionRepository: UserSessionRepository) {
        self.userSessionRepository = userSessionRepository
    }

    func execute() -> User? {
        userSessionRepository.user
    }
}
