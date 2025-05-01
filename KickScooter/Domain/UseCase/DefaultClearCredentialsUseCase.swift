final class DefaultClearCredentialsUseCase: ClearCredentialsUseCase {
    private let credentialsRepository: CredentialsRepository

    init(credentialsRepository: CredentialsRepository) {
        self.credentialsRepository = credentialsRepository
    }

    func execute() {
        credentialsRepository.clear()
    }
}
