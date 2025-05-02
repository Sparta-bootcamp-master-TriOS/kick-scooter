protocol RememberSignInStatusRepository {
    func save(status: Bool)
    func fetch() -> Bool
    func clear()
}
