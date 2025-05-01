import Foundation

protocol ReservationsRepository {
    func save(kickScooterID: UUID, userID: String, address: String)
    func hasActive(userID: String) -> Bool
}
