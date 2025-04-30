import Foundation

struct KickScooterUI: Hashable, CoordinatesableUI {
    let id: UUID
    let model: String
    let battery: String
    let price: String
    let lon: String
    let lat: String
    let image: String
    let isAvailable: Bool
}
