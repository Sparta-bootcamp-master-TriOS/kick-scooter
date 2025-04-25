struct UserProfile: Nameable, Emailable, Idable {
    let name: String
    let email: String
    let id: String
    let reservations: [Reservation]
}
