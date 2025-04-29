protocol MapRepository {
    func searchAddress(query: String, completion: @escaping (Result<[MapResponse], Error>) -> Void)
}
