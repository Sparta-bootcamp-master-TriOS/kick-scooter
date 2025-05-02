protocol MyPageUseCase {
    func fetchUserProfile(_ userId: String) -> UserProfile?
    func updateReservation(reservation: Reservation)
}
