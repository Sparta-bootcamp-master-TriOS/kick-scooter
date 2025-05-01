final class DefaultMapRepository: MapRepository {
    private let mapDataSource: MapDataSource
    private let fetchAddressDataSource: FetchAddressDataSource

    init(mapDataSource: MapDataSource, fetchAddressDataSource: FetchAddressDataSource) {
        self.mapDataSource = mapDataSource
        self.fetchAddressDataSource = fetchAddressDataSource
    }

    func searchAddress(query: String, completion: @escaping (Result<[MapResponse], any Error>) -> Void) {
        mapDataSource.searchAddress(query: query, completion: completion)
    }

    func fetchAddress(lon: String, lat: String, completion: @escaping (Result<String, Error>) -> Void) {
        fetchAddressDataSource.execute(lon: lon, lat: lat, completion: completion)
    }
}
