final class DefaultClearRememberSignInStatusUseCase: ClearRememberSignInStatusUseCase {
    private let rememberSignInStatusRepository: RememberSignInStatusRepository

    init(rememberSignInStatusRepository: RememberSignInStatusRepository) {
        self.rememberSignInStatusRepository = rememberSignInStatusRepository
    }

    func execute() {
        rememberSignInStatusRepository.clear()
    }
}
