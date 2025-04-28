struct KickScooterResponseMapper {
    static let shared = KickScooterResponseMapper()

    func map(from entity: KickScooterEntity) -> KickScooterResponse {
        KickScooterResponse(
            id: entity.id,
            model: entity.model,
            battery: entity.battery,
            price: Int(entity.price),
            lon: entity.lon,
            lat: entity.lat,
            image: entity.image,
            isAvailable: entity.isAvailable
        )
    }

    func map(from response: KickScooterResponse) -> KickScooter {
        KickScooter(
            id: response.id,
            model: response.model,
            battery: response.battery,
            price: response.price,
            lon: response.lon,
            lat: response.lat,
            image: response.image,
            isAvailable: response.isAvailable
        )
    }
}
