final class DefaultKickScooterRepository: KickScooterRepository {
    private let saveKickScooterDataSource: SaveKickScooterDataSource

    private let mapper = KickScooterResponseMapper.shared

    init(saveKickScooterDataSource: SaveKickScooterDataSource) {
        self.saveKickScooterDataSource = saveKickScooterDataSource
    }

    func save(kickScooter: KickScooter) {
        saveKickScooterDataSource.execute(kickScooter: mapper.map(from: kickScooter))
    }
}
