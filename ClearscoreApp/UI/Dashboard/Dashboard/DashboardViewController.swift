import UIKit

protocol DashboardViewControllerDelegate: AnyObject {
    func viewController(_ viewController: DashboardViewController, wantsToShowDetail creditscore: CreditScoreModel)
}

class DashboardViewController: UIViewController {
    struct Layout {
        static let contentInsets = UIEdgeInsets(top: 16, left: 16, bottom: 8, right: 16)
    }
    
    weak var delegate: DashboardViewControllerDelegate?
    private let interactor: DashboardInteractor
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .textPrimary
        return label
    }()
    
    private let bottomContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var creditScoreView: DashboardCreditscoreView = {
        let view = DashboardCreditscoreView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.addTarget(self, action: #selector(creditscoreTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var errorStateView: DashboardErrorView = {
        let view = DashboardErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .black
        return view
    }()
    
    init(interactor: DashboardInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        interactor.delegate = self
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        addComponents()
        layoutComponents()
        
        interactor.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.standardAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.scrollEdgeAppearance?.configureWithTransparentBackground()
    }
    
    private func addComponents() {
        view.addSubview(titleLabel)
        view.addSubview(bottomContentView)
        bottomContentView.addSubview(creditScoreView)
        bottomContentView.addSubview(errorStateView)
        bottomContentView.addSubview(activityIndicator)
    }

    private func layoutComponents() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Layout.contentInsets.top
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: Layout.contentInsets.left
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -Layout.contentInsets.right
            ),
            
            bottomContentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bottomContentView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: Layout.contentInsets.left
            ),
            bottomContentView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -Layout.contentInsets.right
            ),
            bottomContentView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -Layout.contentInsets.bottom
            ),
            
            creditScoreView.centerXAnchor.constraint(equalTo: bottomContentView.centerXAnchor),
            creditScoreView.centerYAnchor.constraint(equalTo: bottomContentView.centerYAnchor),
            creditScoreView.widthAnchor.constraint(equalTo: bottomContentView.widthAnchor, constant: -32),
            
            errorStateView.centerXAnchor.constraint(equalTo: bottomContentView.centerXAnchor),
            errorStateView.centerYAnchor.constraint(equalTo: bottomContentView.centerYAnchor),
            errorStateView.widthAnchor.constraint(equalTo: bottomContentView.widthAnchor, constant: -32),
            
            activityIndicator.centerXAnchor.constraint(equalTo: bottomContentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: bottomContentView.centerYAnchor)
        ])
    }
    
    private func configure(with viewModel: DashboardViewModel) {
        viewModel.showAsLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        titleLabel.text = viewModel.titleText
        
        if let creditScoreModel = viewModel.creditScoreModel {
            creditScoreView.isHidden = false
            creditScoreView.configure(with: creditScoreModel)
        } else {
            creditScoreView.isHidden = true
        }
        
        if let errorModel = viewModel.errorModel {
            errorStateView.isHidden = false
            errorStateView.configure(with: errorModel)
        } else {
            errorStateView.isHidden = true
        }
    }
    
    @objc private func creditscoreTapped() {
        guard let creditscore = interactor.state.creditscore else { return }
        delegate?.viewController(self, wantsToShowDetail: creditscore)
    }
    
    @objc private func reloadButtonTapped() {
        interactor.load()
    }
}

extension DashboardViewController: DashboardInteractorDelegate {
    func interactor(_ interactor: DashboardInteractor, didUpdateViewModel viewModel: DashboardViewModel) {
        configure(with: viewModel)
    }
}
