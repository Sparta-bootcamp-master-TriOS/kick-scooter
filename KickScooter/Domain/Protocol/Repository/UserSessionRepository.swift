protocol UserSessionRepository {
    var user: User? { get }

    func cache(user: User)
    func save()
    func clear()
}
