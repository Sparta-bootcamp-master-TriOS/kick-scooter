final class DefaultSaveCredentialsUseCase: SaveCredentialsUseCase {
    private let credentialsRepository: CredentialsRepository

    init(credentialsRepository: CredentialsRepository) {
        self.credentialsRepository = credentialsRepository
    }

    func execute(user: UserSignIn) {
        credentialsRepository.save(user: user)
    }
}
