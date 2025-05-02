protocol AuthorizeUserUseCase {
    func execute(user: UserSignIn) -> Result<Void, Error>
}
