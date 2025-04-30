extension DIContainer {
    func makeAuthorizeUserUseCase() -> AuthorizeUserUseCase {
        DefaultAuthorizeUserUseCase(
            authorizeUserRepository: makeAuthorizeUserRepository(),
            userSessionRepository: userSessionRepository
        )
    }

    func makeSignUpUseCase() -> SignUpUseCase {
        DefaultSignUpUseCase(signUpRepository: makeSignUpRepository())
    }

    func makeVerifyIDAvailabilityUseCase() -> VerifyIDAvailabilityUseCase {
        DefaultVerifyIDAvailabilityUseCase(verifyIDAvailabilityRepository: makeVerifyIDAvailabilityRepository())
    }

    func makeUserNameUseCase() -> UserNameUseCase {
        DefaultUserNameUseCase(userSessionRepository: userSessionRepository)
    }

    func makeMyPageUseCase() -> MyPageUseCase {
        DefaultMyPageUseCase(myPageRepository: makeMyPageRepository())
    }

    func makeMapUseCase() -> MapUseCase {
        DefaultMapUseCase(mapRepository: makeMapRepository())
    }

    func makeSaveKickScooterUseCase() -> SaveKickScooterUseCase {
        DefaultSaveKickScooterUseCase(kickScooterRepository: makeKickScooterRepository())
    }
}
