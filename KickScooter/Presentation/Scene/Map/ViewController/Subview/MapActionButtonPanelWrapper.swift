import SnapKit
import UIKit

final class MapActionButtonPanelWrapper: UIView {
    let mapActionButtonPanel = MapActionButtonPanel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureShadow()
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureShadow() {
        backgroundColor = .clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }

    private func configureUI() {
        addSubview(mapActionButtonPanel)

        mapActionButtonPanel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    var toggleButton: UIButton { mapActionButtonPanel.toggleButton }
    var locationButton: UIButton { mapActionButtonPanel.locationButton }

    var onLocationButtonTapped: (() -> Void)? {
        get { mapActionButtonPanel.onLocationButtonTapped }
        set { mapActionButtonPanel.onLocationButtonTapped = newValue }
    }

    func toggleState(isOn: Bool) {
        mapActionButtonPanel.toggleState(isOn: isOn)
    }
}
