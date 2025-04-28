extension Coordinator: SignUpViewControllerDelegate {
    func makeSignUpViewController() -> SignUpViewController {
        let viewController = diContainer.makeSignUpViewController()
        viewController.delegate = self

        return viewController
    }

    func pop() {
        navigationController.popViewController(animated: true)
    }
}
