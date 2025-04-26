struct UserUIMapper {
    static let shared = UserUIMapper()

    func map(user: UserSignInUI) -> UserSignIn {
        UserSignIn(id: user.id, password: user.password)
    }
}
