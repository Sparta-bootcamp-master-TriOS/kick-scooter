enum BatteryLevel: Int {
    case high = 0,
         mid,
         low

    var desc: Int {
        switch self {
        case .high: 100
        case .mid: 50
        case .low: 25
        }
    }
}
