import Foundation

struct KickScooterResponse {
    let id: UUID
    let battery: Double
    let type: Int
    let lon: String
    let lat: String
    let isAvailable: Bool
}
