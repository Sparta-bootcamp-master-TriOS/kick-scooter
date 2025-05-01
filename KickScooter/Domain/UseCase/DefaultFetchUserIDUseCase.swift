final class DefaultFetchUserIDUseCase: FetchUserIDUseCase {
    private let userSessionRepository: UserSessionRepository

    init(userSessionRepository: UserSessionRepository) {
        self.userSessionRepository = userSessionRepository
    }

    func execute() -> String {
        userSessionRepository.id()
    }
}
