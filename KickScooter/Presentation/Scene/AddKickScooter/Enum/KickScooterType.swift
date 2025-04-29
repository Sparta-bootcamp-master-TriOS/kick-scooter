enum KickScooterType: Int, CaseIterable {
    case expensive = 0,
         affordable,
         cheap

    var image: String {
        switch self {
        case .expensive: return "KickScooter1"
        case .affordable: return "KickScooter2"
        case .cheap: return "KickScooter3"
        }
    }

    var model: String {
        switch self {
        case .expensive: return "비싼 킥보드"
        case .affordable: return "가성비 킥보드"
        case .cheap: return "저렴한 킥보드"
        }
    }

    var price: String {
        switch self {
        case .expensive: return "5,000"
        case .affordable: return "3,000"
        case .cheap: return "1,000"
        }
    }
}
