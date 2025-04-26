import Foundation

final class SignUpViewModel {
    func verifyKoreanName(_ name: String) -> Bool {
        let regex = "^[가-힣]+$"

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: name)
    }

    func verifyID(_ id: String) -> Bool {
        let regex = "^[a-zA-Z0-9]+$"

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: id)
    }

    func verifyPassword(_ password: String) -> Bool {
        password.count >= 8
    }

    func verifyPasswordsMatch(_ password: String, _ confirmPassword: String) -> Bool {
        password == confirmPassword
    }

    func verifyEmail(_ email: String) -> Bool {
        let regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: email)
    }

    func verifyIDAvailability() -> Bool {
        false
    }

    func signUp(user _: UserSignUpUI) {}
}
