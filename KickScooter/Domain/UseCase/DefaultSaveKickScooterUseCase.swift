final class DefaultSaveKickScooterUseCase: SaveKickScooterUseCase {
    private let kickScooterRepository: KickScooterRepository

    init(kickScooterRepository: KickScooterRepository) {
        self.kickScooterRepository = kickScooterRepository
    }

    func execute(kickScooter: KickScooter) {
        kickScooterRepository.save(kickScooter: kickScooter)
    }
}
