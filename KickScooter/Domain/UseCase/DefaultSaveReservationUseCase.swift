import Foundation

final class DefaultSaveReservationUseCase: SaveReservationUseCase {
    private let reservationsRepository: ReservationsRepository
    private let userSessionRepository: UserSessionRepository

    init(
        reservationsRepository: ReservationsRepository,
        userSessionRepository: UserSessionRepository
    ) {
        self.reservationsRepository = reservationsRepository
        self.userSessionRepository = userSessionRepository
    }

    func execute(kickScooterID: UUID, address: String) {
        reservationsRepository.save(
            kickScooterID: kickScooterID,
            userID: userSessionRepository.id(),
            address: address
        )
    }
}
