final class DefaultSaveRememberSignInStatusUseCase: SaveRememberSignInStatusUseCase {
    private let rememberSignInStatusRepository: RememberSignInStatusRepository

    init(rememberSignInStatusRepository: RememberSignInStatusRepository) {
        self.rememberSignInStatusRepository = rememberSignInStatusRepository
    }

    func execute(status: Bool) {
        rememberSignInStatusRepository.save(status: status)
    }
}
