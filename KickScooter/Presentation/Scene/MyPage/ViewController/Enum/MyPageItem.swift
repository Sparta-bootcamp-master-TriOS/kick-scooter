enum MyPageItem: Hashable {
    case userProfile(UserProfileUI)
    case yourRide(ReservationUI)
    case pastRides(ReservationUI)
    case signOutButton
}
