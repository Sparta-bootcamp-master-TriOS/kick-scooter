struct KickScooterResponseMapper {
    static let shared = KickScooterResponseMapper()

    func map(from entity: KickScooterEntity) -> KickScooterResponse {
        KickScooterResponse(
            id: entity.id,
            battery: entity.battery,
            type: Int(entity.type),
            lon: entity.lon,
            lat: entity.lat,
            isAvailable: entity.isAvailable
        )
    }

    func map(from response: KickScooterResponse) -> KickScooter {
        KickScooter(
            id: response.id,
            battery: response.battery,
            type: response.type,
            lon: response.lon,
            lat: response.lat,
            isAvailable: response.isAvailable
        )
    }

    func map(from kickScooter: KickScooter) -> KickScooterResponse {
        KickScooterResponse(
            id: kickScooter.id,
            battery: kickScooter.battery,
            type: kickScooter.type,
            lon: kickScooter.lon,
            lat: kickScooter.lat,
            isAvailable: kickScooter.isAvailable
        )
    }
}
