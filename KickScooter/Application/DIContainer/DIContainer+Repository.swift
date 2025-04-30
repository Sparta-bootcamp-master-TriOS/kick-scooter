extension DIContainer {
    func makeAuthorizeUserRepository() -> AuthorizeUserRepository {
        DefaultAuthorizeUserRepository(authorizeUserDataSource: makeAuthorizeUserDataSource())
    }

    func makeUserSessionRepository() -> UserSessionRepository {
        DefaultUserSessionRepository()
    }

    func makeSignUpRepository() -> SignUpRepository {
        DefaultSignUpRepository(signUpDataSource: makeSignUpDataSource())
    }

    func makeVerifyIDAvailabilityRepository() -> VerifyIDAvailabilityRepository {
        DefaultVerifyIDAvailabilityRepository(verifyIDAvailabilityDataSource: makeVerifyIDAvailabilityDataSource())
    }

    func makeMyPageRepository() -> MyPageRepository {
        DefaultMyPageRepository(
            userProfileDataSource: makeUserProfileDataSource(),
            rideHistoryDataSource: makeRideHistoryDataSource()
        )
    }

    func makeMapRepository() -> MapRepository {
        DefaultMapRepository(mapDataSource: makeMapDataSource())
    }

    func makeCredentialsRepository() -> CredentialsRepository {
        DefaultCredentialsRepository(
            saveCredentialsDataSource: makeSaveCredentialsDataSource(),
            fetchCredentialsDataSource: makeFetchCredentialsDataSource()
        )
    }

    func makeRememberSignInStatusRepository() -> RememberSignInStatusRepository {
        DefaultRememberSignInStatusRepository(
            saveRememberSignInStatusDataSource: makeSaveRememberSignInStatusDataSource(),
            fetchRememberSignInStatusDataSource: makeFetchRememberSignInStatusDataSource()
        )
    }

    func makeAutoSignInStatusRepository() -> AutoSignInStatusRepository {
        DefaultAutoSignInStatusRepository(
            saveAutoSignInStatusDataSource: makeSaveAutoSignInStatusDataSource(),
            fetchAutoSignInStatusDataSource: makeFetchAutoSignInStatusDataSource()
        )
    }
}
