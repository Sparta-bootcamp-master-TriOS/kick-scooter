protocol MyPageRepository {
    func fetchUserEntity(_ userId: String) -> UserEntity?
    func fetchreservationEntity(for userId: String) -> [ReservationEntity]?
    func fetchUserProfile(user: UserEntity, rideHistory: [ReservationEntity]) -> UserProfile?
    func updateReservation(reservation: Reservation)
}
