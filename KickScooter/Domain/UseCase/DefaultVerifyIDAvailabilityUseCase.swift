final class DefaultVerifyIDAvailabilityUseCase: VerifyIDAvailabilityUseCase {
    private let verifyIDAvailabilityRepository: VerifyIDAvailabilityRepository

    init(verifyIDAvailabilityRepository: VerifyIDAvailabilityRepository) {
        self.verifyIDAvailabilityRepository = verifyIDAvailabilityRepository
    }

    func execute(_ id: String) -> Bool {
        verifyIDAvailabilityRepository.isAvailable(id)
    }
}
