protocol MapRepository {
    func searchAddress(query: String, completion: @escaping (Result<[MapResponse], Error>) -> Void)
    func fetchAddress(lon: String, lat: String, completion: @escaping (Result<String, Error>) -> Void)
}
