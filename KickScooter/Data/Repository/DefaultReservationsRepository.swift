import Foundation

final class DefaultReservationsRepository: ReservationsRepository {
    private let saveReservationDataSource: SaveReservationDataSource

    init(saveReservationDataSource: SaveReservationDataSource) {
        self.saveReservationDataSource = saveReservationDataSource
    }

    func save(kickScooterID: UUID, userID: String) {
        saveReservationDataSource.execute(kickScooterID: kickScooterID, userID: userID)
    }
}
