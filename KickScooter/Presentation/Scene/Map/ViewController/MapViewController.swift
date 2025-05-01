import CoreLocation
import MapKit
import SnapKit
import UIKit

final class MapViewController: UIViewController {
    let mapViewModel: MapViewModel

    private let mapBaseView = MapBaseView()
    let mapSearchBarView = MapSearchBarView()
    private let mapActionButtonPanel = MapActionButtonPanel()
    let mapSearchResultView = MapSearchResultView()

    private var isScooterVisible = false

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .gray
        return indicator
    }()

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
        bindButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        locateCurrentCoordinate()
    }

    private func configureUI() {
        view.bringSubviewToFront(mapSearchBarView)

        [mapBaseView, mapActionButtonPanel, mapSearchBarView, mapSearchResultView, loadingIndicator]
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

        mapSearchResultView.snp.makeConstraints {
            $0.top.equalTo(mapSearchBarView.snp.bottom)
            $0.leading.trailing.equalTo(mapSearchBarView)
        }
        mapSearchResultView.isHidden = true

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func bindViewModel() {
        mapViewModel.didUpdateKickScooter = { [weak self] scooter in
            let annotations = scooter.map {
                let coordinate = CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lon)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "킥보드"
                return annotation
            }
            self?.mapBaseView.mapView.addAnnotations(annotations)
        }

        mapViewModel.didUpdateResults = { [weak self] in
            guard let self else { return }
            self.mapSearchResultView.searchResults = self.mapViewModel.searchResults
            self.mapSearchResultView.isHidden = self.mapViewModel.searchResults.isEmpty
        }

        mapSearchResultView.onItemSelected = { [weak self] result in
            guard let lat = Double(result.lat),
                  let lon = Double(result.lon) else { return }

            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            self?.mapBaseView.locateCurrentCoordinate(coordinate, zoomLevel: 0.01)
            self?.mapSearchResultView.isHidden = true
            self?.mapSearchBarView.searchBar.resignFirstResponder()
        }
    }

    private func bindButton() {
        mapActionButtonPanel.onLocationButtonTapped = { [weak self] in
            self?.locateCurrentCoordinate()
        }
    }

    private func showPermissionAlert() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = scene.windows.first?.rootViewController else { return }

        let alert = UIAlertController(
            title: "위치 권한 필요",
            message: "킥보드 이용을 위해 위치 접근 권한이 필요합니다.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let locationSettingsURL = URL(string: "App-Prefs:root=Privacy&path=LOCATION") {
                UIApplication.shared.open(locationSettingsURL)
            }
        })

        root.present(alert, animated: true)
    }

    private func configureDelegates() {
        mapSearchBarView.searchBar.delegate = self
        mapActionButtonPanel.toggleButton.addTarget(
            self,
            action: #selector(toggleScooterVisibility),
            for: .touchUpInside
        )
        mapSearchResultView.tableView.dataSource = self
        mapSearchResultView.tableView.delegate = self
    }

    private func locateCurrentCoordinate() {
        showLoadingIndicator()

        mapViewModel.locationManager.requestCurrentLocation(
            onAuthorized: { [weak self] coordinate in
                self?.hideLoadingIndicator()
                self?.mapBaseView.locateCurrentCoordinate(coordinate)
            },
            onDenied: { [weak self] in
                guard let self else { return }

                self.hideLoadingIndicator()

                guard !self.mapViewModel.hasRequestedLocation else { return }
                self.mapViewModel.hasRequestedLocation = true

                self.showPermissionAlert()
            }
        )
    }

    private func showLoadingIndicator() {
        loadingIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }

    private func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }

    @objc private func toggleScooterVisibility() {
        isScooterVisible.toggle()
        mapActionButtonPanel.toggleState(isOn: isScooterVisible)

        if isScooterVisible {
            mapViewModel.locationManager.requestCurrentLocation(
                onAuthorized: { [weak self] coordinate in
                    self?.mapViewModel.loadNearbyKickScooter(userCoordinate: coordinate)
                },
                onDenied: {}
            )
        } else { // 유저 위치는 제거하지 않도록
            mapBaseView.mapView.removeAnnotations(
                mapBaseView.mapView.annotations.filter { !($0 is MKUserLocation) }
            )
        }
    }
}
