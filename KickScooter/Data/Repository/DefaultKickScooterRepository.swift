final class DefaultKickScooterRepository: KickScooterRepository {
    private let saveKickScooterDataSource: SaveKickScooterDataSource
    private let fetchKickScooterDataSource: FetchKickScooterDataSource

    private let mapper = KickScooterResponseMapper.shared

    init(
        saveKickScooterDataSource: SaveKickScooterDataSource,
        fetchKickScooterDataSource: FetchKickScooterDataSource
    ) {
        self.saveKickScooterDataSource = saveKickScooterDataSource
        self.fetchKickScooterDataSource = fetchKickScooterDataSource
    }

    func save(kickScooter: KickScooter) {
        saveKickScooterDataSource.execute(kickScooter: mapper.map(from: kickScooter))
    }

    func fetch() -> [KickScooter] {
        fetchKickScooterDataSource.execute().map {
            mapper.map(from: $0)
        }
    }
}
