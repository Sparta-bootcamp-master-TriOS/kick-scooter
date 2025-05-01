import Foundation

struct ClearAutoSignInStatusDataSource {
    func execute() {
        UserDefaults.standard.removeObject(forKey: "autoSignIn")
    }
}
