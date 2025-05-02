protocol CredentialsRepository {
    func save(user: UserSignIn)
    func fetch() -> (String, String)?
    func clear()
}
