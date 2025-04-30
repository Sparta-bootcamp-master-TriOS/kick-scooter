final class DefaultFetchAutoSignInStatusUseCase: FetchAutoSignInStatusUseCase {
    private let autoSignInStatusRepository: AutoSignInStatusRepository

    init(autoSignInStatusRepository: AutoSignInStatusRepository) {
        self.autoSignInStatusRepository = autoSignInStatusRepository
    }

    func execute() -> Bool {
        autoSignInStatusRepository.fetch()
    }
}
