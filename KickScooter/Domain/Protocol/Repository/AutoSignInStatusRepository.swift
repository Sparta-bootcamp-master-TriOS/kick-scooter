protocol AutoSignInStatusRepository {
    func save(status: Bool)
    func fetch() -> Bool
}
