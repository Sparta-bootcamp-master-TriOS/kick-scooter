protocol AuthorizeUserRepository {
    func authorize(user: UserSignIn) -> Result<User, Error>
}
