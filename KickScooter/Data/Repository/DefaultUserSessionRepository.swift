final class DefaultUserSessionRepository: UserSessionRepository {
    private(set) var user: User?

    func cache(user: User) {
        self.user = user
    }

    func id() -> String {
        user!.id
    }
}
