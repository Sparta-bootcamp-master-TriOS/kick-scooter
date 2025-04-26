final class DefaultAuthorizeUserRepository: AuthorizeUserRepository {
    private let authorizeUserDataSource: AuthorizeUserDataSource

    private let mapper = UserResponseMapper.shared

    init(authorizeUserDataSource: AuthorizeUserDataSource) {
        self.authorizeUserDataSource = authorizeUserDataSource
    }

    func authorize(user: UserSignIn) -> Result<User, Error> {
        switch authorizeUserDataSource.execute(user: user) {
        case let .success(userResponse):
            let user = mapper.map(from: userResponse)

            return .success(user)
        case let .failure(error):
            return .failure(error)
        }
    }
}
