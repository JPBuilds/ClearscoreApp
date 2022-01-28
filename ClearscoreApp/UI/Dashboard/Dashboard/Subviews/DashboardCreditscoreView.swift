import UIKit

class DashboardCreditscoreView: UIControl {
    private let scoreCircleLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.lineWidth = 20.0
        shapeLayer.strokeEnd = 1.0
        return shapeLayer
    }()
    
    private let backgroundCircleLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.backgroundHighlight.cgColor
        shapeLayer.fillColor = UIColor.backgroundSecondary.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.strokeEnd = 1
        return shapeLayer
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = false
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .textPrimary
        label.numberOfLines = 0
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 64, weight: .bold)
        label.textAlignment = .center
        label.textColor = .textPrimary
        return label
    }()
    
    private let outOfLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .textPrimary
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.masksToBounds = false
        
        addComponents()
        layoutComponents()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundCircleLayer.fillColor = isHighlighted ?
                UIColor.backgroundHighlight.cgColor :
                UIColor.backgroundSecondary.cgColor
        }
    }
    
    func configure(with viewModel: DashboardViewModel.CreditScoreViewModel) {
        titleLabel.text = viewModel.titleText
        scoreLabel.text = viewModel.scoreText
        scoreLabel.textColor = viewModel.scoreTextColor
        scoreCircleLayer.strokeColor = viewModel.scoreTextColor.cgColor
        outOfLabel.text = viewModel.outOfText
        
        let startAngle = -CGFloat.pi * 0.5
        let percentageAngle = (CGFloat.pi * 2) * viewModel.percentageAngle
        scoreCircleLayer.path = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
            radius: frame.size.width * 0.40,
            startAngle: startAngle,
            endAngle: startAngle + percentageAngle,
            clockwise: true
        ).cgPath
        
        backgroundCircleLayer.path = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
            radius: frame.size.width * 0.5,
            startAngle: startAngle,
            endAngle: (CGFloat.pi * 2),
            clockwise: true
        ).cgPath
    }
    
    private func addComponents() {
        layer.addSublayer(backgroundCircleLayer)
        layer.addSublayer(scoreCircleLayer)
        
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(scoreLabel)
        stackView.addArrangedSubview(outOfLabel)
    }

    private func layoutComponents() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: heightAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.75),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)
        ])
    }
}
