import Foundation

final class DefaultReservationsRepository: ReservationsRepository {
    private let saveReservationDataSource: SaveReservationDataSource
    private let fetchActiveReservation: FetchActiveReservation

    private let mapper = ReservationResponseMapper.shared

    init(
        saveReservationDataSource: SaveReservationDataSource,
        fetchActiveReservation: FetchActiveReservation
    ) {
        self.saveReservationDataSource = saveReservationDataSource
        self.fetchActiveReservation = fetchActiveReservation
    }

    func save(kickScooterID: UUID, userID: String, address: String) {
        saveReservationDataSource.execute(kickScooterID: kickScooterID, userID: userID, address: address)
    }

    func active(userID: String) -> Reservation? {
        guard let response = fetchActiveReservation.execute(userID: userID) else {
            return nil
        }

        return mapper.map(from: response)
    }
}
