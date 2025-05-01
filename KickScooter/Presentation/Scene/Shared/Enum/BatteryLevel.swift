import UIKit

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

    var symbolImage: UIImage? {
        let symbolName: String
        let tintColor: UIColor

        switch self {
        case .high:
            symbolName = "battery.100"
            tintColor = .triOSHighBattery
        case .mid:
            symbolName = "battery.50"
            tintColor = .triOSMidBattery
        case .low:
            symbolName = "battery.25"
            tintColor = .triOSLowBattery
        }

        return UIImage(systemName: symbolName)?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
    }

    init?(desc: Double) {
        switch desc {
        case 100.0: self = .high
        case 50.0: self = .mid
        case 25.0: self = .low
        default: return nil
        }
    }

    init?(desc: String) {
        switch desc {
        case "100.0": self = .high
        case "50.0": self = .mid
        case "25.0": self = .low
        default: return nil
        }
    }
}
