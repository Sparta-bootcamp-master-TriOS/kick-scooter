final class DefaultHasActiveReservationUseCase: HasActiveReservationUseCase {
    private let reservationsRepository: ReservationsRepository
    private let userSessionRepository: UserSessionRepository

    init(
        reservationsRepository: ReservationsRepository,
        userSessionRepository: UserSessionRepository
    ) {
        self.reservationsRepository = reservationsRepository
        self.userSessionRepository = userSessionRepository
    }

    func execute() -> Bool {
        let userId = userSessionRepository.id()

        return reservationsRepository.hasActive(userID: userId)
    }
}
