struct UserUIMapper {
    static let shared = UserUIMapper()

    func map(id: String, password: String) -> UserSignIn {
        UserSignIn(id: id, password: password)
    }
}
