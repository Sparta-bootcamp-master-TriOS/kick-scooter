import Foundation

protocol ReservationsRepository {
    func save(kickScooterID: UUID, userID: String, address: String)
    func active(userID: String) -> Reservation?
}
