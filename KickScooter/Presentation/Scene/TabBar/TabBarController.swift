import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    private let addKickScooterViewController: AddKickScooterViewController
    private let testMapVC: TestMapVC
    private let testMyPageVC: TestMyPageVC

    init(
        addKickScooterViewController: AddKickScooterViewController,
        testMapVC: TestMapVC,
        testMyPageVC: TestMyPageVC
    ) {
        self.addKickScooterViewController = addKickScooterViewController
        self.testMapVC = testMapVC
        self.testMyPageVC = testMyPageVC

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        configureTabs()

        DispatchQueue.main.async {
            self.configureTabBarItems()
        }
    }

    private func configureTabs() {
        addKickScooterViewController.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)

        testMapVC.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 1)

        testMyPageVC.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 2)

        viewControllers = [addKickScooterViewController, testMapVC, testMyPageVC]
    }

    private func configureTabBarItems() {
        let icons = ["scooter", "map", "person"]

        let tabBarButtons = tabBar.subviews
            .filter { NSStringFromClass(type(of: $0)).contains("UITabBarButton") }
            .sorted { $0.frame.minX < $1.frame.minX }

        for (index, button) in tabBarButtons.enumerated() {
            button.subviews
                .filter { $0 is TabBarItemView }
                .forEach { $0.removeFromSuperview() }

            let isSelected = index == selectedIndex
            let image = UIImage(systemName: icons[index])!
            let customView = TabBarItemView(image: image, isSelected: isSelected)

            customView.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
            customView.center = CGPoint(x: button.bounds.midX, y: button.bounds.midY - 8)

            button.addSubview(customView)
        }
    }

    func tabBarController(_: UITabBarController, didSelect _: UIViewController) {
        configureTabBarItems()
    }
}
