import Foundation

struct FetchCredentialsDataSource {
    func execute() -> (String, String)? {
        guard let id = UserDefaults.standard.string(forKey: "savedID"),
              let password = UserDefaults.standard.string(forKey: "savedPassword")
        else {
            return nil
        }
        return (id, password)
    }
}
