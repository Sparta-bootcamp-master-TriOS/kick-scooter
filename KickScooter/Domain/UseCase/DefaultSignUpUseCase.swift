final class DefaultSignUpUseCase: SignUpUseCase {
    private let signUpRepository: SignUpRepository

    init(signUpRepository: SignUpRepository) {
        self.signUpRepository = signUpRepository
    }

    func execute(user: UserSignUp) {
        signUpRepository.save(user: user)
    }
}
