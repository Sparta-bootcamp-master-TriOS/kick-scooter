struct User: Idable, Passwordable, Nameable, Emailable {
    let id: String
    let password: String
    let name: String
    let email: String
    let reservations: [Reservation]
}
