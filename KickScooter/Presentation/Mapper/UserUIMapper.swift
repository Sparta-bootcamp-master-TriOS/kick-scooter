struct UserUIMapper {
    static let shared = UserUIMapper()

    func map(user: UserSignInUI) -> UserSignIn {
        UserSignIn(id: user.id, password: user.password)
    }

    func map(user: UserSignUpUI) -> UserSignUp {
        UserSignUp(
            name: user.name,
            email: user.email,
            id: user.id,
            password: user.password
        )
    }
}
