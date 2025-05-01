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
        DefaultMapRepository(
            mapDataSource: makeMapDataSource(),
            fetchAddressDataSource: makeFetchAddressDataSource()
        )
    }

    func makeKickScooterRepository() -> KickScooterRepository {
        DefaultKickScooterRepository(
            saveKickScooterDataSource: makeSaveKickScooterDataSource(),
            fetchKickScooterDataSource: makeFetchKickScooterDataSource()
        )
    }

    func makeCredentialsRepository() -> CredentialsRepository {
        DefaultCredentialsRepository(
            saveCredentialsDataSource: makeSaveCredentialsDataSource(),
            fetchCredentialsDataSource: makeFetchCredentialsDataSource(),
            clearCredentialsDataSource: makeClearCredentialsDataSource()
        )
    }

    func makeRememberSignInStatusRepository() -> RememberSignInStatusRepository {
        DefaultRememberSignInStatusRepository(
            saveRememberSignInStatusDataSource: makeSaveRememberSignInStatusDataSource(),
            fetchRememberSignInStatusDataSource: makeFetchRememberSignInStatusDataSource(),
            clearRememberSignInStatusDataSource: makeClearRememberSignInStatusDataSource()
        )
    }

    func makeAutoSignInStatusRepository() -> AutoSignInStatusRepository {
        DefaultAutoSignInStatusRepository(
            saveAutoSignInStatusDataSource: makeSaveAutoSignInStatusDataSource(),
            fetchAutoSignInStatusDataSource: makeFetchAutoSignInStatusDataSource(),
            clearAutoSignInStatusDataSource: makeClearAutoSignInStatusDataSource()
        )
    }

    func makeReservationsRepository() -> ReservationsRepository {
        DefaultReservationsRepository(saveReservationDataSource: makeSaveReservationDataSource())
    }
}
