import Foundation

struct FetchAutoSignInStatusDataSource {
    func execute() -> Bool {
        UserDefaults.standard.bool(forKey: "autoSignIn")
    }
}
