import Foundation

struct ReservationResponse {
    let date: Date
    let status: Bool = true
    let kickScooter: KickScooterResponse
}
