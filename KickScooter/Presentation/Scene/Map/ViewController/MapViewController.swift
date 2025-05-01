import SnapKit
import UIKit

final class MapViewController: UIViewController {
    let mapViewModel: MapViewModel

    private let mapBaseView = MapBaseView()
    private let mapSearchBarView = MapSearchBarView()
    private let mapActionButtonPanel = MapActionButtonPanel()

    private var isScooterVisible = false

    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        configureDelegates()
    }

    private func configureUI() {
        view.bringSubviewToFront(mapSearchBarView)

        [mapBaseView, mapActionButtonPanel, mapSearchBarView]
            .forEach { view.addSubview($0) }

        mapBaseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mapSearchBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(mapActionButtonPanel.snp.leading).offset(-10)
            $0.height.equalTo(44)
        }

        mapActionButtonPanel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(44)
            $0.height.equalTo(92)
        }
    }

    private func bindViewModel() {}

    private func configureDelegates() {
        mapSearchBarView.searchBar.delegate = self
        mapActionButtonPanel.toggleButton.addTarget(
            self,
            action: #selector(toggleScooterVisibility),
            for: .touchUpInside
        )
    }

    @objc private func toggleScooterVisibility() {
        isScooterVisible.toggle()
        mapActionButtonPanel.toggleState(isOn: isScooterVisible)
    }
}
