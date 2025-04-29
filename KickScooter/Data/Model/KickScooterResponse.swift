import Foundation

struct KickScooterResponse {
    let id: UUID
    let model: String
    let battery: Double
    let price: Int
    let lon: String
    let lat: String
    let image: String
    let isAvailable: Bool
}
