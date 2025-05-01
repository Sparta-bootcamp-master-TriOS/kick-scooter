enum BatteryLevel: Int {
    case high = 0,
         mid,
         low

    var desc: Double {
        switch self {
        case .high: 100.0
        case .mid: 50.0
        case .low: 25.0
        }
    }

    init?(desc: Double) {
        switch desc {
        case 100.0: self = .high
        case 50.0: self = .mid
        case 25.0: self = .low
        default: return nil
        }
    }
}
