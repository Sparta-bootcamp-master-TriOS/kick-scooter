final class DefaultFetchActiveReservationUseCase: FetchActiveReservationUseCase {
    private let reservationsRepository: ReservationsRepository
    private let userSessionRepository: UserSessionRepository

    init(
        reservationsRepository: ReservationsRepository,
        userSessionRepository: UserSessionRepository
    ) {
        self.reservationsRepository = reservationsRepository
        self.userSessionRepository = userSessionRepository
    }

    func execute() -> Reservation? {
        let userId = userSessionRepository.id()

        return reservationsRepository.active(userID: userId)
    }
}
