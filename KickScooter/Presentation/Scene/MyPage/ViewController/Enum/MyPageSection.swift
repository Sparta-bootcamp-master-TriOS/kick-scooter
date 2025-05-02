enum MyPageSection: CaseIterable {
    case userProfile
    case yourRide
    case pastRides
    case signOutButton

    var title: String {
        switch self {
        case .userProfile: return ""
        case .yourRide: return "이용중인 킥보드"
        case .pastRides: return "지난 이용 내역"
        case .signOutButton: return ""
        }
    }
}
