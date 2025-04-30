import SnapKit
import UIKit

final class MapViewController: UIViewController {
    let mapViewModel: MapViewModel

    private let mapBaseView = MapBaseView()
    private let mapSearchBarView = MapSearchBarView()
    private let currentLocationButtonView = CurrentLocationButtonView()

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
        [mapBaseView, mapSearchBarView, currentLocationButtonView]
            .forEach { view.addSubview($0) }

        mapBaseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mapSearchBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(currentLocationButtonView.snp.leading).offset(-10)
            $0.height.equalTo(44)
        }

        currentLocationButtonView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(44)
        }
    }

    private func bindViewModel() {}

    private func configureDelegates() {
        mapSearchBarView.searchBar.delegate = self
    }
}
