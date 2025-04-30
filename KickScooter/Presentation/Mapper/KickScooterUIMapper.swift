struct KickScooterUIMapper {
    static let shared = KickScooterUIMapper()

    func map(kickScooter: KickScooter) -> KickScooterUI {
        KickScooterUI(
            id: kickScooter.id,
            model: kickScooter.model,
            battery: "\(kickScooter.battery)",
            price: "\(kickScooter.price)",
            lon: kickScooter.lon,
            lat: kickScooter.lat,
            image: kickScooter.image,
            isAvailable: kickScooter.isAvailable
        )
    }
}
