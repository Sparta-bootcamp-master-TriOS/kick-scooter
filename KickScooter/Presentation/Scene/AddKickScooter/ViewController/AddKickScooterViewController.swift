import SnapKit
import UIKit

final class AddKickScooterViewController: UIViewController {
    let addKickScooterViewModel: AddKickScooterViewModel

    private let userProfileView = UserProfileView()
    private let contentView = UIView()
    private let selectedLabel = UILabel()
    private let addKickScooterView = UIView()
    private let batterySelectedView = BatterySelectedView()
    lazy var collectionView: UICollectionView = {
        let layout = CenteredFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 250, height: 250)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(KickScooterCell.self, forCellWithReuseIdentifier: "KickScooterCell")
        return collectionView
    }()

    private let kickScooterCell = KickScooterCell()
    let kickScooterDetailView = KickScooterDetailView()
    let pageControl = UIPageControl()
    private let addButton = CommonButton()

    init(addKickScooterViewModel: AddKickScooterViewModel) {
        self.addKickScooterViewModel = addKickScooterViewModel

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureBindings()
        configureConstraints()

        collectionView.reloadData()
    }

    required init?(coder _: NSCoder) {
        nil
    }

    private func configureUI() {
        view.backgroundColor = .purple

        if let userName = addKickScooterViewModel.user() {
            userProfileView.updateUI(wellcom: addKickScooterViewModel.greeting(), name: userName)
        }

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

        kickScooterDetailView.updateUI(with: KickScooterType.allCases[0].model, KickScooterType.allCases[0].price)

        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .lightGray

        addButton.updateUI(backgroundColor: .triOSMain, titleColor: .triOSTertiaryBackground, title: "추가")

        [userProfileView, contentView]
            .forEach { view.addSubview($0) }

        [selectedLabel, addKickScooterView]
            .forEach { contentView.addSubview($0) }

        [batterySelectedView, collectionView, pageControl, kickScooterDetailView, addButton]
            .forEach { addKickScooterView.addSubview($0) }
    }

    private func configureConstraints() {
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
            $0.height.equalTo(48)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(batterySelectedView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(250)
        }

        pageControl.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }

        kickScooterDetailView.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }

        addButton.snp.makeConstraints {
            $0.top.equalTo(kickScooterDetailView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(30)
        }
    }

    private func configureBindings() {
        addKickScooterViewModel.onBatteryChanged = { [weak self] index in
            self?.batterySelectedView.updateBatteryViews(at: index)
        }

        batterySelectedView.onTapped = { [weak self] index in
            self?.addKickScooterViewModel.selectedBattery(at: index)
        }

        addKickScooterViewModel.onKickScooterTypeChanged = { [weak self] index in
            let kickScooter = KickScooterType.allCases[index]
            self?.kickScooterDetailView.updateUI(with: kickScooter.model, kickScooter.price)
        }

        pageControl.numberOfPages = KickScooterType.allCases.count
    }
}
