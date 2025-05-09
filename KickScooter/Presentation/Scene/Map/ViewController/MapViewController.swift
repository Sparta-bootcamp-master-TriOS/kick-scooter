import CoreLocation
import MapKit
import SnapKit
import UIKit

final class MapViewController: UIViewController {
    let mapViewModel: MapViewModel

    private let mapBaseView = MapBaseView()
    let mapSearchBarWrapperView = MapSearchBarWrapperView()
    private let mapActionButtonPanelWrapper = MapActionButtonPanelWrapper()
    let mapSearchResultView = MapSearchResultView()

    private var isScooterVisible: Bool {
        get { mapViewModel.isScooterVisible }
        set {
            mapViewModel.isScooterVisible = newValue
            mapActionButtonPanelWrapper.toggleState(isOn: newValue)
        }
    }

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        mapActionButtonPanelWrapper.toggleState(isOn: mapViewModel.isScooterVisible)

        if mapViewModel.isScooterVisible {
            fetchKickScooterData()
        } else {
            mapBaseView.mapView.removeAnnotations(
                mapBaseView.mapView.annotations.filter { !($0 is MKUserLocation) }
            )
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        locateCurrentCoordinate()
        if isScooterVisible {
            startLiveScooterTracking()
        }
    }

    private func configureUI() {
        view.bringSubviewToFront(mapSearchBarWrapperView)

        mapBaseView.mapView.delegate = self

        [mapBaseView, mapActionButtonPanelWrapper, mapSearchBarWrapperView, mapSearchResultView, loadingIndicator]
            .forEach { view.addSubview($0) }

        mapBaseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mapSearchBarWrapperView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(mapActionButtonPanelWrapper.snp.leading).offset(-10)
            $0.height.equalTo(44)
        }

        mapActionButtonPanelWrapper.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(44)
            $0.height.equalTo(92)
        }

        mapSearchResultView.snp.makeConstraints {
            $0.top.equalTo(mapSearchBarWrapperView.snp.bottom)
            $0.leading.trailing.equalTo(mapSearchBarWrapperView)
        }
        mapSearchResultView.isHidden = true

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func bindViewModel() {
        mapViewModel.didUpdateKickScooter = { [weak self] scooters in
            guard let self else { return }

            let existingAnnotations = self.mapBaseView.mapView.annotations.filter {
                $0 is KickScooterAnnotation
            }
            self.mapBaseView.mapView.removeAnnotations(existingAnnotations)

            let annotations = scooters.map { scooter in
                let coordinate = CLLocationCoordinate2D(latitude: scooter.lat, longitude: scooter.lon)
                return KickScooterAnnotation(coordinate: coordinate, kickScooter: scooter)
            }

            self.mapBaseView.mapView.addAnnotations(annotations)
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
            self?.mapBaseView.locateCurrentCoordinate(coordinate)
            self?.mapSearchResultView.isHidden = true
            self?.mapSearchBarWrapperView.searchBar.resignFirstResponder()
        }
    }

    private func bindButton() {
        mapActionButtonPanelWrapper.onLocationButtonTapped = { [weak self] in
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
        mapSearchBarWrapperView.searchBar.delegate = self
        mapActionButtonPanelWrapper.toggleButton.addTarget(
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

    private func fetchKickScooterData() {
        mapViewModel.locationManager.requestCurrentLocation(
            onAuthorized: { [weak self] coordinate in
                self?.mapViewModel.loadNearbyKickScooter(userCoordinate: coordinate)
            },
            onDenied: {}
        )
    }

    private func startLiveScooterTracking() {
        mapViewModel.locationManager.startTrackingLocation { [weak self] coordinate in
            self?.mapViewModel.loadNearbyKickScooter(userCoordinate: coordinate)
            self?.mapBaseView.locateCurrentCoordinate(coordinate)
        }
    }

    private func stopLiveScooterTracking() {
        mapViewModel.locationManager.stopTrackingLocation()
    }

    @objc private func toggleScooterVisibility() {
        isScooterVisible.toggle()

        if isScooterVisible {
            startLiveScooterTracking()
            fetchKickScooterData()
        } else {
            stopLiveScooterTracking()
            mapBaseView.mapView.removeAnnotations(
                mapBaseView.mapView.annotations.filter { !($0 is MKUserLocation) }
            )
        }
    }
}
