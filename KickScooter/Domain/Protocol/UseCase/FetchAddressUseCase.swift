protocol FetchAddressUseCase {
    func execute(lon: String, lat: String, completion: @escaping (Result<String, Error>) -> Void)
}
