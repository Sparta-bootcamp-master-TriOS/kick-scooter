import UIKit

final class MapSearchResultView: UIView {
    let tableView = UITableView()

    private let maxHeight: CGFloat = 200
    private let rowHeight: CGFloat = 44

    var searchResults: [MapResponse] = [] {
        didSet {
            tableView.reloadData()
            invalidateIntrinsicContentSize()
        }
    }

    var onItemSelected: ((MapResponse) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        tableView.backgroundColor = .triOSBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
        tableView.rowHeight = rowHeight

        layer.cornerRadius = 8
        layer.masksToBounds = true
    }

    override var intrinsicContentSize: CGSize {
        let height = min(CGFloat(searchResults.count) * rowHeight, maxHeight)
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
}
