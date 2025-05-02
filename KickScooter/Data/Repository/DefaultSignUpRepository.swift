final class DefaultSignUpRepository: SignUpRepository {
    private let signUpDataSource: SignUpDataSource

    private let mapper = UserResponseMapper()

    init(signUpDataSource: SignUpDataSource) {
        self.signUpDataSource = signUpDataSource
    }

    func save(user: UserSignUp) {
        signUpDataSource.execute(user: mapper.map(from: user))
    }
}
