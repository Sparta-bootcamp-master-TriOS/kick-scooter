enum MyPageSection: CaseIterable {
    case userProfile
    case yourRide
    case pastRides
    case signOutButton

    var title: String {
        switch self {
        case .userProfile: return ""
        case .yourRide: return "Your Ride"
        case .pastRides: return "Past Rides"
        case .signOutButton: return ""
        }
    }
}
