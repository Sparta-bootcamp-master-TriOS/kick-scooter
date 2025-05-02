struct UserProfileUI: Hashable, NameableUI, EmailableUI, IdableUI {
    let name: String
    let email: String
    let id: String
//    let reservations: [ReservationUI]
    var reservations: [ReservationUI]
}
