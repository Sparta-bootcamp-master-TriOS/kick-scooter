final class DefaultClearAutoSignInStatusUseCase: ClearAutoSignInStatusUseCase {
    private let autoSignInStatusRepository: AutoSignInStatusRepository

    init(autoSignInStatusRepository: AutoSignInStatusRepository) {
        self.autoSignInStatusRepository = autoSignInStatusRepository
    }

    func execute() {
        autoSignInStatusRepository.clear()
    }
}
