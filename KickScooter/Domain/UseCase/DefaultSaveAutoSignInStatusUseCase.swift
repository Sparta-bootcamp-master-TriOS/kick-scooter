final class DefaultSaveAutoSignInStatusUseCase: SaveAutoSignInStatusUseCase {
    private let autoSignInStatusRepository: AutoSignInStatusRepository

    init(autoSignInStatusRepository: AutoSignInStatusRepository) {
        self.autoSignInStatusRepository = autoSignInStatusRepository
    }

    func execute(status: Bool) {
        autoSignInStatusRepository.save(status: status)
    }
}
