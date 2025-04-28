import UIKit

final class ModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        preferredContentSize = CGSize(width: view.frame.width, height: view.frame.height * 0.8)
    }

    private func configureUI() {
        view.backgroundColor = .triOSBackground
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
    }

    @objc private func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
}
