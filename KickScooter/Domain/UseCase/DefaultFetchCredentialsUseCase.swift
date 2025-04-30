final class DefaultFetchCredentialsUseCase: FetchCredentialsUseCase {
    private let credentialsRepository: CredentialsRepository

    init(credentialsRepository: CredentialsRepository) {
        self.credentialsRepository = credentialsRepository
    }

    func execute() -> (String, String)? {
        credentialsRepository.fetch()
    }
}
