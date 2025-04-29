import Foundation

enum GreetingGenerator {
    static func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 6 ..< 12:
            return "Good Morning 👋🏻"
        case 12 ..< 18:
            return "Good Afternoon 👋🏻"
        default:
            return "Good Evening 👋🏻"
        }
    }
}
