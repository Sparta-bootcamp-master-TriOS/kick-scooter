protocol MyPageUseCase {
    func fetchUserProfile(_ userId: String) -> UserProfile?
    func updateReservation(userId: String, reservation: Reservation) -> Bool
}
