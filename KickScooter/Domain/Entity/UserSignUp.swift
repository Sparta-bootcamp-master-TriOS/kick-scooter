struct UserSignUp: Nameable, Emailable, Idable, Passwordable {
    let name: String
    let email: String
    let id: String
    let password: String
}
