final class DefaultMapUseCase: MapUseCase {
    private let mapRepository: MapRepository

    init(mapRepository: MapRepository) {
        self.mapRepository = mapRepository
    }

    func excute(query: String, completion: @escaping (Result<[MapResponse], any Error>) -> Void) {
        mapRepository.searchAddress(query: query, completion: completion)
    }
}
