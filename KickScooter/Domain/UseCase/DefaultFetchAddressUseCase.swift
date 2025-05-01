final class DefaultFetchAddressUseCase: FetchAddressUseCase {
    private let mapRepository: MapRepository

    init(mapRepository: MapRepository) {
        self.mapRepository = mapRepository
    }

    func execute(lon: String, lat: String, completion: @escaping (Result<String, any Error>) -> Void) {
        mapRepository.fetchAddress(lon: lon, lat: lat, completion: completion)
    }
}
