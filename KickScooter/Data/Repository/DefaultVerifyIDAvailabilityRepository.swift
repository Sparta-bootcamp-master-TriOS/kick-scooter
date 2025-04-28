final class DefaultVerifyIDAvailabilityRepository: VerifyIDAvailabilityRepository {
    private let verifyIDAvailabilityDataSource: VerifyIDAvailabilityDataSource

    init(verifyIDAvailabilityDataSource: VerifyIDAvailabilityDataSource) {
        self.verifyIDAvailabilityDataSource = verifyIDAvailabilityDataSource
    }

    func isAvailable(_ id: String) -> Bool {
        verifyIDAvailabilityDataSource.execute(id)
    }
}
