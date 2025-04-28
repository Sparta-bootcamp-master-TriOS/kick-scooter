extension DIContainer {
    func makeAuthorizeUserDataSource() -> AuthorizeUserDataSource {
        AuthorizeUserDataSource(persistenceController: persistenceController)
    }

    func makeSignUpDataSource() -> SignUpDataSource {
        SignUpDataSource(persistenceController: persistenceController)
    }

    func makeVerifyIDAvailabilityDataSource() -> VerifyIDAvailabilityDataSource {
        VerifyIDAvailabilityDataSource(persistenceController: persistenceController)
    }
}
