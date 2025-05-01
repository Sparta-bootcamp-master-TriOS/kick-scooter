import Foundation

struct KickScooter: Coordinatesable {
    let id: UUID
    let battery: Double
    let type: Int
    let lon: Double
    let lat: Double
    let isAvailable: Bool
}
