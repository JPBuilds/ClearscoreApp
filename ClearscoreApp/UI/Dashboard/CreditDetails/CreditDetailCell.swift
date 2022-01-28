import UIKit

class CreditDetailCell: UITableViewCell {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    private let fieldTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .textPrimary
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let fieldValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .textPrimary
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        addComponents()
        layoutComponents()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(with itemModel: CreditDetailsViewModel.TableItem) {
        fieldTitleLabel.text = itemModel.fieldName
        fieldValueLabel.text = itemModel.fieldValue
    }
    
    private func addComponents() {
        addSubview(stackView)
        stackView.addArrangedSubview(fieldTitleLabel)
        stackView.addArrangedSubview(fieldValueLabel)
    }

    private func layoutComponents() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
