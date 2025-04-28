import SnapKit
import UIKit

final class AddKickScooterViewController: UIViewController {
    private let addScooterViewModel: AddKickScooterViewModel

    private let userProfileView = UserProfileView()
    private let contentView = UIView()
    private let selectedLabel = UILabel()
    private let addKickScooterView = UIView()
    private let batterySelectedView = BatterySelectedView()

    init(addScooterViewModel: AddKickScooterViewModel) {
        self.addScooterViewModel = addScooterViewModel

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureBindings()
    }

    required init?(coder _: NSCoder) {
        nil
    }

    private func configureUI() {
        view.backgroundColor = .purple

        contentView.backgroundColor = .triOSBackground
        contentView.layer.cornerRadius = 20

        let fullText = "Selected Kick Scooter"
        let attributedString = NSMutableAttributedString(string: fullText)
        if let range = fullText.range(of: "Kick Scooter") {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.triOSMain, range: nsRange)
        }
        selectedLabel.attributedText = attributedString
        selectedLabel.font = .systemFont(ofSize: 18)

        addKickScooterView.backgroundColor = .triOSTertiaryBackground
        addKickScooterView.layer.cornerRadius = 20

        batterySelectedView.updateBatteryViews(at: 0)

        [userProfileView, contentView]
            .forEach { view.addSubview($0) }

        [selectedLabel, addKickScooterView]
            .forEach { contentView.addSubview($0) }

        [batterySelectedView]
            .forEach { addKickScooterView.addSubview($0) }

        userProfileView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.equalToSuperview().inset(20)
        }

        contentView.snp.makeConstraints {
            $0.top.equalTo(userProfileView.snp.bottom).offset(20)
            $0.bottom.horizontalEdges.equalToSuperview()
        }

        selectedLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }

        addKickScooterView.snp.makeConstraints {
            $0.top.equalTo(selectedLabel.snp.bottom).offset(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }

        batterySelectedView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.horizontalEdges.equalToSuperview().inset(6)
            $0.height.equalTo(50)
        }
    }

    private func configureBindings() {
        addScooterViewModel.onBatterySelectionChanged = { [weak self] index in
            self?.batterySelectedView.updateBatteryViews(at: index)
        }

        batterySelectedView.onTapped = { [weak self] index in
            self?.addScooterViewModel.selectedBattery(at: index)
        }
    }
}
