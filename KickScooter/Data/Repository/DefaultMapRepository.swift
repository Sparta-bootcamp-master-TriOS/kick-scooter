final class DefaultMapRepository: MapRepository {
    private let mapDataSource: MapDataSource
    
    init(mapDataSource: MapDataSource) {
        self.mapDataSource = mapDataSource
    }
    
    func searchAddress(query: String, completion: @escaping (Result<[MapResponse], any Error>) -> Void) {
        mapDataSource.searchAddress(query: query, completion: completion)
    }
}
