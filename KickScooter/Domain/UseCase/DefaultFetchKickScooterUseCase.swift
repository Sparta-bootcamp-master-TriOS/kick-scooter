final class DefaultFetchKickScooterUseCase: FetchKickScooterUseCase {
    private let repository: KickScooterRepository

    init(repository: KickScooterRepository) {
        self.repository = repository
    }

    func execute() -> [KickScooter] {
        repository.fetch()
    }
}
