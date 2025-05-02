import UIKit

final class TabBar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = 120

        return size
    }

    private func configureAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()

        appearance.backgroundEffect = UIBlurEffect(style: .light)
        appearance.backgroundColor = UIColor.triOSSecondaryBackground

        appearance.shadowImage = nil
        appearance.shadowColor = nil

        standardAppearance = appearance
        scrollEdgeAppearance = appearance
    }
}
