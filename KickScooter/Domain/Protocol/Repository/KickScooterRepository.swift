protocol KickScooterRepository {
    func save(kickScooter: KickScooter)
    func fetch() -> [KickScooter]
}
