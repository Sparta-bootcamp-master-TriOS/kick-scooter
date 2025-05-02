final class DefaultFetchRememberSignInStatusUseCase: FetchRememberSignInStatusUseCase {
    private let rememberSignInStatusRepository: RememberSignInStatusRepository

    init(rememberSignInStatusRepository: RememberSignInStatusRepository) {
        self.rememberSignInStatusRepository = rememberSignInStatusRepository
    }

    func execute() -> Bool {
        rememberSignInStatusRepository.fetch()
    }
}
