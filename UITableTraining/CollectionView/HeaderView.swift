import UIKit

class HeaderView: UICollectionReusableView {
    static let identifier = "HeaderView"

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.frame = bounds // Автоматичне масштабування під розмір заголовка
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String) {
        label.text = title
    }
}
