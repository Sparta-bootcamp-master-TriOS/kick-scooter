import SnapKit
import UIKit

final class MyPageMap: UIView {
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = .red
    }
}
