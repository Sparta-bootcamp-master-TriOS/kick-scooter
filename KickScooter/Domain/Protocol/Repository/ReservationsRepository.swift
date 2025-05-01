import Foundation

protocol ReservationsRepository {
    func save(kickScooterID: UUID, userID: String)
}
