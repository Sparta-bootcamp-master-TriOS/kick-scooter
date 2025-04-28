protocol UserSessionRepository {
    func cache(user: User)
    func save()
    func clear()
}
