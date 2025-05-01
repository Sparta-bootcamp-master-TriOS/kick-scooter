import CoreLocation
import MapKit
import SnapKit
import UIKit

final class MapViewController: UIViewController {
    let mapViewModel: MapViewModel

    var currentCalloutView: KickScooterCalloutView?
    private let mapBaseView = MapBaseView()
    private let mapSearchBarView = MapSearchBarView()
    private let mapActionButtonPanel = MapActionButtonPanel()

    private var isScooterVisible = true
    var currentAnnotationCoordinate: CLLocationCoordinate2D?

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

    override func viewWillAppear(_: Bool) {
        fetchKickScooterData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        locateCurrentCoordinate()
    }

    private func configureUI() {
        view.bringSubviewToFront(mapSearchBarView)

        mapActionButtonPanel.toggleState(isOn: isScooterVisible)

        mapBaseView.mapView.delegate = self

        [mapBaseView, mapActionButtonPanel, mapSearchBarView, loadingIndicator]
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

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func bindViewModel() {
        mapViewModel.didUpdateKickScooter = { [weak self] scooters in
            let annotations = scooters.map { scooter in
                let coordinate = CLLocationCoordinate2D(latitude: scooter.lat, longitude: scooter.lon)
                return KickScooterAnnotation(coordinate: coordinate, kickScooter: scooter)
            }

            self?.mapBaseView.mapView.addAnnotations(annotations)
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

    private func fetchKickScooterData() {
        mapViewModel.locationManager.requestCurrentLocation(
            onAuthorized: { [weak self] coordinate in
                self?.mapViewModel.loadNearbyKickScooter(userCoordinate: coordinate)
            },
            onDenied: {}
        )
    }

    @objc private func toggleScooterVisibility() {
        isScooterVisible.toggle()
        mapActionButtonPanel.toggleState(isOn: isScooterVisible)

        if isScooterVisible {
            fetchKickScooterData()
        } else { // 유저 위치는 제거하지 않도록
            mapBaseView.mapView.removeAnnotations(
                mapBaseView.mapView.annotations.filter { !($0 is MKUserLocation) }
            )
        }
    }
}
