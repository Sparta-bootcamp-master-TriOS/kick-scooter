protocol MapUseCase {
    func excute(query: String, completion: @escaping (Result<[MapResponse], Error>) -> Void)
}
