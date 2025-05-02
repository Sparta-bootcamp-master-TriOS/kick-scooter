import Foundation

enum Formatter {
    static func getTotalTime(from startTime: Date) -> String {
        let endTime = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.hour, .minute, .second],
            from: startTime,
            to: endTime
        )

        guard let hour = components.hour,
              let minute = components.minute,
              let second = components.second
        else {
            return ""
        }

        return String(format: "%02d시간 %02d분 %02d초", hour, minute, second)
    }

    static func getFormattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }

    static func totalPrice(from startTime: Date, price: Int) -> String {
        let endTime = Date()
        let totalSeconds = endTime.timeIntervalSince(startTime)
        let totalHours = Int(ceil(totalSeconds / 3600.0))
        let totalPrice = totalHours * price

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "ko_KR")

        if let formattedPrice = formatter.string(from: NSNumber(value: totalPrice)) {
            return "\(formattedPrice)원"
        } else {
            return "\(totalPrice)원"
        }
    }
}
