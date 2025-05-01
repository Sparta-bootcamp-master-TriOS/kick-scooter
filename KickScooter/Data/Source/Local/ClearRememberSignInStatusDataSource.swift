import Foundation

struct ClearRememberSignInStatusDataSource {
    func execute() {
        UserDefaults.standard.removeObject(forKey: "rememberAccount")
    }
}
