import Foundation

protocol SaveReservationUseCase {
    func execute(kickScooterID: UUID, address: String)
}
