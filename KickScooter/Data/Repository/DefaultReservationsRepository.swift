import Foundation

final class DefaultReservationsRepository: ReservationsRepository {
    private let saveReservationDataSource: SaveReservationDataSource
    private let hasActiveReservation: HasActiveReservation

    init(
        saveReservationDataSource: SaveReservationDataSource,
        hasActiveReservation: HasActiveReservation
    ) {
        self.saveReservationDataSource = saveReservationDataSource
        self.hasActiveReservation = hasActiveReservation
    }

    func save(kickScooterID: UUID, userID: String, address: String) {
        saveReservationDataSource.execute(kickScooterID: kickScooterID, userID: userID, address: address)
    }

    func hasActive(userID: String) -> Bool {
        hasActiveReservation.execute(userID: userID)
    }
}
